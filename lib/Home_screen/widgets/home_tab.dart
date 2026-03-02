import 'package:e_commerce_app/Features/UI/home/cubit/home_cubit.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';
import 'package:e_commerce_app/core/localization/app_localizations.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/widgets/category_brand_item.dart';
import 'package:e_commerce_app/widgets/product_tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback onViewAll;
  const HomeTab({super.key, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(child: CircularProgressIndicator(color: AppColors.mainColor));
        } else if (state is HomeSuccessState) {
          final local = AppLocalizations.of(context);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner
                _buildBanner(),

                // Categories Header
                _buildHeader(local.categories, local.view_all, onViewAll),
                
                // Categories Horizontal List (2 Rows)
                SizedBox(
                  height: 280.h,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: state.categories?.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                      mainAxisSpacing: 16.w,
                      crossAxisSpacing: 16.h,
                    ),
                    itemBuilder: (context, index) {
                      return CategoryBrandItem(category: state.categories![index]);
                    },
                  ),
                ),

                // Home Appliance Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Text(local.home_appliance, style: AppStyles.blueMedium18),
                ),

                // Products Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                ),
                SizedBox(height: 80.h),
              ],
            ),
          );
        } else if (state is HomeErrorState) {
          return Center(child: Text(state.errorMessage ?? "Error"));
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 190.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.yellowBanner,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20.w,
            top: 20.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("UP TO\n25% OFF", style: AppStyles.blueSemi20.copyWith(fontSize: 22.sp)),
                SizedBox(height: 8.h),
                Text("For all Headphones\n& AirPods",
                    style: AppStyles.blueMedium18.copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal)),
                SizedBox(height: 12.h),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: Text("Shop Now", style: AppStyles.whiteMedium18.copyWith(fontSize: 12.sp)),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.network(
              'https://ecommerce.routemisr.com/api/v1/images/1706691456254.png',
              height: 150.h,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(String title, String actionText, [VoidCallback? onTap]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppStyles.blueMedium18),
          InkWell(
            onTap: onTap,
            child: Text(actionText, style: AppStyles.blackReg14.copyWith(fontSize: 12.sp)),
          ),
        ],
      ),
    );
  }
}
