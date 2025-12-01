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
          .instance.apSrvURL
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
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
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
        return _dio.post(path, data: data, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
      case MethodType.PUT:
        return _dio.put(path, data: data, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
      case MethodType.DELETE:
        return _dio.delete(path, data: data, queryParameters: data, options: options, cancelToken: cancelToken);
      case MethodType.GET:
      default:
        return _dio.get(path, queryParameters: data, options: options, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
    }
  }
}
