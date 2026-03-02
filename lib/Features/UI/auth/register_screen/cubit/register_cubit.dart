import 'package:e_commerce_app/Features/UI/auth/auth_states.dart';
import 'package:e_commerce_app/core/utils/prefs_helper.dart';
import 'package:e_commerce_app/domain/entities/request/register/register_request.dart';
import 'package:e_commerce_app/domain/use_cases/register_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<AuthStates> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(AuthInitialState());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    emit(AuthLoadingState());
    try {
      var response = await _registerUseCase.call(
        RegisterRequest(
          name: name,
          email: email,
          password: password,
          rePassword: rePassword,
          phone: phone,
        ),
      );
      if (response.token != null) {
        await PrefsHelper.setToken(response.token!);
        if (response.user != null) {
          await PrefsHelper.saveUser(response.user?.name ?? name, response.user?.email ?? email, phone: response.user?.phone ?? phone);
        } else {
          await PrefsHelper.saveUser(name, email, phone: phone);
        }
        emit(AuthSuccessState(response));
      } else {
        emit(AuthErrorState(message: response.message ?? "Registration Failed"));
      }
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
    }
  }
}
