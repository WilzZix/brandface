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
        title: Text('Offer details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    TitleDescriptionWidget(
                      title: 'Offert title',
                      descriptionItem: Text(
                        'I need an influencer for my social media activities',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Offert title',
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
                      title: 'Description',
                      descriptionItem: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 16),
                    TitleDescriptionWidget(
                      title: 'Status',
                      descriptionItem: Text(
                        'Active',
                        style: Typographies.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Requirements', style: Typographies.titleSmall),
              SizedBox(height: 8),
              AppContainer(
                child: Column(
                  children: [
                    RowTitleDescription(
                      title: 'Country',
                      description: 'Uzbekistan',
                    ),
                    RowTitleDescription(title: 'City', description: 'Tashkent'),
                    RowTitleDescription(
                      title: 'Followers max',
                      description: '12 000',
                    ),
                    RowTitleDescription(
                      title: 'Followers min',
                      description: '5 000',
                    ),
                    RowTitleDescription(
                      title: 'Languages',
                      description: 'Uzbek,Rus,English',
                    ),
                    RowTitleDescription(
                      title: 'Engagement rate',
                      description: '5',
                    ),
                    RowTitleDescription(
                      title: 'Content type',
                      description: 'Reels',
                    ),
                    RowTitleDescription(
                      title: 'Gander',
                      description: 'Male',
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Collaboration Details', style: Typographies.titleSmall),
              SizedBox(height: 8),
              AppContainer(
                child: Column(
                  children: [
                    RowTitleDescription(
                      title: 'Duration',
                      description: '1 month',
                    ),
                    RowTitleDescription(
                      title: 'Deadline',
                      description: '12.12.2026',
                    ),
                    RowTitleDescription(
                      title: 'Visibility',
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
                      'Cancel',
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
                  title: 'Submit',
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
