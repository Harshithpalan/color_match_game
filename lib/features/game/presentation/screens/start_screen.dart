import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:neon_pulse/core/theme/app_colors.dart';
import 'package:neon_pulse/core/theme/app_text_styles.dart';
import 'package:neon_pulse/features/game/logic/game_provider.dart';
import 'package:neon_pulse/features/game/presentation/screens/game_screen.dart';
import 'package:neon_pulse/features/game/presentation/widgets/glass_container.dart';
import 'package:neon_pulse/features/game/presentation/widgets/neon_button.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Background particles or gradient could go here
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.5,
                colors: [
                  Color(0xFF1A1A2E),
                  AppColors.background,
                ],
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  
                  // Title
                  Center(
                    child: Column(
                      children: [
                         Text(
                          'NEON',
                          style: AppTextStyles.display.copyWith(
                            fontSize: 60,
                            color: AppColors.neonBlue,
                            shadows: [
                              const BoxShadow(
                                color: AppColors.neonBlue,
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ]
                          ),
                        ).animate().fade().scale(),
                         Text(
                          'PULSE',
                          style: AppTextStyles.display.copyWith(
                             fontSize: 60,
                             color: AppColors.neonPink,
                             shadows: [
                              const BoxShadow(
                                color: AppColors.neonPink,
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ]
                          ),
                        ).animate().fade(delay: 200.ms).scale(),
                      ],
                    )
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // High Score
                  GlassContainer(
                    child: Column(
                      children: [
                        Text('BEST SCORE', style: AppTextStyles.h2),
                        const SizedBox(height: 8),
                        Text(
                          '${gameState.highScore}',
                          style: AppTextStyles.score.copyWith(fontSize: 48),
                        ),
                      ],
                    ),
                  ).animate().slideY(begin: 0.2, end: 0).fade(),

                  const Spacer(),

                  // Play Button
                  NeonButton(
                    text: 'START GAME',
                    color: AppColors.neonGreen,
                    onTap: () {
                      ref.read(gameProvider.notifier).startGame();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const GameScreen()),
                      );
                    },
                  ).animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  ).scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.05, 1.05),
                    duration: 1.5.seconds,
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
