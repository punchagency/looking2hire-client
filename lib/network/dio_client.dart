import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Custom exceptions
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({required this.message, this.statusCode, this.data});

  @override
  String toString() => 'ApiException: $message';
}

class AuthenticationException extends ApiException {
  AuthenticationException({super.message = 'Authentication failed'})
    : super(statusCode: 401);
}

class TokenExpiredException extends AuthenticationException {
  TokenExpiredException() : super(message: 'Token has expired');
}

typedef RefreshTokenCallback = Future<String?> Function();
typedef OnUnauthorizedCallback = Future<void> Function();

// Authentication types
enum AuthType { none, basic, bearer, custom }

class AuthConfig {
  final AuthType type;
  final String? prefix;
  final String? customHeaderKey;

  const AuthConfig({
    this.type = AuthType.bearer,
    this.prefix,
    this.customHeaderKey,
  });

  static const AuthConfig bearer = AuthConfig(
    type: AuthType.bearer,
    prefix: 'Bearer',
  );
  static const AuthConfig basic = AuthConfig(
    type: AuthType.basic,
    prefix: 'Basic',
  );

  String formatToken(String token) {
    switch (type) {
      case AuthType.basic:
        // For basic auth, token should be "username:password"
        return 'Basic ${base64Encode(utf8.encode(token))}';
      case AuthType.bearer:
        return 'Bearer $token';
      case AuthType.custom:
        return token;
      case AuthType.none:
        return token;
    }
  }
}

// API Response wrapper
class ApiResponse<T> {
  final T? data;
  final Response? response;
  final bool success;
  final String? message;
  final int? statusCode;
  final dynamic error;

  ApiResponse({
    this.data,
    this.response,
    required this.success,
    this.message,
    this.statusCode,
    this.error,
  });

  factory ApiResponse.success({
    T? data,
    Response? response,
    String? message,
    int? statusCode,
  }) {
    return ApiResponse(
      data: data,
      response: response,
      success: true,
      message: message ?? 'Success',
      statusCode: statusCode ?? response?.statusCode,
    );
  }

  factory ApiResponse.error({
    String? message,
    Response? response,
    int? statusCode,
    dynamic error,
  }) {
    return ApiResponse(
      success: false,
      response: response,
      message: message,
      statusCode: statusCode ?? response?.statusCode,
      error: error,
      data: null,
    );
  }

  // Helper method to get typed response data
  Map<String, dynamic>? get responseData =>
      response?.data as Map<String, dynamic>?;
}

// Add this class before DioClient class
class RefreshConfig {
  final String endpoint;
  final String tokenKey;
  final String refreshTokenKey;
  final Map<String, dynamic> Function(String)? requestBuilder;

  const RefreshConfig({
    required this.endpoint,
    this.tokenKey = 'access_token',
    this.refreshTokenKey = 'refresh_token',
    this.requestBuilder,
  });
}

class DioClient {
  final String baseUrl;
  late Dio _dio;
  String? _accessToken;
  final RefreshConfig? refreshConfig;
  final OnUnauthorizedCallback? onUnauthorized;
  final FlutterSecureStorage _storage;
  final AuthConfig authConfig;

  static const String _tokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _authTypeKey = 'auth_type';

  DioClient({
    required this.baseUrl,
    this.refreshConfig,
    this.onUnauthorized,
    FlutterSecureStorage? storage,
    this.authConfig = AuthConfig.bearer,
  }) : _storage = storage ?? const FlutterSecureStorage() {
    // Ensure baseUrl ends with a slash
    final formattedBaseUrl = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';

    _dio = Dio(
      BaseOptions(
        baseUrl: formattedBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
      ),
    );

    debugPrint('Initializing DioClient with baseUrl: $formattedBaseUrl');
    _setupInterceptors();
    _initializeToken();
  }

  // Modified refresh token method
  Future<String?> _refreshToken(String currentRefreshToken) async {
    if (refreshConfig == null) return null;

    try {
      final requestData =
          refreshConfig!.requestBuilder?.call(currentRefreshToken) ??
          {refreshConfig!.refreshTokenKey: currentRefreshToken};

      final response = await _dio.post(
        refreshConfig!.endpoint,
        data: requestData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;
        final newToken = data[refreshConfig!.tokenKey] as String?;
        final newRefreshToken = data[refreshConfig!.refreshTokenKey] as String?;

        if (newToken != null) {
          await _storeTokens(
            accessToken: newToken,
            refreshToken: newRefreshToken,
          );
          return newToken;
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error refreshing token: $e');
      return null;
    }
  }

  void _setupInterceptors() {
    // Logging interceptor for debug mode
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }

    // Error and Authentication interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_accessToken != null) {
            switch (authConfig.type) {
              case AuthType.basic:
              case AuthType.bearer:
                options.headers['Authorization'] = authConfig.formatToken(
                  _accessToken!,
                );
                break;
              case AuthType.custom:
                if (authConfig.customHeaderKey != null) {
                  options.headers[authConfig.customHeaderKey!] = _accessToken;
                }
                break;
              case AuthType.none:
                break;
            }
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            final refreshToken = await getRefreshToken();
            if (refreshToken != null && refreshConfig != null) {
              try {
                final newToken = await _refreshToken(refreshToken);
                if (newToken != null) {
                  setAuthToken(newToken);
                  final opts = Options(
                    method: error.requestOptions.method,
                    headers: error.requestOptions.headers,
                  );
                  final clonedRequest = await _dio.request<dynamic>(
                    error.requestOptions.path,
                    options: opts,
                    data: error.requestOptions.data,
                    queryParameters: error.requestOptions.queryParameters,
                  );
                  return handler.resolve(clonedRequest);
                }
              } catch (e) {
                await clearAuthToken();
                if (onUnauthorized != null) {
                  await onUnauthorized!();
                }
                return handler.reject(
                  DioException(
                    requestOptions: error.requestOptions,
                    error: TokenExpiredException(),
                  ),
                );
              }
            }
            await clearAuthToken();
            if (onUnauthorized != null) {
              await onUnauthorized!();
            }
            return handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: AuthenticationException(),
              ),
            );
          }
          return handler.next(error);
        },
      ),
    );
  }

  // Handle API response and errors
  ApiResponse<T> _handleResponse<T>(
    Response response, {
    String? dataKey,
    T Function(dynamic)? parser,
  }) {
    dynamic responseData = response.data;
    if (dataKey != null && responseData is Map<String, dynamic>) {
      responseData = responseData[dataKey];
    }

    // Helper function to safely get message from response
    String getMessage(dynamic data) {
      if (data is Map<String, dynamic>) {
        return data['message']?.toString() ?? 'Unknown error';
      } else if (data is String) {
        return data;
      }
      return 'Unknown error';
    }

    // Helper function to safely get success flag
    bool getSuccess(dynamic data) {
      if (data is Map<String, dynamic>) {
        return data['success'] ?? true;
      }
      return true;
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return ApiResponse(
          data: parser != null ? parser(responseData) : responseData as T?,
          message: getMessage(response.data),
          response: response,
          statusCode: response.statusCode,
          success: getSuccess(response.data),
          error: response.data is Map ? response.data['error'] : null,
        );
      case 400:
        return ApiResponse.error(
          message: getMessage(response.data),
          response: response,
          statusCode: response.statusCode,
          error: response.data,
        );
      case 401:
        return ApiResponse.error(
          message: getMessage(response.data),
          response: response,
          statusCode: response.statusCode,
          error: response.data,
        );
      case 403:
        return ApiResponse.error(
          message: getMessage(response.data),
          response: response,
          statusCode: response.statusCode,
          error: response.data,
        );
      case 404:
        return ApiResponse.error(
          message: getMessage(response.data),
          response: response,
          statusCode: response.statusCode,
          error: response.data,
        );
      case 500:
        return ApiResponse.error(
          message: getMessage(response.data),
          response: response,
          statusCode: response.statusCode,
          error: response.data,
        );
      default:
        return ApiResponse.error(
          message: getMessage(response.data),
          response: response,
          statusCode: response.statusCode,
          error: response.data,
        );
    }
  }

  // Initialize token from storage
  Future<void> _initializeToken() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      if (token != null) {
        setAuthToken(token);
      }
    } catch (e) {
      debugPrint('Error reading token from storage: $e');
    }
  }

  // Store tokens securely with auth type
  Future<void> _storeTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    try {
      await _storage.write(key: _tokenKey, value: accessToken);
      if (refreshToken != null) {
        await _storage.write(key: _refreshTokenKey, value: refreshToken);
      }
      await _storage.write(
        key: _authTypeKey,
        value: authConfig.type.toString(),
      );
    } catch (e) {
      debugPrint('Error storing tokens: $e');
    }
  }

  // Get stored refresh token
  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: _refreshTokenKey);
    } catch (e) {
      debugPrint('Error reading refresh token: $e');
      return null;
    }
  }

  // Clear stored tokens
  Future<void> _clearTokens() async {
    try {
      await _storage.delete(key: _tokenKey);
      await _storage.delete(key: _refreshTokenKey);
    } catch (e) {
      debugPrint('Error clearing tokens: $e');
    }
  }

  // Generic GET request
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? dataKey,
    T Function(dynamic)? parser,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse<T>(response, dataKey: dataKey, parser: parser);
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(
        message: 'Unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  // Generic POST request
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? dataKey,
    T Function(dynamic)? parser,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse<T>(response, dataKey: dataKey, parser: parser);
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(
        message: 'Unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  // Generic PUT request
  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? dataKey,
    T Function(dynamic)? parser,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse<T>(response, dataKey: dataKey, parser: parser);
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(
        message: 'Unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  // Generic DELETE request
  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? dataKey,
    T Function(dynamic)? parser,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse<T>(response, dataKey: dataKey, parser: parser);
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(
        message: 'Unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  // File upload
  Future<ApiResponse<T>> uploadFile<T>(
    String endpoint, {
    required File file,
    required String fieldName,
    Map<String, dynamic>? additionalData,
    Options? options,
    ProgressCallback? onSendProgress,
    String? dataKey,
    T Function(dynamic)? parser,
  }) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(file.path, filename: fileName),
        if (additionalData != null) ...additionalData,
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
        options: options,
        onSendProgress: onSendProgress,
      );
      return _handleResponse<T>(response, dataKey: dataKey, parser: parser);
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(
        message: 'Unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  // Multiple files upload
  Future<ApiResponse<T>> uploadMultipleFiles<T>(
    String endpoint, {
    required List<File> files,
    required String fieldName,
    Map<String, dynamic>? additionalData,
    Options? options,
    ProgressCallback? onSendProgress,
    String? dataKey,
    T Function(dynamic)? parser,
  }) async {
    try {
      List<MultipartFile> multipartFiles = [];

      for (var file in files) {
        String fileName = file.path.split('/').last;
        MultipartFile multipartFile = await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        );
        multipartFiles.add(multipartFile);
      }

      FormData formData = FormData.fromMap({
        fieldName: multipartFiles,
        if (additionalData != null) ...additionalData,
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
        options: options,
        onSendProgress: onSendProgress,
      );
      return _handleResponse<T>(response, dataKey: dataKey, parser: parser);
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(
        message: 'Unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  // Modified login method
  Future<ApiResponse<T>> login<T>(
    String endpoint, {
    required String email,
    required String password,
    AuthConfig? authConfigOverride,
    T Function(dynamic)? parser,
    String tokenKey = "access_token",
    String refreshTokenKey = "refresh_token",
    String? dataKey,
  }) async {
    final config = authConfigOverride ?? authConfig;

    switch (config.type) {
      case AuthType.basic:
        return loginWithBasicAuth<T>(
          endpoint,
          username: email,
          password: password,
          parser: parser,
          dataKey: dataKey,
        );
      case AuthType.bearer:
      default:
        return loginWithJWT<T>(
          endpoint,
          loginData: {'email': email, 'password': password},
          parser: parser,
          tokenKey: tokenKey,
          refreshTokenKey: refreshTokenKey,
          dataKey: dataKey,
        );
    }
  }

  // JWT Token login
  Future<ApiResponse<T>> loginWithJWT<T>(
    String endpoint, {
    required Map<String, dynamic> loginData,
    T Function(dynamic)? parser,
    String tokenKey = "access_token",
    String refreshTokenKey = "refresh_token",
    String? dataKey,
  }) async {
    try {
      final response = await _dio.post(endpoint, data: loginData);
      final processedResponse = _handleResponse<T>(
        response,
        parser: parser,
        dataKey: dataKey,
      );

      if (processedResponse.success &&
          processedResponse.responseData != null &&
          processedResponse.responseData![tokenKey] != null) {
        await _storeTokens(
          accessToken: processedResponse.responseData![tokenKey],
          refreshToken: processedResponse.responseData![refreshTokenKey],
        );
        setAuthToken(processedResponse.responseData![tokenKey]);
      }

      return processedResponse;
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(
        message: 'Unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  // Basic Auth login
  Future<ApiResponse<T>> loginWithBasicAuth<T>(
    String endpoint, {
    required String username,
    required String password,
    T Function(dynamic)? parser,
    String? dataKey,
  }) async {
    try {
      final credentials = '$username:$password';
      final basicAuth = 'Basic ${base64Encode(utf8.encode(credentials))}';

      final response = await _dio.post(
        endpoint,
        options: Options(headers: {'Authorization': basicAuth}),
      );
      final processedResponse = _handleResponse<T>(
        response,
        parser: parser,
        dataKey: dataKey,
      );

      if (processedResponse.success) {
        await _storeTokens(accessToken: credentials, refreshToken: null);
        setAuthToken(credentials);
      }

      return processedResponse;
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(
        message: 'Unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  // Register method
  Future<ApiResponse<T>> register<T>(
    String endpoint, {
    required Map<String, dynamic> data,
    T Function(dynamic)? parser,
    String? dataKey,
  }) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return _handleResponse<T>(response, parser: parser, dataKey: dataKey);
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(
        message: 'Unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  // Error handling helper
  ApiResponse<T> _handleDioError<T>(DioException error) {
    if (error.response != null) {
      return _handleResponse<T>(error.response!);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiResponse.error(
          message: 'Connection timeout',
          error: error.message,
        );
      case DioExceptionType.connectionError:
        return ApiResponse.error(
          message: 'No internet connection',
          error: error.message,
        );
      default:
        return ApiResponse.error(
          message: 'Something went wrong',
          error: error.message,
        );
    }
  }

  // Modified setAuthToken
  void setAuthToken(String token) {
    _accessToken = token;
    switch (authConfig.type) {
      case AuthType.basic:
      case AuthType.bearer:
        _dio.options.headers['Authorization'] = authConfig.formatToken(token);
        break;
      case AuthType.custom:
        if (authConfig.customHeaderKey != null) {
          _dio.options.headers[authConfig.customHeaderKey!] = token;
        }
        break;
      case AuthType.none:
        // No authentication header needed
        break;
    }
    // Store token asynchronously
    _storeTokens(accessToken: token);
  }

  // Modified clearAuthToken
  Future<void> clearAuthToken() async {
    _accessToken = null;
    _dio.options.headers.remove('Authorization');
    await _clearTokens();
  }

  // Add method to check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await _storage.read(key: _tokenKey);
    return token != null;
  }

  // Refresh token through endpoint
  Future<ApiResponse<Map<String, dynamic>>> refreshToken() async {
    try {
      debugPrint('Starting token refresh process...');
      final refreshToken = await getRefreshToken();

      if (refreshToken == null) {
        debugPrint('❌ No refresh token available in storage');
        return ApiResponse.error(
          message: 'No refresh token available',
          error: 'Refresh token not found',
        );
      }
      debugPrint('✅ Found refresh token in storage');

      final endpoint = refreshConfig?.endpoint ?? '/auth/refresh';
      debugPrint('Making refresh request to endpoint: $endpoint');

      final requestData =
          refreshConfig?.requestBuilder?.call(refreshToken) ??
          {refreshConfig?.refreshTokenKey ?? 'refresh_token': refreshToken};
      debugPrint('Request data: ${requestData.toString()}');

      final response = await _dio.post(endpoint, data: requestData);

      debugPrint('Received response with status code: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');

      final processedResponse = _handleResponse<Map<String, dynamic>>(
        response,
        dataKey: 'data',
      );

      if (processedResponse.success && processedResponse.responseData != null) {
        final newAccessToken =
            processedResponse.responseData![refreshConfig?.tokenKey ??
                'access_token'];
        final newRefreshToken =
            processedResponse.responseData![refreshConfig?.refreshTokenKey ??
                'refresh_token'];

        if (newAccessToken != null) {
          debugPrint('✅ Successfully received new tokens');
          debugPrint('New access token length: ${newAccessToken.length}');
          debugPrint(
            'New refresh token length: ${newRefreshToken?.length ?? 0}',
          );

          await _storeTokens(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
          );
          debugPrint('✅ Successfully stored new tokens');

          setAuthToken(newAccessToken);
          debugPrint('✅ Successfully updated auth token in Dio instance');
        } else {
          debugPrint('❌ No new access token in response');
        }
      } else {
        debugPrint('❌ Token refresh failed: ${processedResponse.message}');
      }

      return processedResponse;
    } on DioException catch (e) {
      debugPrint('❌ Dio error during token refresh: ${e.message}');
      if (e.response != null) {
        debugPrint('Error response data: ${e.response?.data}');
      }
      return _handleDioError<Map<String, dynamic>>(e);
    } catch (e) {
      debugPrint('❌ Unexpected error during token refresh: $e');
      return ApiResponse.error(
        message: 'Failed to refresh token',
        error: e.toString(),
      );
    }
  }
}
