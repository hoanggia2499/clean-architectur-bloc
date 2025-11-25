import 'package:dio/dio.dart';
import 'package:base_project/core/network/token_storage.dart';

// By extending QueuedInterceptorsWrapper, we get automatic request queuing
// during token refresh, which is cleaner and safer than manual locking.
class AuthInterceptor extends QueuedInterceptorsWrapper {
  final TokenStorage _tokenStorage;
  final Dio dio;

  AuthInterceptor(this._tokenStorage, this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _tokenStorage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Avoid an infinite loop if the refresh token request itself fails
      if (err.requestOptions.path.contains('/auth/refresh')) {
        await _tokenStorage.deleteAllTokens();
        return super.onError(err, handler);
      }

      try {
        final refreshToken = await _tokenStorage.getRefreshToken();
        if (refreshToken == null) {
          // If no refresh token, we can't recover. Propagate the error.
          throw DioException(requestOptions: err.requestOptions, error: 'No refresh token available.');
        }

        // Use a new Dio instance to avoid the interceptor loop
        final refreshDio = Dio(); 
        final refreshResponse = await refreshDio.post(
          'https://your.api.base.url/api/auth/refresh', // TODO: Replace with your refresh token endpoint
          data: {'refreshToken': refreshToken},
        );

        if (refreshResponse.statusCode == 200) {
          final newAccessToken = refreshResponse.data['accessToken'];
          final newRefreshToken = refreshResponse.data['refreshToken'];

          await _tokenStorage.saveTokens(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
          );

          // Update the header of the original failed request
          err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          
          // Retry the request with the new token
          final response = await dio.fetch(err.requestOptions);
          
          // On success, resolve the original request. This will unlock the queue and
          // let the successful response flow to the caller.
          return handler.resolve(response);
        }
        // If the refresh call itself returns an error, throw it to the catch block.
        throw DioException(requestOptions: err.requestOptions, response: refreshResponse);

      } catch (e) {
        // If refresh fails at any point, clear tokens and propagate the original error.
        // This will fail the original request and all other queued requests.
        await _tokenStorage.deleteAllTokens();
        return super.onError(err, handler);
      }
    }
    
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      final timeoutException = DioException(
        requestOptions: err.requestOptions,
        error: 'The connection has timed out. Please check your internet connection and try again.',
        type: err.type,
      );
      // Use next() to pass the modified error to the next error handler.
      return handler.next(timeoutException);
    }

    // For other errors, just pass them along.
    return super.onError(err, handler);
  }
}
