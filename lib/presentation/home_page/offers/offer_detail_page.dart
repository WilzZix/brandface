import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import '../../../../uikit/components/buttons/buttons.dart';
import '../../../../uikit/components/ui_components/app_container.dart';
import '../../../../uikit/components/ui_components/badge.dart';
import '../../../../uikit/components/ui_components/row_title_description.dart';
import '../../../../uikit/components/ui_components/title_description_widget.dart';

class OfferDetailPage extends StatefulWidget {
  const OfferDetailPage({super.key});

  static const String tag = '/offers-detail-page';

  @override
  State<OfferDetailPage> createState() => _OfferDetailPageState();
}

class _OfferDetailPageState extends State<OfferDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text(t.offer.offer_details),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.profile.general_info, style: Typographies.titleSmall),
              SizedBox(height: 8),
              AppContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleDescriptionWidget(
                      title: t.offer.offer_title,
                      descriptionItem: Text(
                        'I need an influencer for my social media activities',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: t.offer.offer_title,
                      descriptionItem: Row(
                        children: [
                          AppBadge(title: 'Children'),
                          SizedBox(width: 8),
                          AppBadge(title: 'Sweets'),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: t.offer.description,
                      descriptionItem: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: t.offer.status,
                      descriptionItem: Text(
                        'Active',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(t.offer.requirements, style: Typographies.titleSmall),
              SizedBox(height: 8),
              AppContainer(
                child: Column(
                  children: [
                    RowTitleDescription(
                      title: t.offer.country,
                      description: 'Uzbekistan',
                    ),
                    RowTitleDescription(title: t.offer.city, description: 'Tashkent'),
                    RowTitleDescription(
                      title: t.offer.followers_max,
                      description: '12 000',
                    ),
                    RowTitleDescription(
                      title: t.offer.followers_min,
                      description: '5 000',
                    ),
                    RowTitleDescription(
                      title: t.offer.languages,
                      description: 'Uzbek,Rus,English',
                    ),
                    RowTitleDescription(
                      title: t.offer.engagement_rate,
                      description: '5',
                    ),
                    RowTitleDescription(
                      title: t.offer.content_type,
                      description: 'Reels',
                    ),
                    RowTitleDescription(
                      title: t.offer.gender,
                      description: t.registration.male,
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(t.offer.collaboration_details, style: Typographies.titleSmall),
              SizedBox(height: 8),
              AppContainer(
                child: Column(
                  children: [
                    RowTitleDescription(
                      title: t.offer.duration,
                      description: '1 month',
                    ),
                    RowTitleDescription(
                      title: t.common.deadline,
                      description: '12.12.2026',
                    ),
                    RowTitleDescription(
                      title: t.offer.visibility,
                      description: 'Public',
                      showDivider: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            top: BorderSide(color: AppColors.lightBg2, width: 0.5),
          ),
        ),
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: SizedBox(
          height: 56,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () => Navigator.pop(context),
                  child: Center(
                    child: Text(
                      t.common.cancel,
                      style: Typographies.labelLarge.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButtons.primary(
                  title: t.common.submit,
                  onTap: () {
                    // Submit mantiqi
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
