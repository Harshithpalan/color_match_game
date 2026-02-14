import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.neonBlue,
      textTheme: GoogleFonts.orbitronTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: AppColors.white,
        displayColor: AppColors.white,
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonBlue,
        secondary: AppColors.neonPink,
        background: AppColors.background,
        surface: AppColors.surface,
      ),
      useMaterial3: true,
    );
  }
}
