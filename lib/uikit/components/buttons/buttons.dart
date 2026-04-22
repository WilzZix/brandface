import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../typography/typography.dart';

class AppButtons extends StatefulWidget {
  const AppButtons._({super.key, required this.title, this.onTap});

  const AppButtons.primary({Key? key, required String title, VoidCallback? onTap})
    : this._(title: title, onTap: onTap, key: key);
  final String title;
  final VoidCallback? onTap;

  @override
  State<AppButtons> createState() => _AppButtonsState();
}

class _AppButtonsState extends State<AppButtons> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: _isPressed ? AppColors.primary.withValues(alpha: 0.85) : AppColors.primary,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Center(child: Text(widget.title, style: Typographies.labelLarge)),
        ),
      ),
    );
  }
}
