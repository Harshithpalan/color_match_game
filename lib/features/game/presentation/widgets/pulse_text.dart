import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:neon_pulse/core/theme/app_text_styles.dart';

class PulseText extends StatelessWidget {
  final String text;
  final Color color;

  const PulseText({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.gameWord.copyWith(
        color: color,
        shadows: [
          BoxShadow(
            color: color.withOpacity(0.8),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
    )
    .animate(key: ValueKey(text + color.toString())) // Re-trigger on change
    .scale(duration: 200.ms, curve: Curves.easeOutBack, begin: const Offset(0.8, 0.8))
    .then()
    .animate(onPlay: (controller) => controller.repeat(reverse: true))
    .scaleXY(end: 1.1, duration: 1000.ms); // Heartbeat pulse
  }
}
