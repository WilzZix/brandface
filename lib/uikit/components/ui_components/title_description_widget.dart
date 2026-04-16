import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

class TitleDescriptionWidget extends StatelessWidget {
  const TitleDescriptionWidget({
    super.key,
    required this.title,
    required this.descriptionItem,
  });

  final String title;
  final Widget descriptionItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Typographies.titleSmall.copyWith(color: AppColors.mutedBlack),
        ),
        SizedBox(height: 4),
        descriptionItem,
      ],
    );
  }
}
