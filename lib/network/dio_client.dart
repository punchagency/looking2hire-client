import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:looking2hire/constants/app_routes.dart';
import 'package:looking2hire/service/secure_storage/secure_storage.dart';

class DioClient {
  // Dio instance
  final Dio _dio = Dio();
  // final CookieJar _cookieJar = CookieJar();
  final SecureStorage _secureStorage = SecureStorage();

  // Callback for handling authentication failures
  Function()? onAuthFailure;

  DioClient() {
    _dio
      ..options.baseUrl = ApiRoutes.baseUrl
      ..options.connectTimeout = ApiRoutes.connectionTimeout
      ..options.receiveTimeout = ApiRoutes.receiveTimeout
      ..options.responseType = ResponseType.json
      // ..interceptors.add(CookieManager(_cookieJar)) // Add Cookie Manager
      ..interceptors.add(_createAuthInterceptor()); // Add Auth Interceptor
  }

  // Create auth interceptor
  Interceptor _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        var token = await _secureStorage.retrieveToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          debugPrint("🔄 Attempting to refresh token...");

          try {
            // Store the failed request to retry it later
            final failedRequest = error.requestOptions;

            var refreshToken = await _secureStorage.retrieveRefreshToken();
            debugPrint("refreshToken = $refreshToken");

            if (refreshToken == null) {
              debugPrint("❌ No refresh token available");
              await _handleAuthFailure();
              return handler.reject(error);
            }

            final refreshResponse = await _dio.post(
              ApiRoutes.refreshToken,
              data: {"refreshToken": refreshToken},
              options: Options(validateStatus: (status) => status! < 500),
            );

            debugPrint(
              "✅ Refresh token response: ${refreshResponse.statusCode}, ${refreshResponse.data}",
            );

            if (refreshResponse.statusCode == 200 &&
                refreshResponse.data['accessToken'] != null) {
              final newToken = refreshResponse.data['accessToken'];
              final newRefreshToken = refreshResponse.data['refreshToken'];

              debugPrint(
                "🔑 New token received, storing and retrying request.",
              );
              await _secureStorage.saveToken(token: newToken);
              await _secureStorage.saveRefreshToken(
                refreshToken: newRefreshToken,
              );

              // Create new request with the new token
              final retryRequest = await _dio.request(
                failedRequest.path,
                data: failedRequest.data,
                queryParameters: failedRequest.queryParameters,
                options: Options(
                  method: failedRequest.method,
                  headers: {
                    ...failedRequest.headers,
                    'Authorization': 'Bearer $newToken',
                  },
                ),
              );

              return handler.resolve(retryRequest);
            } else {
              debugPrint("❌ Token refresh failed: Invalid response");
              await _handleAuthFailure();
              return handler.reject(error);
            }
          } catch (e) {
            debugPrint("❌ Token refresh failed: $e");
            await _handleAuthFailure();
            return handler.reject(error);
          }
        }
        return handler.reject(error);
      },
    );
  }

  Future<void> _handleAuthFailure() async {
    debugPrint("⚠️ Auth failed. Clearing tokens and notifying app.");
    await _secureStorage.deleteToken();
    await _secureStorage.deleteRefreshToken();

    if (onAuthFailure != null) {
      onAuthFailure!();
    }
  }

  // Helper method to merge options
  Options _mergeOptions(Options? options, String method) {
    final baseOptions = Options(method: method, headers: {}, extra: {});

    if (options != null) {
      baseOptions.headers?.addAll(options.headers ?? {});
      baseOptions.extra?.addAll(options.extra ?? {});
      // Copy other relevant options properties
      baseOptions.responseType = options.responseType;
      baseOptions.contentType = options.contentType;
      baseOptions.validateStatus = options.validateStatus;
      baseOptions.receiveTimeout = options.receiveTimeout;
      baseOptions.sendTimeout = options.sendTimeout;
    }

    return baseOptions;
  }

  // Generic Request Sender
  Future<Response> _sendRequest(
    String url, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final mergedOptions = _mergeOptions(options, method);

      return await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      rethrow;
    }
  }

  // GET Request
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _sendRequest(
      url,
      method: 'GET',
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // POST Request
  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _sendRequest(
      url,
      method: 'POST',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // PUT Request
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _sendRequest(
      url,
      method: 'PUT',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // PATCH Request
  Future<Response> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _sendRequest(
      url,
      method: 'PATCH',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // DELETE Request
  Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _sendRequest(
      url,
      method: 'DELETE',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // Upload Image
  Future<Response> uploadImage(
    String filePath,
    String uploadUrl, {
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    File file = File(filePath);
    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    final uploadOptions = _mergeOptions(
      options ?? Options(headers: {"Content-Type": "multipart/form-data"}),
      'POST',
    );

    return _sendRequest(
      uploadUrl,
      method: 'POST',
      data: formData,
      options: uploadOptions,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
