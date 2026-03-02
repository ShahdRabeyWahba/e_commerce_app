import 'package:e_commerce_app/domain/entities/response/auth/user.dart';

class AuthResponse {
  final String? message;
  final User? user;
  final String? token;

  AuthResponse({
    this.message,
    this.user,
    this.token,
  });
}