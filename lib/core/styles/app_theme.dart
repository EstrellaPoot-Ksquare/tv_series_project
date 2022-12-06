import 'package:flutter/material.dart';
import 'package:tv_series_app/core/constants/colors.dart';

class AppTheme {
  static final ThemeData theme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.scaffoldBg,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.appBarBg,
      foregroundColor: AppColors.main,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.main,
        foregroundColor: AppColors.scaffoldBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.main,
        // textStyle: const TextStyle(
        //   fontSize: 20,
        // ),
      ),
    ),
  );
}
