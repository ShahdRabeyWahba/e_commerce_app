import 'package:flutter/material.dart';

class AppColors {
  static const Color mainColor = Color(0xFF004182);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color textColor = Color(0xFF06004F);
  static const Color hintColor = Color(0xBF000000);
  
  // Custom Gradients (Compatibility)
  static const List<Color> splashGradient = [
    Color(0xFF004182),
    Color(0xFF004182),
  ];
  
  // Specific UI Colors
  static const Color yellowBanner = Color(0xFFFDD835);
  static const Color greyColor = Color(0xFF7D7D7D);

  // Compatibility Aliases (to avoid breaking existing widgets)
  static const Color strokColor = Color(0xFF004182);
  static const Color descriptionColor = Color(0xFF06004F);
  static const Color transparentColor = Colors.transparent;
}
