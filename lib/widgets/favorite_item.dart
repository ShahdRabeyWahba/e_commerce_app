import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 113.h,
      width: 398.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.strokColor, width: 1.w),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.network(
              'https://via.placeholder.com/120',
              height: 113.h,
              width: 120.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Favorite Product', style: AppStyles.medium18black),
                Text('Price: \$200', style: AppStyles.medium14white),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Icon(Icons.favorite, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
