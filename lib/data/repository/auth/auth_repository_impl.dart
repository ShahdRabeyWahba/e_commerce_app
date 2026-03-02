import 'package:e_commerce_app/data/data_sources/remote/auth/auth_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/request/login/login_request.dart';
import 'package:e_commerce_app/domain/entities/request/register/register_request.dart';
import 'package:e_commerce_app/domain/entities/response/auth/auth_response.dart';
import 'package:e_commerce_app/domain/repository/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRepositoryImpl(this._authRemoteDataSource);
  @override
  Future<AuthResponse> login(LoginRequest loginRequest) {
   return _authRemoteDataSource.login(loginRequest);
  }

  @override
  Future<AuthResponse> register(RegisterRequest registerRequest) {
    return _authRemoteDataSource.register(registerRequest);
  }
}