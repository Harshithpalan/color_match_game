import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:neon_pulse/core/theme/app_colors.dart';
import 'package:neon_pulse/core/theme/app_text_styles.dart';
import 'package:neon_pulse/features/game/presentation/screens/start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const StartScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NEON',
              style: AppTextStyles.display.copyWith(color: AppColors.neonBlue),
            ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0),
            
            Text(
              'PULSE',
              style: AppTextStyles.display.copyWith(color: AppColors.neonPink),
            ).animate().fadeIn(delay: 400.ms, duration: 800.ms).slideY(begin: 0.2, end: 0)
            .then().shimmer(duration: 1200.ms, color: Colors.white),
            
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: AppColors.neonGreen,
            ).animate().scale(delay: 1.seconds),
          ],
        ),
      ),
    );
  }
}
