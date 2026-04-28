import 'dart:math' as math;

import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/domain/entities/brand_analytics_entity.dart';
import 'package:brandface/domain/entities/ai_matching/ai_match_result_entity.dart';
import 'package:brandface/presentation/home_page/brand/bloc/brand_analytics/brand_analytics_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/brand_analytics/brand_analytics_state.dart';
import 'package:brandface/presentation/home_page/brand/ui/ambassador_details_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/shared/influencer_card_widgets.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BrandAnalyticsPage extends StatelessWidget {
  const BrandAnalyticsPage({super.key});

  static const String tag = '/brand-analytics';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        backgroundColor: AppColors.lightBg,
        scrolledUnderElevation: 0,
        title: Text('Analytics', style: Typographies.titleMedium),
        centerTitle: false,
      ),
      body: BlocBuilder<BrandAnalyticsCubit, BrandAnalyticsState>(
        builder: (context, state) {
          if (state is BrandAnalyticsLoading || state is BrandAnalyticsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BrandAnalyticsFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message, style: Typographies.bodyMedium),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<BrandAnalyticsCubit>().load(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is BrandAnalyticsLoaded) {
            return _AnalyticsContent(data: state.data);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Content
// ─────────────────────────────────────────────────────────────────────────────

class _AnalyticsContent extends StatelessWidget {
  const _AnalyticsContent({required this.data});
  final BrandAnalyticsEntity data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        // ── 1. Activity Summary ──────────────────────────────────────
        _SectionHeader(title: 'Brand Activity Summary'),
        const SizedBox(height: 12),
        _ActivitySummaryGrid(data: data),
        const SizedBox(height: 24),

        // ── 2. Search Insights ───────────────────────────────────────
        _SectionHeader(title: 'Search Insights'),
        const SizedBox(height: 12),
        _SearchInsightsCard(data: data),
        const SizedBox(height: 24),

        // ── 3. Most Viewed Ambassadors ───────────────────────────────
        if (data.mostViewedAmbassadors.isNotEmpty) ...[
          _SectionHeader(title: 'Most Searched Ambassadors'),
          const SizedBox(height: 12),
          _AmbassadorHorizontalList(
            items: data.mostViewedAmbassadors,
            onTap: (id) => context.pushNamed(
              AmbassadorDetailsPage.tag,
              extra: id,
            ),
          ),
          const SizedBox(height: 24),
        ],

        // ── 4. Offer Performance ─────────────────────────────────────
        _SectionHeader(title: 'Offer Performance'),
        const SizedBox(height: 12),
        _OfferPerformanceCard(data: data),
        const SizedBox(height: 24),

        // ── 5. AI Matching Insights ──────────────────────────────────
        _SectionHeader(title: 'AI Matching Insights'),
        const SizedBox(height: 12),
        _AiInsightsCard(data: data),
        const SizedBox(height: 16),

        // ── 6. Top Recommended Ambassadors ──────────────────────────
        if (data.topRecommendedAmbassadors.isNotEmpty) ...[
          _SectionHeader(title: 'Top Recommended Ambassadors'),
          const SizedBox(height: 12),
          ...data.topRecommendedAmbassadors.take(4).map(
                (a) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _RecommendedAmbassadorCard(
                    item: a,
                    onTap: () => context.pushNamed(
                      AmbassadorDetailsPage.tag,
                      extra: a.influencerId,
                    ),
                  ),
                ),
              ),
          const SizedBox(height: 24),
        ],

        // ── 7. Audience Insights ─────────────────────────────────────
        _SectionHeader(title: 'Audience Insights'),
        const SizedBox(height: 12),
        _AudienceInsightsCard(data: data),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section header
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: Typographies.titleSmall,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. Activity Summary 2×3 grid
// ─────────────────────────────────────────────────────────────────────────────

class _ActivitySummaryGrid extends StatelessWidget {
  const _ActivitySummaryGrid({required this.data});
  final BrandAnalyticsEntity data;

  @override
  Widget build(BuildContext context) {
    final items = [
      _StatItem('Total Searches', data.totalSearchesDone.toString()),
      _StatItem('Total Offers', data.totalOffersCreated.toString()),
      _StatItem('Active Offers', data.activeOffers.toString()),
      _StatItem('Invitations Sent', data.invitationsSent.toString()),
      _StatItem('Ambassador Apps', data.totalAmbassadorApplications.toString()),
      _StatItem('Influencer Apps', data.totalInfluencerApplications.toString()),
    ];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.4,
      children: items.map((e) => _StatCard(item: e)).toList(),
    );
  }
}

class _StatItem {
  final String label;
  final String value;
  const _StatItem(this.label, this.value);
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.item});
  final _StatItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.value,
            style: Typographies.titleMedium,
          ),
          const SizedBox(height: 2),
          Text(
            item.label,
            style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. Search Insights
// ─────────────────────────────────────────────────────────────────────────────

class _SearchInsightsCard extends StatelessWidget {
  const _SearchInsightsCard({required this.data});
  final BrandAnalyticsEntity data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.search_rounded, size: 18, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                '${data.totalSearchesPerformed} searches performed',
                style: Typographies.bodyMedium,
              ),
            ],
          ),
          if (data.topSearchFilters.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              'Top filters used',
              style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: data.topSearchFilters
                  .map((f) => InfluencerChip(label: f))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Ambassador horizontal scroll list
// ─────────────────────────────────────────────────────────────────────────────

class _AmbassadorHorizontalList extends StatelessWidget {
  const _AmbassadorHorizontalList({
    required this.items,
    required this.onTap,
  });
  final List<AiMatchResultEntity> items;
  final void Function(int id) onTap;

  String _resolveUrl(String raw) {
    if (raw.isEmpty) return '';
    if (raw.startsWith('http')) return raw;
    return '${ApiRoutes.mediaBaseUrl}$raw';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (ctx, i) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final a = items[index];
          return GestureDetector(
            onTap: () => onTap(a.influencerId),
            child: Container(
              width: 88,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.lightBg3,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  InfluencerAvatar(
                    url: _resolveUrl(a.avatarUrl),
                    isTop: a.isTop,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    a.displayName,
                    style: Typographies.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Offer Performance
// ─────────────────────────────────────────────────────────────────────────────

class _OfferPerformanceCard extends StatelessWidget {
  const _OfferPerformanceCard({required this.data});
  final BrandAnalyticsEntity data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Bar chart
        if (data.performanceChart.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.lightBg3,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Last 7 Days', style: Typographies.bodyMedium),
                const SizedBox(height: 12),
                _BarChart(stats: data.performanceChart),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _LegendDot(color: AppColors.primary, label: 'Views'),
                    const SizedBox(width: 16),
                    _LegendDot(color: AppColors.orange, label: 'Applications'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],

        // Top niches & regions
        Row(
          children: [
            Expanded(
              child: _LabelCountList(
                title: 'Top Niches',
                items: data.topNiches,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _LabelCountList(
                title: 'Top Regions',
                items: data.topRegions,
                color: AppColors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Stats grid
        _OfferStatsGrid(data: data),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(label, style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
        ],
      );
}

class _BarChart extends StatelessWidget {
  const _BarChart({required this.stats});
  final List<OfferDayStat> stats;

  @override
  Widget build(BuildContext context) {
    final maxVal = stats.fold<int>(
      1,
      (m, s) => math.max(m, math.max(s.views, s.applications)),
    );
    const barH = 80.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: stats.map((s) {
        return Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Views bar
                  _SingleBar(
                    height: barH * s.views / maxVal,
                    color: AppColors.primary,
                    width: 7,
                  ),
                  const SizedBox(width: 2),
                  // Applications bar
                  _SingleBar(
                    height: barH * s.applications / maxVal,
                    color: AppColors.orange,
                    width: 7,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                s.day.length > 3 ? s.day.substring(0, 3) : s.day,
                style: Typographies.labelSmall.copyWith(
                  color: AppColors.mutedBlack,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _SingleBar extends StatelessWidget {
  const _SingleBar({
    required this.height,
    required this.color,
    required this.width,
  });
  final double height;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: width,
      height: math.max(4, height),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _LabelCountList extends StatelessWidget {
  const _LabelCountList({
    required this.title,
    required this.items,
    required this.color,
  });
  final String title;
  final List<LabelCountStat> items;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Typographies.bodyMedium),
          const SizedBox(height: 8),
          if (items.isEmpty)
            Text('—', style: Typographies.bodySmall.copyWith(color: AppColors.grey))
          else
            ...items.take(5).map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            e.label,
                            style: Typographies.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            e.count.toString(),
                            style: Typographies.bodySmall
                                .copyWith(color: color, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _OfferStatsGrid extends StatelessWidget {
  const _OfferStatsGrid({required this.data});
  final BrandAnalyticsEntity data;

  @override
  Widget build(BuildContext context) {
    final items = [
      _StatItem('Viewed Offer', data.viewedOffer.toString()),
      _StatItem('Opened Details', data.openedDetails.toString()),
      _StatItem('Applicants', data.applicants.toString()),
      _StatItem('Approved', data.approved.toString()),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.2,
      children: items.map((e) => _StatCard(item: e)).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. AI Insights
// ─────────────────────────────────────────────────────────────────────────────

class _AiInsightsCard extends StatelessWidget {
  const _AiInsightsCard({required this.data});
  final BrandAnalyticsEntity data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Score circle
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 3),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${data.aiMatchScore}',
                      style: Typographies.titleMedium,
                    ),
                    Text(
                      '/100',
                      style: Typographies.bodySmall
                          .copyWith(color: AppColors.mutedBlack, fontSize: 9),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data.nicheFit.isNotEmpty)
                      _FitChip(label: 'Niche Fit', value: data.nicheFit),
                    const SizedBox(height: 4),
                    if (data.audienceFit.isNotEmpty)
                      _FitChip(label: 'Audience Fit', value: data.audienceFit),
                    const SizedBox(height: 4),
                    if (data.platformFit.isNotEmpty)
                      _FitChip(label: 'Platform Fit', value: data.platformFit),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FitChip extends StatelessWidget {
  const _FitChip({required this.label, required this.value});
  final String label;
  final String value;

  Color _colorForValue(String v) {
    final lower = v.toLowerCase();
    if (lower.contains('high')) return AppColors.primary;
    if (lower.contains('medium') || lower.contains('mid')) return AppColors.orange;
    return AppColors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorForValue(value);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          '$value $label',
          style: Typographies.bodySmall,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 6. Recommended Ambassador card
// ─────────────────────────────────────────────────────────────────────────────

class _RecommendedAmbassadorCard extends StatelessWidget {
  const _RecommendedAmbassadorCard({
    required this.item,
    required this.onTap,
  });
  final AiMatchResultEntity item;
  final VoidCallback onTap;

  String _resolveUrl(String raw) {
    if (raw.isEmpty) return '';
    if (raw.startsWith('http')) return raw;
    return '${ApiRoutes.mediaBaseUrl}$raw';
  }

  String _formatFollowers(String raw) {
    final n = int.tryParse(raw) ?? 0;
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return raw;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.lightBg3,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            InfluencerAvatar(
              url: _resolveUrl(item.avatarUrl),
              isTop: item.isTop,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.displayName,
                          style: Typographies.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (item.isVerified) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.check_circle,
                          color: AppColors.primaryDark,
                          size: 16,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${_formatFollowers(item.totalFollowers)} followers  •  ${item.region}',
                    style: Typographies.bodySmall
                        .copyWith(color: AppColors.mutedBlack),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // AI score badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${item.score.toStringAsFixed(0)}%',
                style: Typographies.labelSmall
                    .copyWith(color: AppColors.primaryDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 7. Audience Insights
// ─────────────────────────────────────────────────────────────────────────────

class _AudienceInsightsCard extends StatelessWidget {
  const _AudienceInsightsCard({required this.data});
  final BrandAnalyticsEntity data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gender row
          Row(
            children: [
              Expanded(
                child: _GenderBar(
                  femalePercent: data.femalePercent,
                  malePercent: data.malePercent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Age group
          if (data.topAgeGroup.isNotEmpty) ...[
            Row(
              children: [
                Icon(Icons.people_alt_rounded, size: 16, color: AppColors.mutedBlack),
                const SizedBox(width: 6),
                Text(
                  'Top age group: ',
                  style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack),
                ),
                Text(data.topAgeGroup, style: Typographies.bodySmall),
              ],
            ),
            const SizedBox(height: 10),
          ],

          // Top countries
          if (data.topCountries.isNotEmpty) ...[
            Text('Top Countries', style: Typographies.bodyMedium),
            const SizedBox(height: 8),
            ...data.topCountries.take(5).map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: _CountryBar(stat: c, total: data.topCountries.fold(0, (s, e) => s + e.count)),
                  ),
                ),
          ],
        ],
      ),
    );
  }
}

class _GenderBar extends StatelessWidget {
  const _GenderBar({
    required this.femalePercent,
    required this.malePercent,
  });
  final double femalePercent;
  final double malePercent;

  @override
  Widget build(BuildContext context) {
    final total = femalePercent + malePercent;
    final fRatio = total > 0 ? femalePercent / total : 0.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender Distribution', style: Typographies.bodyMedium),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Row(
            children: [
              Flexible(
                flex: (fRatio * 100).round(),
                child: Container(height: 12, color: AppColors.primary),
              ),
              Flexible(
                flex: ((1 - fRatio) * 100).round(),
                child: Container(height: 12, color: AppColors.orange),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _LegendDot(
              color: AppColors.primary,
              label: 'Female ${femalePercent.toStringAsFixed(0)}%',
            ),
            _LegendDot(
              color: AppColors.orange,
              label: 'Male ${malePercent.toStringAsFixed(0)}%',
            ),
          ],
        ),
      ],
    );
  }
}

class _CountryBar extends StatelessWidget {
  const _CountryBar({required this.stat, required this.total});
  final LabelCountStat stat;
  final int total;

  @override
  Widget build(BuildContext context) {
    final ratio = total > 0 ? stat.count / total : 0.0;
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            stat.label,
            style: Typographies.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 8,
              backgroundColor: AppColors.borderColor,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${(ratio * 100).toStringAsFixed(0)}%',
          style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack),
        ),
      ],
    );
  }
}
