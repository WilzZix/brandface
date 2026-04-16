import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

class RowTitleDescription extends StatelessWidget {
  const RowTitleDescription({
    super.key,
    required this.title,
    required this.description,
    this.showDivider = true,
  });

  final String title;
  final String description;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Typographies.titleSmall.copyWith(
                color: AppColors.mutedBlack,
              ),
            ),
            Text(description, style: Typographies.bodyMedium),
          ],
        ),
        if (showDivider) Divider(color: AppColors.borderColor),
      ],
    );
  }
}
