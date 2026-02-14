import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neon_pulse/core/theme/app_theme.dart';
import 'package:neon_pulse/features/game/presentation/screens/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: NeonPulseApp()));
}

class NeonPulseApp extends StatelessWidget {
  const NeonPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neon Pulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
