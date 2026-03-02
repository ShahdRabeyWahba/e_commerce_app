import 'package:dio/dio.dart';
import 'package:e_commerce_app/api/data/model/request/login/login_request_dto.dart';
import 'package:e_commerce_app/api/data/model/request/register/register_request_dto.dart';
import 'package:e_commerce_app/api/data/model/response/auth/auth_response_dto.dart';
import 'package:e_commerce_app/api/data/model/response/category/category_dto.dart';
import 'package:e_commerce_app/api/data/model/response/product/product_dto.dart';
import 'package:e_commerce_app/api/end_points.dart';
import 'package:retrofit/retrofit.dart';

part 'api_manager.g.dart';

@RestApi()
abstract class ApiManager {
  factory ApiManager(Dio dio, {String? baseUrl}) = _ApiManager;

  @POST(EndPoints.loginApi)
  Future<AuthResponseDto> login(@Body() LoginRequestDto loginRequest);

  @POST(EndPoints.registerApi)
  Future<AuthResponseDto> register(@Body() RegisterRequestDto registerRequest);

  @GET(EndPoints.categoriesApi)
  Future<CategoryResponseDto> getCategories();

  @GET(EndPoints.productsApi)
  Future<ProductResponseDto> getProducts();
}
