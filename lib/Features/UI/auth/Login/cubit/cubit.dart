import 'package:e_commerce_app/Features/UI/auth/auth_states.dart';
import 'package:e_commerce_app/core/utils/prefs_helper.dart';
import 'package:e_commerce_app/domain/entities/request/login/login_request.dart';
import 'package:e_commerce_app/domain/use_cases/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<AuthStates> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(AuthInitialState());

  Future<void> login(String email, String password) async {
    emit(AuthLoadingState());
    try {
      var response = await _loginUseCase.call(
        LoginRequest(email: email, password: password),
      );
      if (response.token != null) {
        await PrefsHelper.setToken(response.token!);
        if (response.user != null) {
          await PrefsHelper.saveUser(response.user?.name ?? "", response.user?.email ?? "", phone: response.user?.phone);
        }
        emit(AuthSuccessState(response));
      } else {
        emit(AuthErrorState(message: response.message ?? "Login Failed"));
      }
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
    }
  }
}