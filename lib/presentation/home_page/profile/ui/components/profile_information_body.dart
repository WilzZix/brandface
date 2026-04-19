import 'package:flutter/cupertino.dart';

import '../../../../../domain/entities/profile/influencer_profile_information_entity.dart';
import '../../../../../uikit/components/ui_components/app_container.dart';
import '../../../../../uikit/components/ui_components/badge.dart';
import '../../../../../uikit/components/ui_components/title_description_widget.dart';
import '../../../../../uikit/tokens/colors.dart';
import '../../../../../uikit/typography/typography.dart';

class ProfileInformationBody extends StatelessWidget {
  const ProfileInformationBody({super.key, required this.data});

  final InfluencerProfileInformationEntity data;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Image.asset('assets/images/im_person_avatar_sample.png'),
                  SizedBox(width: 16),
                  Text(
                    data.displayName.toString(),
                    style: Typographies.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: 'Full name',
                descriptionItem: Text(
                  data.displayName.toString(),
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),

              ///TODO language id ga qarab nameni olish
              TitleDescriptionWidget(
                title: 'Spoken languages',
                descriptionItem: Text(
                  data.languageIds.toString(),
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: 'Date of birth',
                descriptionItem: Text(
                  data.birthDate.toString(),
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: 'Gender',
                descriptionItem: Text(
                  data.gender.toString(),
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),

              ///TODO
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
                  data.bio ?? '',
                  style: Typographies.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        ///TODO
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
              //TODO region id ga qarab city ni olish
              TitleDescriptionWidget(
                title: 'Geography',
                descriptionItem: Text(
                  data.regionId.toString(),
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: 'Men',
                descriptionItem: Text(
                  'Age ${data.audience?.menAgeFrom} - ${data.audience?.menAgeTo}',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: 'Female',
                descriptionItem: Text(
                  'Age ${data.audience?.womenAgeFrom} - ${data.audience?.womenAgeTo}',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: 'Social media accounts',
                descriptionItem: Text(
                  '${data.audience?.socialMediaStats.toString()}',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: 'Gender',
                descriptionItem: Text(
                  data.gender ?? '',
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
                  data.yearsOfExperience.toString(),
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: 'Partners',
                descriptionItem: Text(
                  data.partners.toString(),
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: 'Awards',
                descriptionItem: Text(
                  data.awards.toString(),
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
                  data.pricing?.campaignFeeCurrency ?? '',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: 'Write hourly rate',
                descriptionItem: Text(
                  'Min ${data.pricing?.hourlyRateMinUsd}\nMax ${data.pricing?.hourlyRateMinUsd}',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: 'Projectly payment starting price',
                descriptionItem: Text(
                  '${data.pricing?.campaignFee}',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: 'Payment type',
                descriptionItem: Text(
                  '${data.pricing?.paymentTypes.toString()}',
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
              style: Typographies.titleMedium.copyWith(color: AppColors.red),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom + 56),
      ],
    );
  }
}
