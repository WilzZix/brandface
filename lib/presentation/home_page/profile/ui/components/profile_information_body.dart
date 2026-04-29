import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/home_page/profile/ui/components/partners.dart';
import 'package:brandface/presentation/home_page/profile/ui/components/services_item.dart';
import 'package:brandface/uikit/components/ui_components/profile_image.dart';
import 'package:brandface/utils/extansions/app_exts.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/entities/profile/influencer_profile_information_entity.dart';
import '../../../../../uikit/components/ui_components/app_container.dart';
import '../../../../../uikit/components/ui_components/title_description_widget.dart';
import '../../../../../uikit/typography/typography.dart';
import 'awards.dart';
import 'categories.dart';
import 'contact_details.dart';
import 'language_item.dart';

class ProfileInformationBody extends StatelessWidget {
  const ProfileInformationBody({super.key, required this.data});

  final InfluencerProfileInformationEntity data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.profile.general_info, style: Typographies.titleSmall),
        SizedBox(height: 8),
        AppContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _ProfileInfoAvatar(avatarUrl: data.avatarUrl),
                  SizedBox(width: 16),
                  Text(
                    data.displayName.toString(),
                    style: Typographies.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.full_name,
                descriptionItem: Text(
                  data.displayName.toString(),
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.spoken_languages,
                descriptionItem: LanguageItem(langIds: data.languageIds),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.date_of_birth,
                descriptionItem: Text(
                  data.birthDate?.toDotFormat() ?? '',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.gender,
                descriptionItem: Text(
                  data.gender?.toCapitalized() ?? '',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.contact_details,
                descriptionItem: ContactDetails(contactData: data.contacts),
              ),
              TitleDescriptionWidget(
                title: t.registration.profile_information,
                descriptionItem: Text(
                  data.bio ?? '',
                  style: Typographies.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(t.registration.categories, style: Typographies.titleSmall),
        SizedBox(height: 8),
        AppContainer(child: Categories(categories: data.categories)),
        SizedBox(height: 16),
        Text(t.registration.services, style: Typographies.titleSmall),
        SizedBox(height: 8),
        AppContainer(child: ServicesItem(services: data.services)),
        SizedBox(height: 16),
        Text(t.profile.audience_and_followers, style: Typographies.titleSmall),
        SizedBox(height: 8),
        AppContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO beckend object qaytarib beradigon qilishi kerak
              TitleDescriptionWidget(
                title: t.registration.geography,
                descriptionItem: Text(
                  data.region?.name ?? '',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.men,
                descriptionItem: Text(
                  t.profile.age_range(
                    from: data.audience?.menAgeFrom ?? '',
                    to: data.audience?.menAgeTo ?? '',
                  ),
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.female,
                descriptionItem: Text(
                  t.profile.age_range(
                    from: data.audience?.womenAgeFrom ?? '',
                    to: data.audience?.womenAgeTo ?? '',
                  ),
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.gender,
                descriptionItem: Text(
                  data.gender?.toCapitalized() ?? '',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.social_media_accounts,
                descriptionItem: Text(
                  '${data.audience?.socialMediaStats.toString()}',
                  style: Typographies.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(t.profile.experience, style: Typographies.titleSmall),
        SizedBox(height: 8),
        AppContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleDescriptionWidget(
                title: t.registration.years_of_experience,
                descriptionItem: Text(
                  data.yearsOfExperience.toString(),
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              //TODO beckend object qaytadigon qilib berishi kerak
              TitleDescriptionWidget(
                title: t.registration.partners,
                descriptionItem: Partners(partners: data.partners),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.profile.awards,
                descriptionItem: Awards(awards: data.awards),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(t.profile.pricing_tariffs, style: Typographies.titleSmall),
        SizedBox(height: 8),
        AppContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleDescriptionWidget(
                title: t.registration.currency,
                descriptionItem: Text(
                  data.pricing?.campaignFeeCurrency ?? '',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.write_hourly_rate,
                descriptionItem: Text(
                  'Min ${data.pricing?.hourlyRateMinUsd}\nMax ${data.pricing?.hourlyRateMinUsd}',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.projectly_payment_starting_price,
                descriptionItem: Text(
                  '${data.pricing?.campaignFee}',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.profile.payment_type,
                descriptionItem: Text(
                  '${data.pricing?.paymentTypes.toString()}',
                  style: Typographies.bodyMedium,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: MediaQuery.of(context).padding.bottom + 56),
      ],
    );
  }
}

class _ProfileInfoAvatar extends ProfileImage {
  const _ProfileInfoAvatar({String? avatarUrl})
    : super(imageUrl: avatarUrl, size: 40);
}
