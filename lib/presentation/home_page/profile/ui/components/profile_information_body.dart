import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/profile/catalog/social_media_account_stats_entity.dart';
import 'package:brandface/domain/usecase/profile/get_social_media_account_stats_use_case.dart';
import 'package:brandface/domain/usecase/profile/params/social_medi_params.dart';
import 'package:brandface/domain/usecase/registration/params/fill_influencer_profile_param.dart';
import 'package:brandface/presentation/home_page/profile/ui/components/partners.dart';
import 'package:brandface/presentation/home_page/profile/ui/components/services_item.dart';
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
                  _AvatarWidget(avatarUrl: data.avatarUrl),
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
                  t.profile.age_range(from: data.audience?.menAgeFrom ?? '', to: data.audience?.menAgeTo ?? ''),
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.female,
                descriptionItem: Text(
                  t.profile.age_range(from: data.audience?.womenAgeFrom ?? '', to: data.audience?.womenAgeTo ?? ''),
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
                title: 'Jami followers',
                descriptionItem: Text(
                  _formatFollowers(data.audience?.totalFollowers),
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: 'Engagement rate',
                descriptionItem: Text(
                  data.audience?.engagementRate != null
                      ? '${data.audience!.engagementRate}%'
                      : '',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.social_media_accounts,
                descriptionItem: _SocialMediaStatsSection(
                  accounts: data.audience?.socialMediaAccounts,
                  fallbackUsernames: data.audience?.socialMediaStats,
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
                  'Min ${data.pricing?.hourlyRateMinUsd} ${data.pricing?.campaignFeeCurrency ?? ''}\nMax ${data.pricing?.hourlyRateMaxUsd} ${data.pricing?.campaignFeeCurrency ?? ''}',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.registration.projectly_payment_starting_price,
                descriptionItem: Text(
                  '${data.pricing?.campaignFee} ${data.pricing?.campaignFeeCurrency ?? ''}',
                  style: Typographies.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
              TitleDescriptionWidget(
                title: t.profile.payment_type,
                descriptionItem: Text(
                  data.pricing?.paymentTypes?.join(', ') ?? '',
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

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget({this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          '${ApiRoutes.mediaBaseUrl}$avatarUrl',
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder(),
        ),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() => ClipOval(
        child: Image.asset(
          'assets/images/im_person_avatar_sample.png',
          width: 56,
          height: 56,
          fit: BoxFit.cover,
        ),
      );
}

String _formatFollowers(int? count) {
  if (count == null) return '';
  if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
  if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
  return count.toString();
}

class _SocialMediaStatsSection extends StatefulWidget {
  const _SocialMediaStatsSection({this.accounts, this.fallbackUsernames});

  final List<SocialMediaAccount>? accounts;
  final List<String>? fallbackUsernames;

  @override
  State<_SocialMediaStatsSection> createState() =>
      _SocialMediaStatsSectionState();
}

class _SocialMediaStatsSectionState extends State<_SocialMediaStatsSection> {
  final Map<String, SocialMediaAccountStatsEntity?> _statsMap = {};

  @override
  void initState() {
    super.initState();
    _fetchAll();
  }

  Future<void> _fetchAll() async {
    final accounts = widget.accounts;
    if (accounts == null || accounts.isEmpty) return;

    final useCase = sl<GetSocialMediaAccountStatsUseCase>();
    for (final account in accounts) {
      final key = '${account.platform}:${account.username}';
      if (mounted) setState(() => _statsMap[key] = null);

      final result = await useCase.call(
        params: SocialMediaParams(
          platform: account.platform,
          username: account.username,
        ),
      );

      if (!mounted) return;
      result.fold(
        ifLeft: (_) => setState(() => _statsMap.remove(key)),
        ifRight: (stats) => setState(() => _statsMap[key] = stats),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final accounts = widget.accounts;

    if (accounts != null && accounts.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: accounts.map((account) {
          final key = '${account.platform}:${account.username}';
          final isLoading = _statsMap.containsKey(key) && _statsMap[key] == null;
          final stats = _statsMap[key];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${account.platform} ${account.username}',
                  style: Typographies.labelLarge,
                ),
                const SizedBox(height: 4),
                if (isLoading)
                  const SizedBox(
                    height: 2,
                    child: LinearProgressIndicator(),
                  )
                else if (stats != null)
                  Text(
                    '${_formatFollowers(stats.followers)} followers, ${stats.engagementRate}% engagement rate',
                    style: Typographies.bodySmall,
                  ),
              ],
            ),
          );
        }).toList(),
      );
    }

    // Fallback: faqat username stringlar bo'lsa
    final usernames = widget.fallbackUsernames;
    if (usernames == null || usernames.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: usernames
          .map(
            (u) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(u, style: Typographies.bodyMedium),
            ),
          )
          .toList(),
    );
  }
}
