import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/ai_matching/ai_match_result_entity.dart';
import 'package:brandface/domain/entities/profile/ambassador_entity.dart';
import 'package:brandface/uikit/components/avatar/avatar_placeholder.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

/// Corner ribbon on the avatar.
enum RowBadge { none, top, vip }

/// The people row used by every list block on the brand home page: avatar with
/// an optional TOP/VIP ribbon, name with verification tick, a dotted meta line
/// and category chips.
///
/// Two sources feed it — the ambassadors endpoint and the analytics payload —
/// so it takes plain values and offers a named constructor per source.
class AmbassadorRowCard extends StatelessWidget {
  const AmbassadorRowCard({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.isVerified,
    required this.badge,
    required this.categories,
    this.rating,
    this.followers,
    this.experienceYears,
    this.onTap,
  });

  /// From the ambassadors list endpoint.
  factory AmbassadorRowCard.fromAmbassador(
    AmbassadorEntity a, {
    VoidCallback? onTap,
  }) {
    return AmbassadorRowCard(
      name: a.displayName?.trim().isNotEmpty == true
          ? a.displayName!.trim()
          : '—',
      avatarUrl: a.avatarUrl ?? '',
      isVerified: a.isVerified,
      badge: a.isVip
          ? RowBadge.vip
          : a.isTop
              ? RowBadge.top
              : RowBadge.none,
      categories: a.categories,
      rating: a.averageRating,
      followers: a.followersCount,
      experienceYears: a.yearsOfExperience,
      onTap: onTap,
    );
  }

  /// From the brand analytics payload, which types its numbers as strings.
  factory AmbassadorRowCard.fromMatchResult(
    AiMatchResultEntity a, {
    VoidCallback? onTap,
  }) {
    final categories = a.categories
        .split(',')
        .map((c) => c.trim())
        .where((c) => c.isNotEmpty)
        .toList();
    final rating = double.tryParse(a.averageRating);
    final followers = int.tryParse(a.totalFollowers);

    return AmbassadorRowCard(
      name: a.displayName.isNotEmpty
          ? a.displayName
          : t.analytics.influencer_number(id: a.influencerId),
      avatarUrl: a.avatarUrl,
      isVerified: a.isVerified,
      badge: a.isTop ? RowBadge.top : RowBadge.none,
      categories: categories,
      rating: rating != null && rating > 0 ? rating : null,
      followers: followers != null && followers > 0 ? followers : null,
      onTap: onTap,
    );
  }

  final String name;
  final String avatarUrl;
  final bool isVerified;
  final RowBadge badge;
  final List<String> categories;
  final double? rating;
  final int? followers;
  final int? experienceYears;
  final VoidCallback? onTap;

  static String formatFollowers(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)} mln';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }

  String get _absoluteAvatarUrl {
    if (avatarUrl.isEmpty) return '';
    return avatarUrl.startsWith('http')
        ? avatarUrl
        : '${ApiRoutes.mediaBaseUrl}$avatarUrl';
  }

  @override
  Widget build(BuildContext context) {
    final meta = <String>[
      if (rating != null) rating!.toStringAsFixed(2),
      if (followers != null)
        t.brand.followers_count(count: formatFollowers(followers!)),
      if (experienceYears != null)
        t.brand.years_experience(count: experienceYears!),
    ];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(url: _absoluteAvatarUrl, badge: badge),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: Typographies.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isVerified) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primaryDark,
                        size: 18,
                      ),
                    ],
                  ],
                ),
                if (meta.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      if (rating != null) ...[
                        Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: AppColors.grey,
                        ),
                        const SizedBox(width: 2),
                      ],
                      Expanded(
                        child: Text(
                          meta.join('  ·  '),
                          style: Typographies.bodySmall.copyWith(
                            color: AppColors.mutedBlack,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                if (categories.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: categories
                        .take(3)
                        .map((c) => _CategoryChip(label: c))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url, required this.badge});

  final String url;
  final RowBadge badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: url.isNotEmpty
              ? Image.network(
                  url,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _placeholder(),
                )
              : _placeholder(),
        ),
        if (badge != RowBadge.none)
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  topRight: Radius.circular(4),
                ),
              ),
              child: Text(
                badge == RowBadge.vip ? t.brand.vip_label : t.brand.top_label,
                style: Typographies.labelSmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _placeholder() => const AvatarPlaceholder(size: 80, borderRadius: 12);
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: Typographies.bodySmall),
    );
  }
}
