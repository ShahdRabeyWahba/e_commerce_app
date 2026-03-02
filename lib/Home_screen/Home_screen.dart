import 'package:e_commerce_app/Features/UI/home/cubit/home_cubit.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';
import 'package:e_commerce_app/core/localization/app_localizations.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/home_screen/widgets/categories_tab.dart';
import 'package:e_commerce_app/home_screen/widgets/home_tab.dart';
import 'package:e_commerce_app/home_screen/widgets/profile_tab.dart';
import 'package:e_commerce_app/home_screen/widgets/wishlist_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _tabs = [
    HomeTab(onViewAll: () {
      setState(() {
        _currentIndex = 1;
      });
    }, onCategoryTap: (id) {
      HomeCubit.get(context).filterByCategory(id);
      Navigator.pushNamed(context, AppRoutes.productRoute);
    }),
    const CategoriesTab(),
    const WishlistTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        toolbarHeight: 55.h,
        title: Image.asset(
          AppAssets.logoRoute,
          width: 120.w,
          color: AppColors.mainColor,
        ),
      ),
      body: Column(
        children: [
          // Search Bar & Cart (Persistent across tabs except Profile)
          if (_currentIndex != 3)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        border: Border.all(
                            color: AppColors.mainColor.withValues(alpha: 0.5)),
                      ),
                      child: TextField(
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (value) {
                          if (_currentIndex != 0 && value.isNotEmpty) {
                            setState(() {
                              _currentIndex = 0;
                            });
                          }
                          HomeCubit.get(context).searchProducts(value);
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context).search,
                          hintStyle: AppStyles.hintStyle.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.mainColor.withValues(alpha: 0.6),
                          ),
                          prefixIcon: Icon(Icons.search,
                              size: 28.sp, color: AppColors.mainColor),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      int totalItems = 0;
                      if (state is HomeSuccessState) {
                        totalItems = state.cartItemQuantities.values
                            .fold(0, (sum, qty) => sum + qty);
                      }
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.cartRoute);
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Image.asset(
                              AppAssets.iconCart,
                              height: 26.h,
                              width: 26.w,
                              color: AppColors.mainColor,
                            ),
                            if (totalItems > 0)
                              Positioned(
                                top: -6.h,
                                right: -6.w,
                                child: Container(
                                  padding: EdgeInsets.all(3.r),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 16.w,
                                    minHeight: 16.h,
                                  ),
                                  child: Text(
                                    totalItems > 99 ? '99+' : '$totalItems',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          Expanded(
            child: _tabs[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 75.h,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(AppAssets.iconHome, 0),
            _navItem(AppAssets.iconCategories, 1),
            _navItem(AppAssets.iconFavorite, 2),
            _navItem(AppAssets.iconProfile, 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String assetPath, int index) {
    bool isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: isSelected
            ? const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              )
            : null,
        child: Image.asset(
          assetPath,
          color: isSelected ? AppColors.mainColor : Colors.white,
          height: 28.h,
          width: 28.w,
        ),
      ),
    );
  }
}
