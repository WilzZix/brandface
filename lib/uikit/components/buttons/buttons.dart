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
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: _isPressed ? AppColors.primary.withValues(alpha: 0.7) : AppColors.primary,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Center(child: Text(widget.title, style: Typographies.labelLarge)),
        ),
      ),
    );
  }
}

/// A text-style tappable action (e.g. "O'chirish", "Asosiy qilish") with the
/// same press feedback as [AppButtons] and — crucially — an *opaque, padded*
/// hit target so taps anywhere on the button register (a bare
/// `GestureDetector` around a `Text` only reacts to hits on the glyphs
/// themselves). Pass a null [onTap] to render it disabled (dimmed, no feedback).
class AppTextButton extends StatefulWidget {
  const AppTextButton({
    super.key,
    required this.title,
    this.onTap,
    this.color,
    this.textStyle,
    this.leading,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  });

  final String title;
  final VoidCallback? onTap;
  final Color? color;
  final TextStyle? textStyle;

  /// Optional widget shown before the label (e.g. a "+" icon).
  final Widget? leading;
  final EdgeInsetsGeometry padding;

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null;
    final baseStyle = widget.textStyle ?? Typographies.labelLarge;
    final style = widget.color != null
        ? baseStyle.copyWith(color: widget.color)
        : baseStyle;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: enabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: enabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: enabled ? () => setState(() => _isPressed = false) : null,
      child: AnimatedOpacity(
        opacity: !enabled
            ? 0.4
            : _isPressed
            ? 0.55
            : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedScale(
          scale: _isPressed ? 0.96 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Padding(
            padding: widget.padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.leading != null) ...[
                  widget.leading!,
                  const SizedBox(width: 8),
                ],
                Text(widget.title, style: style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
