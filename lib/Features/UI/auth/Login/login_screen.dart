import 'package:e_commerce_app/Features/UI/auth/Login/cubit/cubit.dart';
import 'package:e_commerce_app/Features/UI/auth/auth_states.dart';
import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/localization/app_localizations.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/core/utils/dialog_utils.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: BlocListener<LoginCubit, AuthStates>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            DialogUtils.showLoading(context, 'Loading...');
          } else if (state is AuthErrorState) {
            DialogUtils.hideLoading(context);
            DialogUtils.showErrorDialog(context, state.message ?? "Error");
          } else if (state is AuthSuccessState) {
            DialogUtils.hideLoading(context);
            DialogUtils.showSuccessDialog(context, "Welcome Back!");
            Navigator.pushReplacementNamed(context, AppRoutes.homescreenRoute);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.mainColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 90.h),
                    Image.asset(
                      AppAssets.logoRoute,
                      width: 200.w, // Slightly smaller than before but still large
                      color: Colors.white,
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      local.welcome_back,
                      style: AppStyles.whiteSemi24,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      local.sign_in_prompt,
                      style: AppStyles.whiteLight16,
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      local.email_address,
                      style: AppStyles.labelWhite18,
                    ),
                    SizedBox(height: 18.h),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: local.enter_email,
                      validator: AppValidators.validateEmail,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      local.password,
                      style: AppStyles.labelWhite18,
                    ),
                    SizedBox(height: 18.h),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: local.enter_password,
                      validator: AppValidators.validatePassword,
                      isObscureText: true,
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          local.forgot_password,
                          style: AppStyles.whiteReg14,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Builder(
                      builder: (context) {
                        return CustomElevatedButton(
                          text: local.login,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<LoginCubit>().login(
                                    emailController.text,
                                    passwordController.text,
                                  );
                            }
                          },
                        );
                      }
                    ),
                    SizedBox(height: 32.h),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.registerScreenRoute);
                        },
                        child: Text(
                          local.dont_have_account,
                          style: AppStyles.whiteMedium18,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
