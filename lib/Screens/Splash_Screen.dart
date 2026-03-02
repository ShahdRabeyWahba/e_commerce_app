import 'dart:async';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.loginScreenRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mainColor.withOpacity(0.8),
              AppColors.mainColor,
              AppColors.mainColor.shade900,
            ],
            stops: const [0.0, 0.4, 1.0],
          ),
        ),
        child: Center(
          child: Image.asset(
            AppAssets.logoRoute,
            width: 237.w,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

extension on Color {
  Color get shade900 => withBlue(90).withRed(0).withGreen(20); // Simplified shade for demo
}