import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';

class CartItem extends StatelessWidget {
  final Product product;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onDelete;

  const CartItem({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 113.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.mainColor.withOpacity(0.3), width: 1.w),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.network(
              product.imageCover ?? "",
              height: 113.h,
              width: 120.w,
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
                          style: AppStyles.blueMedium18.copyWith(fontSize: 14.sp, color: AppColors.textColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: onDelete,
                        child: Icon(Icons.delete_outline, color: AppColors.mainColor, size: 24.sp),
                      ),
                    ],
                  ),
                  Text(
                    "Color: Blue | Size: 40", // Dummy size and color as API doesn't provide them yet
                    style: AppStyles.blackReg14.copyWith(fontSize: 12.sp, color: AppColors.textColor.withOpacity(0.6)),
                    maxLines: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'EGP ${product.price}',
                        style: AppStyles.blueSemi20.copyWith(fontSize: 16.sp, color: AppColors.textColor),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (quantity > 1) {
                                  onQuantityChanged(quantity - 1);
                                }
                              },
                              child: Icon(Icons.remove_circle_outline, color: Colors.white, size: 20.sp),
                            ),
                            SizedBox(width: 12.w),
                            Text('$quantity', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                            SizedBox(width: 12.w),
                            GestureDetector(
                              onTap: () {
                                onQuantityChanged(quantity + 1);
                              },
                              child: Icon(Icons.add_circle_outline, color: Colors.white, size: 20.sp),
                            ),
                          ],
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
  }
}
