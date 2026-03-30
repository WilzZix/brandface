import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

class FillProfileInformationPage extends StatefulWidget {
  const FillProfileInformationPage({super.key});

  static const String tag = '/fill_profile_information';

  @override
  State<FillProfileInformationPage> createState() => _FillProfileInformationPageState();
}

class _FillProfileInformationPageState extends State<FillProfileInformationPage> {
  List<Widget> fillProfileWidgets = [SizedBox(), SizedBox()];
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Fill profile information', style: Typographies.headlineSmall),
            SizedBox(height: 16),
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
