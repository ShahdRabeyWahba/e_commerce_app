import 'package:e_commerce_app/domain/entities/request/register/register_request.dart';
import 'package:e_commerce_app/domain/entities/response/auth/auth_response.dart';
import 'package:e_commerce_app/domain/repository/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final AuthRepository _authRepository;
  RegisterUseCase(this._authRepository);

  Future<AuthResponse> call(RegisterRequest registerRequest) {
    return _authRepository.register(registerRequest);
  }
}