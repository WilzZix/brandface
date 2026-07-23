import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/ai_matching/ai_match_result_entity.dart';
import 'package:brandface/domain/entities/brand_analytics_entity.dart';
import 'package:brandface/presentation/home_page/brand/ui/widgets/brand_home_primitives.dart';
import 'package:brandface/uikit/components/avatar/avatar_placeholder.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

/// Section 3: the four AI fit scores.
class AiMatchingInsights extends StatelessWidget {
  const AiMatchingInsights({super.key, required this.data});

  final BrandAnalyticsEntity data;

  /// Blank fits are shown as an em dash rather than dropping the tile — the
  /// design's 2×2 shape should stay intact.
  String _fit(String value) => value.isEmpty ? '—' : value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandSectionTitle(t.analytics.ai_matching_insights),
        const SizedBox(height: 16),
        BrandStatGrid(
          tiles: [
            BrandStatTile(
              value: '${data.aiMatchScore}/100',
              label: t.analytics.ai_match_score,
            ),
            BrandStatTile(
              value: _fit(data.nicheFit),
              label: t.analytics.niche_fit,
            ),
            BrandStatTile(
              value: _fit(data.audienceFit),
              label: t.analytics.audience_fit,
            ),
            BrandStatTile(
              value: _fit(data.platformFit),
              label: t.analytics.platform_fit,
            ),
          ],
        ),
      ],
    );
  }
}

/// Section 4: the four ambassadors the matcher rates highest.
class TopRecommendedAmbassadors extends StatelessWidget {
  const TopRecommendedAmbassadors({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<AiMatchResultEntity> items;
  final void Function(int influencerId) onTap;

  @override
  Widget build(BuildContext context) {
    final visible = items.take(4).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandSectionTitle(t.analytics.top_recommended_ambassadors),
        const SizedBox(height: 16),
        for (var i = 0; i < visible.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          _RecommendedCard(
            item: visible[i],
            onTap: () => onTap(visible[i].influencerId),
          ),
        ],
      ],
    );
  }
}

class _RecommendedCard extends StatelessWidget {
  const _RecommendedCard({required this.item, required this.onTap});

  final AiMatchResultEntity item;
  final VoidCallback onTap;

  String get _absoluteAvatarUrl {
    final raw = item.avatarUrl;
    if (raw.isEmpty) return '';
    return raw.startsWith('http') ? raw : '${ApiRoutes.mediaBaseUrl}$raw';
  }

  /// The design puts an @handle above the name. The matcher's payload has no
  /// handle, so the location line takes that slot when there is one.
  String get _subtitle =>
      [item.city, item.region].where((s) => s.isNotEmpty).join(', ');

  String get _followers {
    final n = int.tryParse(item.totalFollowers) ?? 0;
    if (n <= 0) return '';
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)} mln';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
    final subtitle = _subtitle;
    final followers = _followers;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.lightBg3,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _absoluteAvatarUrl.isNotEmpty
                  ? Image.network(
                      _absoluteAvatarUrl,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _placeholder(),
                    )
                  : _placeholder(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subtitle.isNotEmpty) ...[
                    Text(
                      subtitle,
                      style: Typographies.bodySmall.copyWith(
                        color: AppColors.mutedBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                  ],
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          item.displayName.isNotEmpty
                              ? item.displayName
                              : t.analytics.influencer_number(
                                  id: item.influencerId,
                                ),
                          style: Typographies.titleMedium,
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
                  if (followers.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      t.brand.followers_count(count: followers),
                      style: Typographies.bodySmall.copyWith(
                        color: AppColors.mutedBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() => const AvatarPlaceholder(size: 56, borderRadius: 12);
}
