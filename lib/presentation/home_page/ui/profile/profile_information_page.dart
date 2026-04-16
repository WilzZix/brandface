import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/components/ui_components/title_description_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../uikit/typography/typography.dart';

class ProfileInformationPage extends StatefulWidget {
  const ProfileInformationPage({super.key});

  static const String tag = '/profile-information-page';

  @override
  State<ProfileInformationPage> createState() => _ProfileInformationPageState();
}

class _ProfileInformationPageState extends State<ProfileInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile information'),
        centerTitle: false,
        actions: [SvgPicture.asset(AppAssets.icPen)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('General info', style: Typographies.titleSmall),
              SizedBox(height: 8),
              AppContainer(
                child: Column(
                  children: [
                    TitleDescriptionWidget(
                      title: 'Full name',
                      descriptionItem: Text(
                        'Barotov Nodirbek',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
