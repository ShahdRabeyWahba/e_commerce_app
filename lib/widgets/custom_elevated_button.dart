import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final TextStyle? style;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.h),
          elevation: 0,
        ),
        child: Text(
          text,
          style: style ?? AppStyles.blueSemi20,
        ),
      ),
    );
  }
}
