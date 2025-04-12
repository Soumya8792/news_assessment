import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0D47A1);
  static const Color secondary = Color(0xFF1976D2);
  static const Color accent = Color(0xFF64B5F6);

  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Color(0xFF9E9E9E);

  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFFBC02D);

  static const Color background = Color(0xFFF5F5F5);
}




class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16.0, color: AppColors.black),
      bodyMedium: TextStyle(fontSize: 14.0, color: AppColors.grey),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16.0, color: AppColors.white),
      bodyMedium: TextStyle(fontSize: 14.0, color: AppColors.grey),
    ),
  );
}