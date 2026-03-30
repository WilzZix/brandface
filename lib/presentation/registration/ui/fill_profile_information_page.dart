import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import 'components/general_info_page_view.dart';

class FillProfileInformationPage extends StatefulWidget {
  const FillProfileInformationPage({super.key});

  static const String tag = '/fill_profile_information';

  @override
  State<FillProfileInformationPage> createState() =>
      _FillProfileInformationPageState();
}

class _FillProfileInformationPageState
    extends State<FillProfileInformationPage> {
  List<Widget> fillProfileWidgets = [
    SizedBox(child: GeneralInfoPageView()),
    SizedBox(child: Text('Second page')),
  ];
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButtons.primary(title: t.onboarding.kContinue, onTap: () {}),
            SizedBox(height: 8),
            Text('Save and continue later', style: Typographies.labelLarge),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16 + MediaQuery.of(context).padding.top),
            Text('Fill profile information', style: Typographies.headlineSmall),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(999),
                    color: AppColors.lightBg2,
                  ),
                  child: SvgPicture.asset(AppAssets.icArrowLeft),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(999),
                      color: AppColors.black,
                    ),
                    child: Center(
                      child: Text(
                        'General info (1/6)',
                        style: Typographies.labelMedium.copyWith(
                          color: AppColors.lightBg,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(999),
                    color: AppColors.lightBg2,
                  ),
                  child: SvgPicture.asset(AppAssets.icArrowRight),
                ),
              ],
            ),
            SizedBox(height: 24),
            Expanded(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: pageController,
                itemCount: fillProfileWidgets.length,
                itemBuilder: (context, index) {
                  return fillProfileWidgets[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
