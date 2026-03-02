import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isObscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.isObscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isObscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      style: AppStyles.blackMedium18,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppStyles.hintStyle.copyWith(
          fontSize: 18.sp,
          color: Colors.grey.shade500,
        ),
        suffixIcon: widget.isObscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.mainColor,
                ),
              )
            : widget.suffixIcon,
        fillColor: AppColors.whiteColor,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: AppColors.mainColor, width: 1),
        ),
      ),
    );
  }
}
