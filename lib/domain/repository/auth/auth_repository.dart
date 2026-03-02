import 'package:e_commerce_app/domain/entities/request/login/login_request.dart';
import 'package:e_commerce_app/domain/entities/request/register/register_request.dart';
import 'package:e_commerce_app/domain/entities/response/auth/auth_response.dart';


abstract class AuthRepository {
Future<AuthResponse>login(LoginRequest loginRequest);
Future<AuthResponse>register(RegisterRequest registerRequest);
}