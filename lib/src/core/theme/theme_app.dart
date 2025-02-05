import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.blue,
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.zero,
      titleAlignment: ListTileTitleAlignment.center,
    ),
    cardTheme: const CardTheme(
      color: AppColors.paleWhite,
      elevation: 0,
      margin: EdgeInsets.only(right: 8, top: 8, bottom: 8),
    ),
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      primary: AppColors.blue,
      secondary: AppColors.slatePurple,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      centerTitle: false,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.blue,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(AppColors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      side: const BorderSide(color: AppColors.mutedAzure, width: 2),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Urbanist',
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Urbanist',
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Urbanist',
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        color: AppColors.slatePurple,
        fontWeight: FontWeight.w700,
        fontFamily: 'Urbanist',
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.slatePurple,
        fontWeight: FontWeight.w500,
        fontFamily: 'Urbanist',
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        color: AppColors.slateBlue,
        fontWeight: FontWeight.w500,
        fontFamily: 'Urbanist',
      ),
    ),
  );
}
