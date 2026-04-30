import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppAssets.icEmpty, width: 104, height: 84),
          const SizedBox(height: 24),
          Text(
            title,
            style: Typographies.titleLarge.copyWith(
              color: AppColors.mutedBlack,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
