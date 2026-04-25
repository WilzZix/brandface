import 'package:brandface/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({super.key});

  static const String tag = '/recommendation-page';

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  Widget _buildActionButton(String assetPath) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(999),
      ),
      child: SvgPicture.asset(assetPath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text(t.home.recommendations_for_you),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 24,
                      top: 16,
                      bottom: 16,
                      right: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightBg2,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(t.common.niche_type, style: Typographies.labelLarge),
                        SvgPicture.asset(AppAssets.icArrowDown),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                _buildActionButton(AppAssets.icSort),
                const SizedBox(width: 6),
                _buildActionButton(AppAssets.icFilter),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.lightBg3,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.common.offer_title_placeholder, style: Typographies.titleMedium),
                  SizedBox(height: 12),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                    style: Typographies.bodySmall,
                  ),
                  SizedBox(height: 12),
                  Divider(color: AppColors.borderColor),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.common.deadline,
                            style: Typographies.titleSmall.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('12.10.2026', style: Typographies.bodyMedium),
                        ],
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.common.deadline,
                            style: Typographies.titleSmall.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 24,
                            child: ListView.separated(
                              itemCount: 2,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightBg2,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    'Cars',
                                    style: Typographies.labelMedium,
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                    return SizedBox(width: 8);
                                  },
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      SvgPicture.asset(AppAssets.icChevronRight),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 16),
          itemCount: 12,
        ),
      ),
    );
  }
}
