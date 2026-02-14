import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neon_pulse/core/theme/app_colors.dart';
import 'package:neon_pulse/core/theme/app_text_styles.dart';

class NeonButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  final bool isOutline;

  const NeonButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    this.isOutline = false,
  });

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap();
          HapticFeedback.lightImpact();
        },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: widget.isOutline 
                    ? Colors.transparent 
                    : widget.color.withOpacity(_isHovered ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: widget.color.withOpacity(_isHovered ? 1.0 : 0.8),
                  width: _isHovered ? 3 : 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(widget.isOutline ? 0.3 : 0.6),
                    blurRadius: _isHovered ? 25 : 15,
                    spreadRadius: _isHovered ? 2 : 1,
                  ),
                  if (_isHovered)
                    BoxShadow(
                      color: widget.color.withOpacity(0.4),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Center(
                child: Text(
                  widget.text,
                  style: AppTextStyles.button.copyWith(
                    color: widget.isOutline ? widget.color : AppColors.white,
                    fontWeight: _isHovered ? FontWeight.bold : FontWeight.normal,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: widget.color,
                        blurRadius: _isHovered ? 15 : 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
