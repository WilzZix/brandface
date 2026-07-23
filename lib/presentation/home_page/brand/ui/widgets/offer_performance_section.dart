import 'dart:math' as math;

import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/brand_analytics_entity.dart';
import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';
import 'package:brandface/presentation/home_page/brand/bloc/brand_analytics/brand_analytics_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/brand_analytics/brand_analytics_state.dart';
import 'package:brandface/presentation/home_page/brand/ui/widgets/brand_home_primitives.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/extansions/snackbar_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Section 2: offer picker, period picker, PDF export, applications chart and
/// the funnel counters underneath it.
class OfferPerformanceSection extends StatelessWidget {
  const OfferPerformanceSection({super.key, required this.state});

  final BrandAnalyticsLoaded state;

  BrandAnalyticsEntity get _data => state.data;

  String _periodLabel(AnalyticsPeriod period) => switch (period) {
        AnalyticsPeriod.last7Days => t.analytics.last_7_days,
        AnalyticsPeriod.last30Days => t.analytics.days_30,
        AnalyticsPeriod.allTime => t.analytics.all_time,
      };

  String _selectedOfferLabel() {
    final id = state.selectedOfferId;
    if (id == null) return t.analytics.choose;
    final match = state.offers.where((o) => o.id == id);
    return match.isEmpty ? t.analytics.choose : match.first.title;
  }

  Future<void> _pickOffer(BuildContext context) async {
    if (state.offers.isEmpty) return;
    final cubit = context.read<BrandAnalyticsCubit>();
    final selected = await showModalBottomSheet<_OfferChoice>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _OfferPickerSheet(
        offers: state.offers,
        selectedId: state.selectedOfferId,
      ),
    );
    if (selected == null) return;
    await cubit.selectOffer(selected.id);
  }

  Future<void> _pickPeriod(BuildContext context) async {
    final cubit = context.read<BrandAnalyticsCubit>();
    final selected = await showModalBottomSheet<AnalyticsPeriod>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _PeriodPickerSheet(
        current: state.period,
        labelFor: _periodLabel,
      ),
    );
    if (selected == null) return;
    await cubit.selectPeriod(selected);
  }

  /// "Fashion (15), Lifestyle (8), Beauty (4)" — the design renders the top
  /// three inline rather than as a list.
  String _inlineTop(List<LabelCountStat> items) => items
      .take(3)
      .map((e) => '${e.label} (${e.count})')
      .join(', ');

  @override
  Widget build(BuildContext context) {
    final chart = _data.performanceChart;
    final totalApplications =
        chart.fold<int>(0, (sum, s) => sum + s.applications);
    final niches = _inlineTop(_data.topNiches);
    final regions = _inlineTop(_data.topRegions);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandSectionTitle(t.analytics.offer_performance),
        const SizedBox(height: 16),
        Text(t.analytics.choose_an_offer, style: Typographies.bodyMedium),
        const SizedBox(height: 8),
        _OfferDropdown(
          label: _selectedOfferLabel(),
          isPlaceholder: state.selectedOfferId == null,
          enabled: state.offers.isNotEmpty,
          onTap: () => _pickOffer(context),
        ),
        const SizedBox(height: 16),
        // A Wrap rather than a Row: each pill keeps its natural width and the
        // pair drops to a second line when a longer translation stops them
        // fitting side by side.
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            BrandPillButton(
              label: _periodLabel(state.period),
              leading: SvgPicture.asset(AppAssets.icCalendar, height: 16),
              trailing: SvgPicture.asset(AppAssets.icArrowDown, height: 16),
              onTap: () => _pickPeriod(context),
            ),
            BrandPillButton(
              label: t.analytics.download_as_pdf,
              // No export endpoint exists yet; the control is in place so the
              // layout is final when one arrives.
              onTap: () => context.showAppSnackBar(t.analytics.pdf_coming_soon),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Divider(color: AppColors.borderColor, height: 1),
        const SizedBox(height: 24),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: state.isRefreshing ? 0.4 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                totalApplications.toString(),
                style: Typographies.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                t.analytics.total_applications_received,
                style: Typographies.bodyMedium.copyWith(
                  color: AppColors.mutedBlack,
                ),
              ),
              if (chart.isNotEmpty) ...[
                const SizedBox(height: 24),
                _ApplicationsBarChart(stats: chart),
              ],
              if (niches.isNotEmpty) ...[
                const SizedBox(height: 24),
                _InlineTopStat(
                  value: niches,
                  label: t.analytics.top_3_applicant_niches,
                ),
              ],
              if (regions.isNotEmpty) ...[
                const SizedBox(height: 16),
                _InlineTopStat(
                  value: regions,
                  label: t.analytics.top_3_applicant_regions,
                ),
              ],
              const SizedBox(height: 24),
              BrandStatGrid(
                tiles: [
                  BrandStatTile(
                    value: _data.viewedOffer.toString(),
                    label: t.analytics.viewed_offer,
                  ),
                  BrandStatTile(
                    value: _data.openedDetails.toString(),
                    label: t.analytics.opened_details,
                  ),
                  BrandStatTile(
                    value: _data.applicants.toString(),
                    label: t.analytics.applicants,
                  ),
                  BrandStatTile(
                    value: _data.approved.toString(),
                    label: t.analytics.approved,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OfferChoice {
  const _OfferChoice(this.id);

  /// `null` selects "all offers".
  final int? id;
}

class _OfferDropdown extends StatelessWidget {
  const _OfferDropdown({
    required this.label,
    required this.isPlaceholder,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool isPlaceholder;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: Typographies.bodyLarge.copyWith(
                  color: isPlaceholder || !enabled
                      ? AppColors.grey
                      : TextColor.textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SvgPicture.asset(AppAssets.icArrowDown, height: 20),
          ],
        ),
      ),
    );
  }
}

/// "Fashion (15), Lifestyle (8), Beauty (4)" over its caption.
class _InlineTopStat extends StatelessWidget {
  const _InlineTopStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: Typographies.titleMedium),
        const SizedBox(height: 4),
        Text(
          label,
          style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
        ),
      ],
    );
  }
}

/// Applications per day, value labelled above each bar.
class _ApplicationsBarChart extends StatelessWidget {
  const _ApplicationsBarChart({required this.stats});

  final List<OfferDayStat> stats;

  static const double _maxBarHeight = 100;

  @override
  Widget build(BuildContext context) {
    final maxValue = stats.fold<int>(
      1,
      (m, s) => math.max(m, s.applications),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: stats.map((s) {
        final height = _maxBarHeight * s.applications / maxValue;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    s.applications.toString(),
                    style: Typographies.bodySmall,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: math.max(4, height),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    s.day.length > 3 ? s.day.substring(0, 3) : s.day,
                    style: Typographies.bodySmall.copyWith(
                      color: AppColors.mutedBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _OfferPickerSheet extends StatelessWidget {
  const _OfferPickerSheet({required this.offers, required this.selectedId});

  final List<OfferSummaryEntity> offers;
  final int? selectedId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SheetHandle(),
            const SizedBox(height: 16),
            Text(t.analytics.choose_an_offer, style: Typographies.titleMedium),
            const SizedBox(height: 8),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _SheetTile(
                      label: t.analytics.all_offers,
                      selected: selectedId == null,
                      onTap: () =>
                          Navigator.of(context).pop(const _OfferChoice(null)),
                    ),
                    ...offers.map(
                      (o) => _SheetTile(
                        label: o.title,
                        selected: o.id == selectedId,
                        onTap: () =>
                            Navigator.of(context).pop(_OfferChoice(o.id)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PeriodPickerSheet extends StatelessWidget {
  const _PeriodPickerSheet({required this.current, required this.labelFor});

  final AnalyticsPeriod current;
  final String Function(AnalyticsPeriod) labelFor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SheetHandle(),
            const SizedBox(height: 16),
            Text(t.analytics.period, style: Typographies.titleMedium),
            const SizedBox(height: 8),
            ...AnalyticsPeriod.values.map(
              (p) => _SheetTile(
                label: labelFor(p),
                selected: p == current,
                onTap: () => Navigator.of(context).pop(p),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.borderColor,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}

class _SheetTile extends StatelessWidget {
  const _SheetTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: Typographies.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (selected)
              Icon(Icons.check, color: AppColors.primaryDark, size: 20),
          ],
        ),
      ),
    );
  }
}
