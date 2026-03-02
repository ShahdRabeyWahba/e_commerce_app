import 'package:e_commerce_app/Features/UI/auth/auth_states.dart';
import 'package:e_commerce_app/Features/UI/auth/register_screen/cubit/register_cubit.dart';
import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/localization/app_localizations.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/core/utils/dialog_utils.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: BlocListener<RegisterCubit, AuthStates>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            DialogUtils.showLoading(context, 'Loading...');
          } else if (state is AuthErrorState) {
            DialogUtils.hideLoading(context);
            DialogUtils.showErrorDialog(context, state.message ?? "Error");
          } else if (state is AuthSuccessState) {
            DialogUtils.hideLoading(context);
            DialogUtils.showSuccessDialog(context, "Account Created Successfully!");
            Navigator.pop(context);
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
                    Center(
                      child: Image.asset(
                        AppAssets.logoRoute,
                        width: 237.w,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 48.h),
                    Text(
                      local.full_name,
                      style: AppStyles.labelWhite18,
                    ),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      controller: nameController,
                      hintText: local.enter_full_name,
                      validator: AppValidators.validateUsername,
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      local.mobile_number,
                      style: AppStyles.labelWhite18,
                    ),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      controller: phoneController,
                      hintText: local.enter_mobile,
                      keyboardType: TextInputType.phone,
                      validator: AppValidators.validatePhone,
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      local.email_address,
                      style: AppStyles.labelWhite18,
                    ),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: local.enter_email,
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidators.validateEmail,
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      local.password,
                      style: AppStyles.labelWhite18,
                    ),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: local.enter_password,
                      isObscureText: true,
                      validator: AppValidators.validatePassword,
                    ),
                    SizedBox(height: 56.h),
                    Builder(
                      builder: (context) {
                        return CustomElevatedButton(
                          text: local.signup,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<RegisterCubit>().register(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    rePassword: passwordController.text, // Assuming rePassword is the same for simplicity or can add another field
                                    phone: phoneController.text,
                                  );
                            }
                          },
                        );
                      }
                    ),
                    SizedBox(height: 50.h),
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
