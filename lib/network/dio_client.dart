import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:looking2hire/constants/app_routes.dart';
import 'package:looking2hire/service/secure_storage/secure_storage.dart';

class DioClient {
  // dio instance
  final Dio _dio;
  final cookieJar = CookieJar();
  final SecureStorage _secureStorage = SecureStorage();

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = ApiRoutes.baseUrl
      ..options.connectTimeout = ApiRoutes.connectionTimeout
      ..options.receiveTimeout = ApiRoutes.receiveTimeout
      ..interceptors.add(CookieManager(cookieJar))
      ..interceptors.add(_createAuthInterceptor())
      ..options.responseType = ResponseType.json;
  }

  // Create auth interceptor
  Interceptor _createAuthInterceptor() {
    return InterceptorsWrapper(
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          try {
            // Attempt to refresh token
            final refreshResponse = await _dio.post(
              ApiRoutes.refreshToken,
              options: Options(extra: {'withCredentials': true}),
            );

            if (refreshResponse.statusCode == 200) {
              final newToken = refreshResponse.data['accessToken'];
              if (newToken != null) {
                // Store new token
                await _secureStorage.saveToken(token: newToken);

                // Retry the original request
                final originalRequest = error.requestOptions;
                originalRequest.headers['Authorization'] = 'Bearer $newToken';

                try {
                  final response = await _dio.fetch(originalRequest);
                  return handler.resolve(response);
                } catch (e) {
                  return handler.reject(e as DioException);
                }
              }
              print("NEW TOKEN:::::::: $newToken");
            }
          } catch (e) {
            print("RERESH TOKEN ERROR:::::::: $e");
            // If refresh fails, clear token and reject
            //await _secureStorage.deleteToken();
            return handler.reject(error);
          }
        }
        return handler.reject(error);
      },
    );
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    var token = await _secureStorage.retrieveToken();
    debugPrint("GET TOKEN:::::::: $token");
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            // 'Content-Type': 'application/json',
            // 'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            // 'user-x-token': token,
          },
          extra: {'withCredentials': true},
        ),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    var token = await _secureStorage.retrieveToken();
    debugPrint("Post TOKEN:::::::: $token");
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            // 'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'user-x-token': token,
            'Authorization': 'Bearer $token',
          },
          extra: {'withCredentials': true},
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> postMedia(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    var token = await _secureStorage.retrieveToken();
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          extra: {'withCredentials': true},
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> uploadImage({
    required String filePath,
    required String uploadUrl,
  }) async {
    var token = await _secureStorage.retrieveToken();

    try {
      // Create the multipart file from the file path
      File file = File(filePath);
      String fileName = file.path.split('/').last;

      // Prepare form-data
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      // Send POST request
      Response response = await _dio.post(
        uploadUrl,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            'Authorization': 'Bearer $token',
          },
          extra: {'withCredentials': true},
        ),
      );

      return response;
    } catch (e) {
      print("Error uploading image: $e");
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    var token = await _secureStorage.retrieveToken();
    debugPrint("PUT TOKEN:::::::: $token");
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            // 'user-x-token': token,
          },
          extra: {'withCredentials': true},
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> patch(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    var token = await _secureStorage.retrieveToken();
    debugPrint("PATCH TOKEN:::::::: $token");
    try {
      final Response response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            // 'user-x-token': token,
          },
          extra: {'withCredentials': true},
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    var token = await _secureStorage.retrieveToken();
    debugPrint("Delete TOKEN:::::::: $token");
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            // 'Content-Type': 'application/json',
            // 'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            // 'user-x-token': token,
          },
          extra: {'withCredentials': true},
        ),
        // cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
