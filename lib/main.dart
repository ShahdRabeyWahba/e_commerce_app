import 'package:e_commerce_app/Home_screen/Home_screen.dart';
import 'package:e_commerce_app/Screens/cart_screen.dart';
import 'package:e_commerce_app/Screens/product_screen.dart';
import 'package:e_commerce_app/auth/register_screen/login.dart';
import 'package:e_commerce_app/auth/register_screen/register.dart';
import 'package:e_commerce_app/utils/app_routes.dart';
import 'package:e_commerce_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.loginRoute,
          routes: {
            AppRoutes.loginRoute:(context) =>Login(),
            AppRoutes.registerRoute:(context) =>Register(),
            AppRoutes.homescreenRoute:(context) =>HomeScreen(),
            AppRoutes.cartRoute:(context) =>CartScreen(),
            AppRoutes.productRoute:(context) =>ProductScreen(),
          },
          theme:AppTheme.lightTheme,
        );
      }
    );
  }
}