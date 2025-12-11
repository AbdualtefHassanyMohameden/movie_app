import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData themeOfApp = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blackColor),
    scaffoldBackgroundColor: AppColors.blackColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blackColor,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.yellowColor),
      titleTextStyle: TextStyle(
        color: AppColors.yellowColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
