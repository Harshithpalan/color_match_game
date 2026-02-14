import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF0D0D0D);
  static const Color surface = Color(0xFF1A1A1A);
  
  // Neon Colors
  static const Color neonBlue = Color(0xFF00F3FF);
  static const Color neonPink = Color(0xFFFF00FF);
  static const Color neonPurple = Color(0xFFBC13FE);
  static const Color neonGreen = Color(0xFF00FF00); // Lime Green
  static const Color brightOrange = Color(0xFFFF5F1F);
  
  // Neutral
  static const Color white = Colors.white;
  static const Color white70 = Colors.white70;
  static const Color red = Colors.redAccent;
  
  // List of game colors for random selection
  static const List<Color> gameColors = [
    neonBlue,
    neonPink,
    neonPurple,
    neonGreen,
    brightOrange,
  ];

  static Color getRandomColor() {
    return (gameColors..shuffle()).first;
  }
}
