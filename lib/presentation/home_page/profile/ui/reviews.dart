import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/components/ui_components/title_description_widget.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  static const String tag = '/reviews';

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t.profile.reviews), centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(t.reviews.average, style: Typographies.titleLarge),
            SizedBox(height: 8),
            AppContainer(
              child: Row(
                children: [
                  SvgPicture.asset(AppAssets.icStar),
                  SizedBox(width: 8),
                  Text('4.34', style: Typographies.titleLarge),
                ],
              ),
            ),
            SizedBox(height: 32),
            Text(t.reviews.client_reviews, style: Typographies.titleLarge),
            SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return AppContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.icStar),
                            SizedBox(width: 8),
                            Text('4.34', style: Typographies.titleLarge),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          style: Typographies.bodySmall,
                        ),
                        SizedBox(height: 12),
                        Divider(),
                        SizedBox(height: 12),
                        TitleDescriptionWidget(
                          title: 'John Johnson',
                          descriptionItem: Text(
                            'Director Paypal',
                            style: Typographies.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 8),
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
