import 'package:e_commerce_app/Features/UI/home/cubit/home_cubit.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductTabItem extends StatelessWidget {
  final Product product;
  const ProductTabItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/product-details', arguments: product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: AppColors.mainColor.withValues(alpha: 0.3),
            width: 2.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image Section ──
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13.r),
                      topRight: Radius.circular(13.r),
                    ),
                    child: Image.network(
                      product.imageCover ?? '',
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: const Color(0xFFF5F5F5),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.mainColor,
                              value: progress.expectedTotalBytes != null
                                  ? progress.cumulativeBytesLoaded /
                                      progress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, e, s) => Container(
                        color: const Color(0xFFF5F5F5),
                        child: Icon(Icons.image_not_supported_outlined,
                            color: Colors.grey[400], size: 36),
                      ),
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        bool isFav = false;
                        if (state is HomeSuccessState) {
                          isFav = state.wishlistItemIds.contains(product.id);
                        }
                        return GestureDetector(
                          onTap: () {
                            if (product.id != null) {
                              HomeCubit.get(context)
                                  .toggleFavorite(product.id!);
                            }
                          },
                          child: Container(
                            width: 30.w,
                            height: 30.w,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12, blurRadius: 4)
                              ],
                            ),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: AppColors.mainColor,
                              size: 18.sp,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ── Info Section ──
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Text(
                      product.title ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Description
                    Text(
                      product.description ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: AppColors.mainColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Price row
                    Row(
                      children: [
                        Text(
                          'EGP ${product.price?.toStringAsFixed(0)}',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainColor,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          '${((product.price ?? 0) + 800).toStringAsFixed(0)} EGP',
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.mainColor.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),

                    // Review + Add-to-cart row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Review (${product.ratingsAverage ?? 0})',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: AppColors.mainColor,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(Icons.star,
                                color: Colors.amber, size: 15.sp),
                          ],
                        ),
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            bool isInCart = false;
                            if (state is HomeSuccessState) {
                              isInCart = state.cartItemQuantities
                                  .containsKey('${product.id}_0_0');
                            }
                            return GestureDetector(
                              onTap: () {
                                if (product.id != null) {
                                  HomeCubit.get(context)
                                      .toggleCart(product.id!);
                                }
                              },
                              child: Container(
                                width: 30.w,
                                height: 30.w,
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isInCart ? Icons.check : Icons.add,
                                  color: Colors.white,
                                  size: 20.sp,
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
            ),
          ],
        ),
      ),
    );
  }
}
