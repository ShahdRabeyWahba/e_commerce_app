import 'package:e_commerce_app/Features/UI/home/cubit/home_cubit.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';
import 'package:e_commerce_app/core/localization/app_localizations.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/widgets/product_tab_item.dart';
import 'package:e_commerce_app/widgets/subcategory_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(color: AppColors.mainColor.withValues(alpha: 0.5)),
                          ),
                          child: TextField(
                            textAlign: TextAlign.start,
                            onChanged: (value) {
                              HomeCubit.get(context).searchProducts(value);
                            },
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).search,
                              hintStyle: AppStyles.hintStyle.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.mainColor.withValues(alpha: 0.6),
                              ),
                              prefixIcon: Icon(Icons.search, size: 28.sp, color: AppColors.mainColor),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Builder(builder: (context) {
                        int totalItems = 0;
                        if (state is HomeSuccessState) {
                          totalItems = state.cartItemQuantities.values
                              .fold(0, (sum, qty) => sum + qty);
                        }
                        return InkWell(
                          onTap: () => Navigator.pushNamed(context, AppRoutes.cartRoute),
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
                      }),
                    ],
                  ),
                ),
                Expanded(
                  child: state is HomeLoadingState
                      ? const Center(child: CircularProgressIndicator(color: AppColors.mainColor))
                      : state is HomeSuccessState
                          ? Row(
                              children: [
                                // Sidebar
                                Container(
                                  width: 140.w,
                                  color: const Color(0xFFF3F3F3),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: state.categories?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final cats = state.categories!;
                                      bool isSelected = state.selectedCategoryId == cats[index].id;
                                      return InkWell(
                                        onTap: () {
                                          HomeCubit.get(context).filterByCategory(cats[index].id);
                                        },
                                        child: Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Container(
                                              height: 80.h,
                                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                                              decoration: BoxDecoration(
                                                color: isSelected ? Colors.white : Colors.transparent,
                                              ),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                cats[index].name ?? "",
                                                style: AppStyles.blueSemi20.copyWith(
                                                  fontSize: 13.sp,
                                                  color: isSelected ? AppColors.mainColor : AppColors.textColor.withValues(alpha: 0.7),
                                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            if (isSelected)
                                              Container(
                                                height: 60.h,
                                                width: 7.w,
                                                decoration: BoxDecoration(
                                                  color: AppColors.mainColor,
                                                  borderRadius: BorderRadius.circular(20.r),
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                // Content Area (Subcategories)
                                Expanded(
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverToBoxAdapter(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.categories?.firstWhere((c) => c.id == state.selectedCategoryId, orElse: () => state.categories![0]).name ?? "",
                                                style: AppStyles.blueSemi20.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(height: 12.h),
                                              // Banner Image for Category
                                              Container(
                                                height: 100.h,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.r),
                                                  image: DecorationImage(
                                                    image: NetworkImage(state.categories?.firstWhere((c) => c.id == state.selectedCategoryId, orElse: () => state.categories![0]).image ?? ""),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 16.h),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SliverPadding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                                        sliver: SliverGrid(
                                          delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                              final subcat = state.subcategories![index];
                                              return InkWell(
                                                onTap: () {
                                                  // When subcategory is clicked, maybe filter products?
                                                  // For now just keep it as is.
                                                },
                                                child: SubCategoryItem(
                                                  subcategory: subcat,
                                                  categoryImage: state.categories?.firstWhere((c) => c.id == state.selectedCategoryId, orElse: () => state.categories![0]).image ?? "",
                                                ),
                                              );
                                            },
                                            childCount: state.subcategories?.length ?? 0,
                                          ),
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 0.75,
                                            crossAxisSpacing: 12.w,
                                            mainAxisSpacing: 12.h,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : state is HomeErrorState
                              ? Center(child: Text(state.errorMessage ?? "Error"))
                              : const SizedBox(),
                ),
              ],
            ),
          );
        },
        );
  }
}
