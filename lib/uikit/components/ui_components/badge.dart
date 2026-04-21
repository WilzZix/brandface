import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: AppColors.lightBg2,
        borderRadius: BorderRadius.circular(8),
        border: BoxBorder.all(width: 2, color: AppColors.borderColor),
      ),
      child: Text(title, style: Typographies.labelMedium),
    );
  }
}
