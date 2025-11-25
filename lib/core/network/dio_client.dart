import 'package:base_project/core/config/app_properties.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:base_project/core/network/auth_interceptor.dart';

enum MethodType { GET, POST, PUT, DELETE }

class DioClient {
  final Dio _dio;

  DioClient(this._dio, AuthInterceptor authInterceptor) {
    _dio
      ..options.baseUrl = AppProperties
          .instance.apSrvURL // TODO: Replace with your API base URL
      ..options.headers = {'Content-Type': 'application/json'}
      ..options.connectTimeout = const Duration(milliseconds: 15000)
      ..options.receiveTimeout = const Duration(milliseconds: 15000);

    _dio.interceptors.add(authInterceptor);

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (object) => debugPrint(object.toString()),
      ));
    }
  }

  /// The main entry point for all requests. Returns a parsed model [T] on success
  /// or throws an exception on failure, to be caught by the Repository layer.
  Future<Response> request(
    String path, {
    required MethodType method,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dispatchRequest(
        path,
        method: method,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      // On success, parse and return the model directly.
      return response;
    } on DioException {
      // Re-throw the exception to be handled by the calling layer (Repository).
      rethrow;
    } catch (e) {
      // Re-throw any other exception (e.g., parsing error).
      rethrow;
    }
  }

  Future<Response<T>> _dispatchRequest<T>(
    String path, {
    required MethodType method,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    switch (method) {
      case MethodType.POST:
        return _dio.post(path,
            data: data, // Fixed: was using queryParameters here by mistake
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress);
      case MethodType.PUT:
        return _dio.put(path,
            data: data,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress);
      case MethodType.DELETE:
        return _dio.delete(path,
            data: data,
            queryParameters: data,
            options: options,
            cancelToken: cancelToken);
      case MethodType.GET:
      default:
        return _dio.get(path,
            queryParameters: data,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress);
    }
  }
}
