import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/brand_analytics_entity.dart';
import 'package:brandface/presentation/home_page/brand/ui/widgets/brand_home_primitives.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

/// Section 5: gender split, dominant age group and country mix.
class AudienceInsightsSection extends StatelessWidget {
  const AudienceInsightsSection({super.key, required this.data});

  final BrandAnalyticsEntity data;

  String _percent(double value) => '${value.toStringAsFixed(0)}%';

  /// "Uzbekistan 63%, Kazakhstan 29%, Others 8%" — counts are turned into
  /// shares of the whole so the line reads the way the design shows it.
  String _countriesLine() {
    final countries = data.topCountries;
    if (countries.isEmpty) return '';
    final total = countries.fold<int>(0, (sum, c) => sum + c.count);
    if (total <= 0) return countries.map((c) => c.label).join(', ');
    return countries
        .take(3)
        .map((c) => '${c.label} ${(c.count * 100 / total).round()}%')
        .join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final countries = _countriesLine();
    final hasGender = data.femalePercent > 0 || data.malePercent > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandSectionTitle(t.analytics.audience_insights),
        const SizedBox(height: 16),
        if (hasGender) ...[
          BrandStatGrid(
            tiles: [
              BrandStatTile(
                value: _percent(data.femalePercent),
                label: t.analytics.female,
              ),
              BrandStatTile(
                value: _percent(data.malePercent),
                label: t.analytics.male,
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        if (data.topAgeGroup.isNotEmpty) ...[
          BrandStatTile(
            value: data.topAgeGroup,
            label: t.analytics.top_age_group_label,
            valueStyle: Typographies.titleMedium,
          ),
          const SizedBox(height: 8),
        ],
        if (countries.isNotEmpty)
          BrandStatTile(
            value: countries,
            label: t.analytics.top_countries,
            valueStyle: Typographies.titleMedium,
            valueMaxLines: 2,
          ),
      ],
    );
  }
}
