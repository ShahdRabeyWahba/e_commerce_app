import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/domain/entities/response/category/subcategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SubCategoryItem extends StatelessWidget {
  final Subcategory subcategory;
  final String categoryImage;
  const SubCategoryItem({super.key, required this.subcategory, required this.categoryImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: NetworkImage(categoryImage), // Subcategories often don't have images in Route API, so we use category image
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          subcategory.name ?? "",
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: AppColors.mainColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
