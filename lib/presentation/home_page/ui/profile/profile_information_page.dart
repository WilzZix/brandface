import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/components/ui_components/badge.dart';
import 'package:brandface/uikit/components/ui_components/title_description_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../uikit/tokens/colors.dart';
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
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SvgPicture.asset(AppAssets.icPen),
            ),
          ),
        ],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/im_person_avatar_sample.png',
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Yo'ldoshov Rustam",
                          style: Typographies.titleMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Full name',
                      descriptionItem: Text(
                        "Yo'ldoshov Rustam",
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Spoken languages',
                      descriptionItem: Text(
                        'Uzbek,English',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Date of birth',
                      descriptionItem: Text(
                        '11.11.2000',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Gender',
                      descriptionItem: Text(
                        'Male',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Contact details',
                      descriptionItem: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone:+99894 691 4977',
                            style: Typographies.bodyMedium,
                          ),
                          Text(
                            'Linkedin: yo’ldosh.linkedin.com',
                            style: Typographies.bodyMedium,
                          ),
                          Text(
                            'Telegram: @yoldoshpro',
                            style: Typographies.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Profile information',
                      descriptionItem: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Categories', style: Typographies.titleSmall),
              SizedBox(height: 8),
              AppContainer(
                child: Row(
                  children: [
                    AppBadge(title: 'Children'),
                    SizedBox(width: 8),
                    AppBadge(title: 'Sweets'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Services', style: Typographies.titleSmall),
              SizedBox(height: 8),
              AppContainer(
                child: Row(
                  children: [
                    AppBadge(title: 'Youtube videos'),
                    SizedBox(width: 8),
                    AppBadge(title: 'Advertising'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Audience and followers', style: Typographies.titleSmall),
              SizedBox(height: 8),
              AppContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleDescriptionWidget(
                      title: 'Geography',
                      descriptionItem: Text(
                        'Uzbekistan',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Men',
                      descriptionItem: Text(
                        'Age 18-38',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Female',
                      descriptionItem: Text(
                        'Age 18-38',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Social media accounts',
                      descriptionItem: Text(
                        '345 000 followers 5% engagement rate',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Gender',
                      descriptionItem: Text(
                        'Male',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Experience', style: Typographies.titleSmall),
              SizedBox(height: 8),
              AppContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleDescriptionWidget(
                      title: 'Years of experience',
                      descriptionItem: Text(
                        '12',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Partners',
                      descriptionItem: Text(
                        'LG,SAMSUNG',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Awards',
                      descriptionItem: Text(
                        'Best Influencer 2024',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Pricing / Tariffs', style: Typographies.titleSmall),
              SizedBox(height: 8),
              AppContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleDescriptionWidget(
                      title: 'Currency',
                      descriptionItem: Text(
                        'USD',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Write hourly rate',
                      descriptionItem: Text(
                        'Min 100 USD',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Projectly payment starting price',
                      descriptionItem: Text(
                        '1000 USD',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Payment type',
                      descriptionItem: Text(
                        'Cash',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Delete account',
                    style: Typographies.titleMedium.copyWith(
                      color: AppColors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 56),
            ],
          ),
        ),
      ),
    );
  }
}
