import 'package:e_commerce_app/api/api_manager.dart';
import 'package:e_commerce_app/api/data/model/request/login/login_request_dto.dart';
import 'package:e_commerce_app/api/data/model/request/register/register_request_dto.dart';
import 'package:e_commerce_app/api/data/model/response/auth/auth_response_dto.dart';
import 'package:e_commerce_app/data/data_sources/remote/auth/auth_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/request/login/login_request.dart';
import 'package:e_commerce_app/domain/entities/request/register/register_request.dart';
import 'package:e_commerce_app/domain/entities/response/auth/auth_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiManager _apiManager;

  AuthRemoteDataSourceImpl(this._apiManager);

  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
    var response = await _apiManager.login(
      LoginRequestDto(
        email: loginRequest.email,
        password: loginRequest.password,
      ),
    );
    return response.toEntity();
  }

  @override
  Future<AuthResponse> register(RegisterRequest registerRequest) async {
    var response = await _apiManager.register(
      RegisterRequestDto(
        name: registerRequest.name,
        email: registerRequest.email,
        password: registerRequest.password,
        rePassword: registerRequest.rePassword,
        phone: registerRequest.phone,
      ),
    );
    return response.toEntity();
  }
}