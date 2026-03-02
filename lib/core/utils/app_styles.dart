import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppStyles {
  // Brand Blue Styles
  static TextStyle blueSemi20 = GoogleFonts.poppins(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.mainColor,
  );

  static TextStyle blueMedium18 = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.mainColor,
  );

  // White Styles
  static TextStyle whiteReg14 = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteColor,
  );

  static TextStyle whiteMedium18 = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteColor,
  );

  static TextStyle whiteSemi24 = GoogleFonts.poppins(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );

  static TextStyle whiteLight16 = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w300,
    color: AppColors.whiteColor,
  );

  // Black/Dark Styles
  static TextStyle blackMedium18 = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );

  static TextStyle blackReg14 = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  );

  // Labels
  static TextStyle labelWhite18 = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteColor,
  );

  // Hint
  static TextStyle hintStyle = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.w300,
    color: const Color(0xBF000000).withOpacity(0.7),
  );

  // Compatibility Aliases (to avoid breaking existing widgets)
  static TextStyle get medium18White => whiteMedium18;
  static TextStyle get medium18black => blackMedium18;
  static TextStyle get regular12white => whiteReg14; // Approximate
  static TextStyle get regular11white => whiteReg14.copyWith(fontSize: 11.sp);
  static TextStyle get regular14white => whiteReg14;
  static TextStyle get medium14white => whiteReg14.copyWith(fontWeight: FontWeight.w500);
  static TextStyle get light16white => whiteLight16;
  static TextStyle get semi20white => blueSemi20;
  static TextStyle get semi24white => whiteSemi24;
  static TextStyle get medium14White => medium14white;
}
