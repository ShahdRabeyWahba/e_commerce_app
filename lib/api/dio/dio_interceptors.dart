import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/utils/prefs_helper.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? token = PrefsHelper.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['token'] = token;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = "";

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection timeout with API server";
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Send timeout in connection with API server";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleError(err.response?.statusCode, err.response?.data);
        break;
      case DioExceptionType.cancel:
        errorMessage = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionError:
        errorMessage = "No internet connection";
        break;
      default:
        errorMessage = "Unexpected error occurred";
    }

    final exception = err.copyWith(message: errorMessage);
    handler.next(exception);
  }

  String _handleError(int? statusCode, dynamic error) {
    // If the API sends a specific error message in the body
    if (error != null && error is Map && error.containsKey('message')) {
      return error['message'];
    }

    // Fallback messages based on the HTTP Status Code
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops! Something went wrong';
    }
  }
}
