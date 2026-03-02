import 'package:dio/dio.dart';
import 'package:e_commerce_app/api/api_manager.dart';
import 'package:e_commerce_app/api/dio/dio_interceptors.dart';
import 'package:e_commerce_app/api/end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class GetItModule {
  @singleton
  BaseOptions get provideBaseOptions => BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
      );

  @singleton
  PrettyDioLogger get providePrettyDioLogger => PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        error: true,
        responseHeader: true,
        responseBody: true,
      );

  @singleton
  DioInterceptors get provideDioInterceptors => DioInterceptors();

  @singleton
  Dio provideDio(
    BaseOptions baseOptions,
    PrettyDioLogger logger,
    DioInterceptors interceptor,
  ) {
    return Dio(baseOptions)
      ..interceptors.addAll([
        interceptor,
        logger,
      ]);
  }

  @singleton
  ApiManager provideApiManager(Dio dio) => ApiManager(dio);
}
