import 'package:e_commerce_app/Features/UI/home/cubit/home_cubit.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/widgets/product_tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              toolbarHeight: 50.h,
              title: Image.asset(
                AppAssets.logoRoute,
                width: 66.w,
                color: AppColors.mainColor,
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(color: AppColors.mainColor.withOpacity(0.5)),
                          ),
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: "what do you search for?",
                              hintStyle: AppStyles.hintStyle.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.mainColor.withOpacity(0.6),
                              ),
                              prefixIcon: Icon(Icons.search, size: 28.sp, color: AppColors.mainColor),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 0.h),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, '/cart'),
                        child: Image.asset(
                          AppAssets.iconCart,
                          height: 24.h,
                          width: 24.w,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: state is HomeLoadingState
                      ? const Center(child: CircularProgressIndicator(color: AppColors.mainColor))
                      : state is HomeSuccessState
                          ? GridView.builder(
                              padding: EdgeInsets.all(16.r),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 16.w,
                                mainAxisSpacing: 16.h,
                              ),
                              itemCount: state.products?.length ?? 0,
                              itemBuilder: (context, index) {
                                return ProductTabItem(product: state.products![index]);
                              },
                            )
                          : state is HomeErrorState
                              ? Center(child: Text(state.errorMessage ?? "Error"))
                              : const SizedBox(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
