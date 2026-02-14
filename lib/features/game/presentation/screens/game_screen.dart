import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:neon_pulse/core/theme/app_colors.dart';
import 'package:neon_pulse/core/theme/app_text_styles.dart';
import 'package:neon_pulse/features/game/logic/game_provider.dart';
import 'package:neon_pulse/features/game/presentation/widgets/glass_container.dart';
import 'package:neon_pulse/features/game/presentation/widgets/neon_button.dart';
import 'package:neon_pulse/features/game/presentation/widgets/pulse_text.dart';
import 'game_over_screen.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);

    // Navigate to Game Over if game ends
    ref.listen(gameProvider, (previous, next) {
      if (next.isGameOver) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => GameOverScreen(score: next.score),
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
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
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Responsive horizontal padding (5-10% of width)
              double horizontalPadding = constraints.maxWidth * 0.08;
              if (constraints.maxWidth < 600) horizontalPadding = 20;

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Header: Timer & Score
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlassContainer(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.timer, color: AppColors.neonBlue),
                              const SizedBox(width: 8),
                              Text(
                                '${gameState.timeLeft}s',
                                style: AppTextStyles.h2,
                              ),
                            ],
                          ),
                        ),
                        GlassContainer(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'SCORE: ${gameState.score}',
                            style: AppTextStyles.h2.copyWith(color: AppColors.neonGreen),
                          ),
                        ),
                      ],
                    ),

                    // Game Title / Instruction
                    Column(
                      children: [
                        Text(
                          'TAP THE COLOR!',
                          style: AppTextStyles.body.copyWith(
                            letterSpacing: 4,
                            color: AppColors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ).animate().fadeIn().scale(),
                        const SizedBox(height: 24),
                        PulseText(
                          text: gameState.targetWord,
                          color: gameState.targetColor,
                        ),
                      ],
                    ),

                    // Options Grid - centered in lower half
                    Flexible(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: constraints.maxWidth > 800 ? 4 : 2,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: constraints.maxWidth > 800 ? 1.8 : 1.5,
                          physics: const NeverScrollableScrollPhysics(),
                          children: gameState.options.map((color) {
                            String colorName = _getColorName(color);
                            return NeonButton(
                              text: colorName,
                              color: color,
                              onTap: () {
                                ref.read(gameProvider.notifier).checkAnswer(color);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    
                    // Bottom space to keep buttons "lower-middle"
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _getColorName(Color color) {
    if (color == AppColors.neonBlue) return "BLUE";
    if (color == AppColors.neonPink) return "PINK";
    if (color == AppColors.neonPurple) return "PURPLE";
    if (color == AppColors.neonGreen) return "GREEN";
    if (color == AppColors.brightOrange) return "ORANGE";
    return "";
  }
}
