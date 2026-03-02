import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_cubit.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';

class WishlistTab extends StatelessWidget {
  const WishlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccessState) {
          final wishlistProducts = state.allProducts?.where((p) => state.wishlistItemIds.contains(p.id)).toList() ?? [];
          
          if (wishlistProducts.isEmpty) {
            return Center(
              child: Text(
                "Your wishlist is empty",
                style: AppStyles.blueMedium18.copyWith(color: AppColors.mainColor),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(16.r),
            itemCount: wishlistProducts.length,
            separatorBuilder: (context, index) => SizedBox(height: 24.h),
            itemBuilder: (context, index) {
              final product = wishlistProducts[index];
              return Container(
                height: 113.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: AppColors.mainColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Image.network(
                        product.imageCover ?? "",
                        width: 120.w,
                        height: 113.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    product.title ?? "",
                                    style: AppStyles.blueMedium18.copyWith(fontSize: 14.sp),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (product.id != null) {
                                        HomeCubit.get(context).toggleFavorite(product.id!);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: const Text('Removed from Wishlist'),
                                            duration: const Duration(seconds: 1),
                                            backgroundColor: AppColors.mainColor,
                                          ),
                                        );
                                      }
                                    },
                                  child: Container(
                                    padding: EdgeInsets.all(4.r),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: const [
                                        BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1)
                                      ],
                                    ),
                                    child: Icon(Icons.favorite, color: AppColors.mainColor, size: 20.sp),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              product.description ?? "",
                              style: AppStyles.blackReg14.copyWith(
                                fontSize: 12.sp, 
                                color: AppColors.textColor.withValues(alpha: 0.6)
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("EGP ${product.price}", style: AppStyles.blueSemi20.copyWith(fontSize: 14.sp)),
                                    Text(
                                      "${(product.price ?? 0) + 500} EGP",
                                      style: AppStyles.blackReg14.copyWith(
                                        fontSize: 10.sp,
                                        decoration: TextDecoration.lineThrough,
                                        color: AppColors.mainColor.withValues(alpha: 0.6),
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (product.id != null) {
                                      bool isInCart = state.cartItemQuantities.containsKey("${product.id}_0_0");
                                      HomeCubit.get(context).toggleCart(product.id!);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(isInCart ? 'Removed from Cart' : 'Added to Cart'),
                                          duration: const Duration(seconds: 1),
                                          backgroundColor: AppColors.mainColor,
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.mainColor,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  ),
                                  child: Text(
                                    state.cartItemQuantities.containsKey("${product.id}_0_0") ? "Remove" : "Add to Cart",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
