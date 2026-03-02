import 'package:e_commerce_app/domain/entities/response/auth/auth_response.dart';

sealed class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final String? message;
  AuthErrorState({this.message});
}

class AuthSuccessState extends AuthStates {
  final AuthResponse response;
  AuthSuccessState(this.response);
}