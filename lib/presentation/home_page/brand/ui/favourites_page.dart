import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/domain/entities/profile/favourite_entity.dart';
import 'package:brandface/presentation/home_page/brand/bloc/favourites/favourites_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/favourites/favourites_state.dart';
import 'package:brandface/presentation/home_page/brand/ui/ambassador_details_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/shared/influencer_card_widgets.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  static const String tag = '/favourites';

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        backgroundColor: AppColors.lightBg,
        scrolledUnderElevation: 0,
        title: Text('Favourites', style: Typographies.titleMedium),
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
            child: BlocBuilder<FavouritesCubit, FavouritesState>(
              builder: (context, state) {
                if (state is FavouritesLoading || state is FavouritesInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is FavouritesFailure) {
                  return Center(
                    child: Text(state.message, style: Typographies.bodyMedium),
                  );
                }
                if (state is FavouritesLoaded) {
                  if (state.items.isEmpty) {
                    return Center(
                      child: Text(
                        'No favourites yet.',
                        style: Typographies.bodyMedium
                            .copyWith(color: AppColors.grey),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '${state.items.length} found',
                          style: Typographies.bodyMedium
                              .copyWith(color: AppColors.mutedBlack),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.separated(
                          padding:
                              const EdgeInsets.fromLTRB(16, 0, 16, 24),
                          itemCount: state.items.length,
                          separatorBuilder: (c, i) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = state.items[index];
                            return _FavouriteCard(
                              item: item,
                              onTap: () => context.pushNamed(
                                AmbassadorDetailsPage.tag,
                                extra: item.id,
                              ),
                              onDelete: () => context
                                  .read<FavouritesCubit>()
                                  .remove(item.id),
                            );
                          },
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

class _FavouriteCard extends StatelessWidget {
  const _FavouriteCard({
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  final FavouriteEntity item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  String _formatFollowers(String raw) {
    final n = int.tryParse(raw) ?? 0;
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)} mln';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return raw;
  }

  @override
  Widget build(BuildContext context) {
    final av = item.avatarUrl ?? '';
    final url = av.startsWith('http')
        ? av
        : av.isNotEmpty
            ? '${ApiRoutes.mediaBaseUrl}$av'
            : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.lightBg3,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfluencerAvatar(url: url, isTop: item.isTop),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.displayName ?? '—',
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
                        color: item.averageRating != null
                            ? AppColors.orange
                            : AppColors.grey,
                        size: 14,
                      ),
                      Text(
                        item.averageRating != null
                            ? item.averageRating!.toStringAsFixed(2)
                            : '—',
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
                      if (item.yearsOfExperience != null) ...[
                        Text('·',
                            style: Typographies.bodySmall
                                .copyWith(color: AppColors.mutedBlack)),
                        Text(
                          '${item.yearsOfExperience} years exp.',
                          style: Typographies.bodySmall
                              .copyWith(color: AppColors.mutedBlack),
                        ),
                      ],
                    ],
                  ),
                  if (item.categories.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: item.categories
                          .take(3)
                          .map((c) => InfluencerChip(label: c))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onDelete,
              child: Icon(
                Icons.delete_outline_rounded,
                color: AppColors.red,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
