// import 'dart:io';

// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:looking2hire/constants/app_routes.dart';
// import 'package:looking2hire/service/secure_storage/secure_storage.dart';

// class DioClient {
//   // dio instance
//   final Dio _dio;
//   final _cookieJar = CookieJar();
//   final SecureStorage _secureStorage = SecureStorage();

//   // Callback for handling authentication failures
//   Function()? onAuthFailure;

//   DioClient(this._dio) {
//     _dio
//       ..options.baseUrl = ApiRoutes.baseUrl
//       ..options.connectTimeout = ApiRoutes.connectionTimeout
//       ..options.receiveTimeout = ApiRoutes.receiveTimeout
//       ..interceptors.add(CookieManager(_cookieJar))
//       ..interceptors.add(_createAuthInterceptor())
//       ..options.responseType = ResponseType.json;
//   }

//   // Create auth interceptor
//   Interceptor _createAuthInterceptor() {
//     return InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         // Add existing cookies to requests
//         List<Cookie> cookies = await _cookieJar.loadForRequest(
//           Uri.parse(ApiRoutes.baseUrl),
//         );
//         options.headers["Cookie"] = cookies
//             .map((cookie) => "${cookie.name}=${cookie.value}")
//             .join("; ");
//         return handler.next(options);
//       },
//       onResponse: (response, handler) {
//         return handler.next(response);
//       },
//       onError: (DioException error, handler) async {
//         if (error.response?.statusCode == 401) {
//           try {
//             debugPrint("Attempting to refresh token...");
//             // Attempt to refresh token
//             final refreshResponse = await _dio.post(
//               ApiRoutes.refreshToken,
//               options: Options(
//                 extra: {'withCredentials': true},
//                 validateStatus: (status) => status! < 500,
//               ),
//             );

//             debugPrint(
//               "Refresh token response status: ${refreshResponse.statusCode}",
//             );
//             debugPrint("Refresh token response data: ${refreshResponse.data}");

//             if (refreshResponse.statusCode == 200) {
//               final newToken = refreshResponse.data['accessToken'];
//               if (newToken != null) {
//                 debugPrint("New token received, storing and retrying request");
//                 await _secureStorage.saveToken(token: newToken);

//                 final originalRequest = error.requestOptions;
//                 originalRequest.headers['Authorization'] = 'Bearer $newToken';

//                 try {
//                   final response = await _dio.fetch(originalRequest);
//                   return handler.resolve(response);
//                 } catch (e) {
//                   debugPrint("Error retrying request after token refresh: $e");
//                   return handler.reject(e as DioException);
//                 }
//               } else {
//                 debugPrint("No new token received in refresh response");
//                 await _handleAuthFailure();
//                 return handler.reject(error);
//               }
//             } else {
//               debugPrint(
//                 "Refresh token request failed with status: ${refreshResponse.statusCode}",
//               );
//               await _handleAuthFailure();
//               return handler.reject(error);
//             }
//           } catch (e) {
//             debugPrint("Error during token refresh: $e");
//             await _handleAuthFailure();
//             return handler.reject(error);
//           }
//         }
//         return handler.reject(error);
//       },
//     );
//   }

//   Future<void> _handleAuthFailure() async {
//     // Clear all auth data
//     // await _secureStorage.deleteToken();
//     // await _cookieJar.deleteAll();

//     // Notify the app about auth failure
//     if (onAuthFailure != null) {
//       onAuthFailure!();
//     }
//   }

//   // Get:-----------------------------------------------------------------------
//   Future<Response> get(
//     String url, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     var token = await _secureStorage.retrieveToken();
//     debugPrint("GET TOKEN:::::::: $token");
//     try {
//       final Response response = await _dio.get(
//         url,
//         queryParameters: queryParameters,
//         options: Options(
//           headers: {
//             // 'Content-Type': 'application/json',
//             // 'Accept': 'application/json',
//             'Authorization': 'Bearer $token',
//             // 'user-x-token': token,
//           },
//           extra: {'withCredentials': true},
//         ),
//         cancelToken: cancelToken,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // Post:----------------------------------------------------------------------
//   Future<Response> post(
//     String url, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     var token = await _secureStorage.retrieveToken();
//     debugPrint("Post TOKEN:::::::: $token");
//     try {
//       final Response response = await _dio.post(
//         url,
//         data: data,
//         queryParameters: queryParameters,
//         options: Options(
//           headers: {
//             // 'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             // 'user-x-token': token,
//             'Authorization': 'Bearer $token',
//           },
//           extra: {'withCredentials': true},
//         ),
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // Post:----------------------------------------------------------------------
//   Future<Response> postMedia(
//     String url, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     var token = await _secureStorage.retrieveToken();
//     try {
//       final Response response = await _dio.post(
//         url,
//         data: data,
//         queryParameters: queryParameters,
//         options: Options(
//           headers: {'Authorization': 'Bearer $token'},
//           extra: {'withCredentials': true},
//         ),
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<Response> uploadImage({
//     required String filePath,
//     required String uploadUrl,
//   }) async {
//     var token = await _secureStorage.retrieveToken();

//     try {
//       // Create the multipart file from the file path
//       File file = File(filePath);
//       String fileName = file.path.split('/').last;

//       // Prepare form-data
//       FormData formData = FormData.fromMap({
//         "file": await MultipartFile.fromFile(file.path, filename: fileName),
//       });

//       // Send POST request
//       Response response = await _dio.post(
//         uploadUrl,
//         data: formData,
//         options: Options(
//           headers: {
//             "Content-Type": "multipart/form-data",
//             'Authorization': 'Bearer $token',
//           },
//           extra: {'withCredentials': true},
//         ),
//       );

//       return response;
//     } catch (e) {
//       print("Error uploading image: $e");
//       rethrow;
//     }
//   }

//   // Put:-----------------------------------------------------------------------
//   Future<Response> put(
//     String url, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     var token = await _secureStorage.retrieveToken();
//     debugPrint("PUT TOKEN:::::::: $token");
//     try {
//       final Response response = await _dio.put(
//         url,
//         data: data,
//         queryParameters: queryParameters,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $token',
//             // 'user-x-token': token,
//           },
//           extra: {'withCredentials': true},
//         ),
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // Put:-----------------------------------------------------------------------
//   Future<Response> patch(
//     String url, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     var token = await _secureStorage.retrieveToken();
//     debugPrint("PATCH TOKEN:::::::: $token");
//     try {
//       final Response response = await _dio.patch(
//         url,
//         data: data,
//         queryParameters: queryParameters,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $token',
//             // 'user-x-token': token,
//           },
//           extra: {'withCredentials': true},
//         ),
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // Delete:--------------------------------------------------------------------
//   Future<dynamic> delete(
//     String url, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     var token = await _secureStorage.retrieveToken();
//     debugPrint("Delete TOKEN:::::::: $token");
//     try {
//       final Response response = await _dio.delete(
//         url,
//         data: data,
//         queryParameters: queryParameters,
//         options: Options(
//           headers: {
//             // 'Content-Type': 'application/json',
//             // 'Accept': 'application/json',
//             'Authorization': 'Bearer $token',
//             // 'user-x-token': token,
//           },
//           extra: {'withCredentials': true},
//         ),
//         // cancelToken: cancelToken,
//       );
//       return response.data;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

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
  final CookieJar _cookieJar = CookieJar();
  final SecureStorage _secureStorage = SecureStorage();

  // Callback for handling authentication failures
  Function()? onAuthFailure;

  DioClient() {
    _dio
      ..options.baseUrl = ApiRoutes.baseUrl
      ..options.connectTimeout = ApiRoutes.connectionTimeout
      ..options.receiveTimeout = ApiRoutes.receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(CookieManager(_cookieJar)) // Add Cookie Manager
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
        options.extra['withCredentials'] = true;
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          debugPrint("🔄 Attempting to refresh token...");

          try {
            final refreshResponse = await _dio.post(
              ApiRoutes.refreshToken,
              options: Options(
                extra: {'withCredentials': true},
                validateStatus: (status) => status! < 500,
              ),
            );

            debugPrint(
              "✅ Refresh token response: ${refreshResponse.statusCode}, ${refreshResponse.data}",
            );

            if (refreshResponse.statusCode == 200) {
              final newToken = refreshResponse.data['accessToken'];
              if (newToken != null) {
                debugPrint(
                  "🔑 New token received, storing and retrying request.",
                );
                await _secureStorage.saveToken(token: newToken);

                // Retry the original request
                final originalRequest = error.requestOptions;
                originalRequest.headers['Authorization'] = 'Bearer $newToken';

                return handler.resolve(await _dio.fetch(originalRequest));
              }
            }
          } catch (e) {
            debugPrint("❌ Token refresh failed: $e");
          }

          // If refresh fails, notify app about auth failure
          await _handleAuthFailure();
          return handler.reject(error);
        }
        return handler.reject(error);
      },
    );
  }

  Future<void> _handleAuthFailure() async {
    debugPrint("⚠️ Auth failed. Clearing token and notifying app.");
    // await _secureStorage.deleteToken();
    // await _cookieJar.deleteAll();

    if (onAuthFailure != null) {
      onAuthFailure!();
    }
  }

  // GET Request
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _sendRequest(url, method: 'GET', queryParameters: queryParameters);
  }

  // POST Request
  Future<Response> post(String url, {dynamic data}) async {
    return _sendRequest(url, method: 'POST', data: data);
  }

  // PUT Request
  Future<Response> put(String url, {dynamic data}) async {
    return _sendRequest(url, method: 'PUT', data: data);
  }

  // PATCH Request
  Future<Response> patch(String url, {dynamic data}) async {
    return _sendRequest(url, method: 'PATCH', data: data);
  }

  // DELETE Request
  Future<Response> delete(String url) async {
    return _sendRequest(url, method: 'DELETE');
  }

  // Upload Image
  Future<Response> uploadImage(String filePath, String uploadUrl) async {
    var token = await _secureStorage.retrieveToken();
    File file = File(filePath);
    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    return _dio.post(
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
  }

  // Generic Request Sender
  Future<Response> _sendRequest(
    String url, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    var token = await _secureStorage.retrieveToken();
    try {
      return await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          headers: {'Authorization': 'Bearer $token'},
          extra: {'withCredentials': true},
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
