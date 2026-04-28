import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/domain/entities/ai_matching/ai_match_result_entity.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ai_matching/ai_matching_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ai_matching/ai_matching_state.dart';
import 'package:brandface/presentation/home_page/brand/ui/ambassador_details_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/shared/influencer_card_widgets.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AiMatchingResultsPage extends StatefulWidget {
  const AiMatchingResultsPage({super.key});

  static const String tag = '/ai-matching-results';

  @override
  State<AiMatchingResultsPage> createState() => _AiMatchingResultsPageState();
}

class _AiMatchingResultsPageState extends State<AiMatchingResultsPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        backgroundColor: AppColors.lightBg,
        scrolledUnderElevation: 0,
        title: Text('AI Matching', style: Typographies.titleMedium),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: InfluencerToggle(
              selected: _selectedTab,
              onChanged: (i) => setState(() => _selectedTab = i),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<AiMatchingCubit, AiMatchingState>(
              builder: (context, state) {
                if (state is AiMatchingLoading || state is AiMatchingRunning) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is AiMatchingFailure) {
                  return Center(
                    child: Text(state.message, style: Typographies.bodyMedium),
                  );
                }
                if (state is AiMatchingNoOffers) {
                  return Center(
                    child: Text(
                      'No active offers found.',
                      style: Typographies.bodyMedium
                          .copyWith(color: AppColors.grey),
                    ),
                  );
                }
                if (state is AiMatchingEmpty) {
                  return _EmptyState(
                    offerId: state.offerId,
                    offerTitle: state.offerTitle,
                  );
                }
                if (state is AiMatchingLoaded) {
                  final results = state.results;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '${results.length} found',
                          style: Typographies.bodyMedium
                              .copyWith(color: AppColors.mutedBlack),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                          itemCount: results.length,
                          separatorBuilder: (c, i) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => context.pushNamed(
                              AmbassadorDetailsPage.tag,
                              extra: results[index].influencerId,
                            ),
                            child: AiMatchCard(item: results[index]),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.offerId, required this.offerTitle});
  final int offerId;
  final String offerTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded, size: 56, color: AppColors.grey),
            const SizedBox(height: 16),
            Text(
              'No matches yet for "$offerTitle"',
              style: Typographies.titleSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Run AI matching to find the best influencers.',
              style: Typographies.bodyMedium.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context
                  .read<AiMatchingCubit>()
                  .runMatching(offerId, offerTitle),
              icon: const Icon(Icons.auto_awesome_rounded, size: 18),
              label: const Text('Run AI Matching'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── AiMatchCard ─────────────────────────────────────────────────────────────

class AiMatchCard extends StatelessWidget {
  const AiMatchCard({super.key, required this.item});
  final AiMatchResultEntity item;

  String _formatFollowers(String raw) {
    final n = int.tryParse(raw) ?? 0;
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)} mln';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return raw;
  }

  @override
  Widget build(BuildContext context) {
    final cats = item.categories
        .split(',')
        .map((c) => c.trim())
        .where((c) => c.isNotEmpty)
        .take(3)
        .toList();

    final avatarUrl = item.avatarUrl.startsWith('http')
        ? item.avatarUrl
        : '${ApiRoutes.mediaBaseUrl}${item.avatarUrl}';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfluencerAvatar(url: avatarUrl, isTop: item.isTop),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.displayName.isNotEmpty
                            ? item.displayName
                            : 'Influencer #${item.influencerId}',
                        style: Typographies.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (item.isVerified) ...[
                      const SizedBox(width: 4),
                      Icon(Icons.check_circle,
                          color: AppColors.primaryDark, size: 18),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  runSpacing: 2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: item.averageRating != '0'
                          ? AppColors.orange
                          : AppColors.grey,
                      size: 14,
                    ),
                    Text(
                      item.averageRating != '0' ? item.averageRating : '—',
                      style: Typographies.bodySmall
                          .copyWith(color: AppColors.mutedBlack),
                    ),
                    if (item.totalFollowers != '0') ...[
                      Text('·',
                          style: Typographies.bodySmall
                              .copyWith(color: AppColors.mutedBlack)),
                      Text(
                        '${_formatFollowers(item.totalFollowers)} followers',
                        style: Typographies.bodySmall
                            .copyWith(color: AppColors.mutedBlack),
                      ),
                    ],
                  ],
                ),
                if (cats.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: cats.map((c) => InfluencerChip(label: c)).toList(),
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
