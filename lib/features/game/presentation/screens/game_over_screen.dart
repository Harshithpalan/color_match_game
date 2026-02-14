import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:neon_pulse/core/theme/app_colors.dart';
import 'package:neon_pulse/core/theme/app_text_styles.dart';
import 'package:neon_pulse/features/game/logic/game_provider.dart';
import 'package:neon_pulse/features/game/presentation/screens/start_screen.dart';
import 'package:neon_pulse/features/game/presentation/widgets/glass_container.dart';
import 'package:neon_pulse/features/game/presentation/widgets/neon_button.dart';
import 'game_screen.dart';

class GameOverScreen extends ConsumerWidget {
  final int score;
  const GameOverScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.read(gameProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                Center(
                  child: Text(
                    'GAME OVER',
                    style: AppTextStyles.display.copyWith(color: AppColors.red),
                  ).animate().shake(duration: 500.ms),
                ),
                const SizedBox(height: 48),
                
                GlassContainer(
                  child: Column(
                    children: [
                      Text('FINAL SCORE', style: AppTextStyles.h2),
                      Text(
                        '$score',
                        style: AppTextStyles.score.copyWith(fontSize: 64, color: AppColors.white),
                      ),
                      const Divider(color: AppColors.white70),
                      Text('BEST SCORE', style: AppTextStyles.h2),
                      Text(
                        '${gameState.highScore}',
                        style: AppTextStyles.score.copyWith(fontSize: 32, color: AppColors.neonGreen),
                      ),
                    ],
                  ),
                ).animate().slideY(begin: 0.5),

                const SizedBox(height: 64),

                NeonButton(
                  text: 'PLAY AGAIN',
                  color: AppColors.neonBlue,
                  onTap: () {
                    ref.read(gameProvider.notifier).startGame();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const GameScreen()),
                    );
                  },
                ),
                
                const SizedBox(height: 16),
                
                NeonButton(
                  text: 'HOME',
                  color: AppColors.neonPink,
                  isOutline: true,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const StartScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
