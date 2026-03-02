import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_cubit.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductTabItem extends StatelessWidget {
  final Product product;
  const ProductTabItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/product-details', arguments: product),
      child: Container(
        width: 191.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.mainColor.withOpacity(0.3), width: 1.5.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                  child: Image.network(
                    product.imageCover ?? "",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      bool isFavorite = false;
                      if (state is HomeSuccessState) {
                        isFavorite = state.wishlistItemIds.contains(product.id);
                      }
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (product.id != null) {
                            HomeCubit.get(context).toggleFavorite(product.id!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(isFavorite ? 'Removed from Wishlist' : 'Added to Wishlist'),
                                duration: const Duration(seconds: 1),
                                backgroundColor: AppColors.mainColor,
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1)
                            ],
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: AppColors.mainColor,
                            size: 20.sp,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title ?? "",
                  style: AppStyles.blueMedium18.copyWith(fontSize: 14.sp, color: AppColors.textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product.description ?? "",
                  style: AppStyles.blackReg14.copyWith(fontSize: 14.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      'EGP ${product.price}',
                      style: AppStyles.blueMedium18.copyWith(fontSize: 14.sp, color: AppColors.textColor),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${(product.price ?? 0) + 500} EGP',
                      style: AppStyles.blackReg14.copyWith(
                        fontSize: 11.sp,
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.mainColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Review (${product.ratingsAverage})',
                          style: AppStyles.blackReg14.copyWith(fontSize: 12.sp),
                        ),
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                      ],
                    ),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        bool isInCart = false;
                        if (state is HomeSuccessState) {
                          isInCart = state.cartItemIds.contains(product.id);
                        }
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            if (product.id != null) {
                              HomeCubit.get(context).toggleCart(product.id!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(isInCart ? 'Removed from Cart' : 'Added to Cart Successfully'),
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: AppColors.mainColor,
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(4.r),
                            child: Icon(
                              isInCart ? Icons.check_circle : Icons.add_circle,
                              color: AppColors.mainColor,
                              size: 30.sp,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
   );
  }
}
