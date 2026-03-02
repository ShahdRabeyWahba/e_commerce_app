import 'package:dio/dio.dart';
import 'package:e_commerce_app/api/dio/dio_interceptors.dart';
import 'package:e_commerce_app/api/end_points.dart';

class DioFactory {
  DioFactory._();

  static Dio? _dio;

  static Dio getInstance() {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(DioInterceptors());

    return dio;
  }
}
