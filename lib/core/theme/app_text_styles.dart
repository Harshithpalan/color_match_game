import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get display => GoogleFonts.orbitron(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    shadows: [
      Shadow(
        blurRadius: 10.0,
        color: AppColors.neonBlue,
        offset: Offset(0, 0),
      ),
    ],
  );

  static TextStyle get gameWord => GoogleFonts.orbitron(
    fontSize: 64,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.0,
    // Color will be dynamic
  );

  static TextStyle get h1 => GoogleFonts.orbitron(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle get h2 => GoogleFonts.orbitron(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle get button => GoogleFonts.orbitron(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.background, // Text on neon button usually looks best dark
  );

  static TextStyle get score => GoogleFonts.orbitron(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.neonGreen,
  );
  
  static TextStyle get body => GoogleFonts.orbitron(
    fontSize: 16,
    color: AppColors.white70,
  );
}
