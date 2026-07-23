import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/brand_analytics_entity.dart';
import 'package:brandface/presentation/home_page/brand/ui/widgets/brand_home_primitives.dart';
import 'package:flutter/material.dart';

/// Section 1 of the brand home page: six headline counters in a 2×3 grid.
class BrandActivitySummary extends StatelessWidget {
  const BrandActivitySummary({
    super.key,
    required this.data,
    this.onOffersTap,
    this.onApplicationsTap,
  });

  final BrandAnalyticsEntity data;
  final VoidCallback? onOffersTap;
  final VoidCallback? onApplicationsTap;

  @override
  Widget build(BuildContext context) {
    final allApplications =
        data.totalAmbassadorApplications + data.totalInfluencerApplications;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandSectionTitle(t.analytics.brand_activity_summary),
        const SizedBox(height: 16),
        BrandStatGrid(
          tiles: [
            BrandStatTile(
              value: data.totalSearchesDone.toString(),
              label: t.analytics.total_searches,
            ),
            BrandStatTile(
              value: data.totalOffersCreated.toString(),
              label: t.analytics.total_offers,
              onTap: onOffersTap,
            ),
            BrandStatTile(
              value: data.activeOffers.toString(),
              label: t.common.active_offers,
              onTap: onOffersTap,
            ),
            BrandStatTile(
              value: data.applicants.toString(),
              label: t.brand.new_applications,
              onTap: onApplicationsTap,
            ),
            BrandStatTile(
              value: data.invitationsSent.toString(),
              label: t.analytics.invitations_sent,
            ),
            BrandStatTile(
              value: allApplications.toString(),
              label: t.analytics.all_applications,
              onTap: onApplicationsTap,
            ),
          ],
        ),
      ],
    );
  }
}
