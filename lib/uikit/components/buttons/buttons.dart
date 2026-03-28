import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../typography/typography.dart';

class AppButtons extends StatefulWidget {
  const AppButtons._({super.key, required this.title, required this.onTap});

  const AppButtons.primary({Key? key, required String title, required VoidCallback onTap})
    : this._(title: title, onTap: onTap, key: key);
  final String title;
  final VoidCallback onTap;

  @override
  State<AppButtons> createState() => _AppButtonsState();
}

class _AppButtonsState extends State<AppButtons> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(999)),
        child: Center(child: Text(widget.title, style: Typographies.labelLarge)),
      ),
    );
  }
}
