import 'package:e_commerce_app/home_screen/home_screen.dart';
import 'package:e_commerce_app/screens/cart_screen.dart';
import 'package:e_commerce_app/screens/product_screen.dart';
import 'package:e_commerce_app/Features/UI/auth/Login/login_screen.dart';
import 'package:e_commerce_app/Features/UI/auth/register_screen/register_screen.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_theme.dart';
import 'package:e_commerce_app/screens/splash_screen.dart';
import 'package:e_commerce_app/screens/product_details_screen.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/localization/app_localizations.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_cubit.dart';

import 'core/di/di.dart';
import 'core/utils/prefs_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await PrefsHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child){
        return BlocProvider(
          create: (context) => getIt<HomeCubit>()..getHomeData(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            // locale: const Locale('en'), // Allow system locale to take effect
            initialRoute: AppRoutes.splashRoute,
            routes: {
              AppRoutes.splashRoute:(context) =>const SplashScreen(),
              AppRoutes.loginScreenRoute:(context) => const LoginScreen(),
              AppRoutes.registerScreenRoute:(context) => const RegisterScreen(),
              AppRoutes.homescreenRoute:(context) => const HomeScreen(),
              AppRoutes.productRoute:(context) => const ProductScreen(),
              AppRoutes.cartRoute: (context) => const CartScreen(),
              '/product-details': (context) {
                final product = ModalRoute.of(context)!.settings.arguments as Product;
                return ProductDetailsScreen(product: product);
              },
            },
            theme:AppTheme.lightTheme,
          ),
        );
      }
    );
  }
}