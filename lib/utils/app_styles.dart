import "package:google_fonts/google_fonts.dart";
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static TextStyle medium18White = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w200,
    color: AppColors.whiteColor,
  );
  static TextStyle medium18black = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w200,
    color: AppColors.blackColor,
  );
  static TextStyle regular12white = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w200,
    color: AppColors.whiteColor,
  );
  static TextStyle regular11white= GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w100,
    color: AppColors.strokColor,
  );
  static TextStyle regular14white= GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w100,
    color: AppColors.strokColor,
  );
  static TextStyle medium14white = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w200,
    color: AppColors.textColor,
  );
  static TextStyle semi20Bold = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.mainColor,
  );
  static TextStyle medium14description = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w200,
    color: AppColors.descriptionColor,
  );
}
