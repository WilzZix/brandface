import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/profile/ambassador_entity.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassadors/ambassadors_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassadors/ambassadors_state.dart';
import 'package:brandface/presentation/home_page/brand/ui/ambassador_details_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/ambassadors_filter_page.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AmbassadorsPageArguments {
  final String? role;
  final String? title;

  const AmbassadorsPageArguments({this.role, this.title});
}

class AmbassadorsPage extends StatefulWidget {
  const AmbassadorsPage({super.key, this.title});

  static const String tag = '/ambassadors';

  final String? title;

  @override
  State<AmbassadorsPage> createState() => _AmbassadorsPageState();
}

enum _SortOption { ranking, newlyJoined, followers, experience }

class _AmbassadorsPageState extends State<AmbassadorsPage> {
  _SortOption _sortOption = _SortOption.ranking;
  AmbassadorsFilterParams? _filterParams;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String? _sortToOrdering() {
    switch (_sortOption) {
      case _SortOption.ranking:
        return '-average_rating';
      case _SortOption.newlyJoined:
        return '-created_at';
      case _SortOption.followers:
        return '-followers_count';
      case _SortOption.experience:
        return '-years_of_experience';
    }
  }

  Future<void> _showSortSheet() async {
    final cubit = context.read<AmbassadorsCubit>();
    final selected = await showModalBottomSheet<_SortOption>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _SortBottomSheet(current: _sortOption),
    );
    if (selected != null && selected != _sortOption) {
      setState(() => _sortOption = selected);
      cubit.load(ordering: _sortToOrdering(), filter: _filterParams);
    }
  }

  Future<void> _showFilterPage() async {
    final cubit = context.read<AmbassadorsCubit>();
    final result = await context.pushNamed<AmbassadorsFilterParams?>(
      AmbassadorsFilterPage.tag,
      extra: _filterParams,
    );
    if (!mounted) return;
    setState(() => _filterParams = result);
    cubit.load(ordering: _sortToOrdering(), filter: result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        backgroundColor: AppColors.lightBg,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(AppAssets.icArrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.title ?? t.brand.ambassadors),
        centerTitle: false,
        titleTextStyle: Typographies.titleMedium,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.lightBg3,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (q) =>
                          context.read<AmbassadorsCubit>().search(q),
                      decoration: InputDecoration(
                        hintText: t.brand.search,
                        hintStyle: Typographies.bodyMedium.copyWith(
                          color: AppColors.grey,
                        ),
                        prefixIcon: Icon(Icons.search, color: AppColors.grey),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _showSortSheet,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(child: SvgPicture.asset(AppAssets.icSort)),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _showFilterPage,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _filterParams != null && !_filterParams!.isEmpty
                          ? AppColors.lightGreen
                          : AppColors.lightBg3,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(child: SvgPicture.asset(AppAssets.icFilter)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<AmbassadorsCubit, AmbassadorsState>(
              builder: (context, state) {
                if (state is AmbassadorsLoaded) {
                  return Text(
                    t.brand.ambassadors_found(count: state.ambassadors.length),
                    style: Typographies.bodyMedium.copyWith(
                      color: AppColors.mutedBlack,
                    ),
                  );
                }
                if (state is AmbassadorsLoading) {
                  return Text(
                    t.brand.ambassadors_found(count: 0),
                    style: Typographies.bodyMedium.copyWith(
                      color: AppColors.mutedBlack,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<AmbassadorsCubit, AmbassadorsState>(
              builder: (context, state) {
                if (state is AmbassadorsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is AmbassadorsFailure) {
                  return Center(
                    child: Text(
                      state.message,
                      style: Typographies.bodyMedium
                          .copyWith(color: AppColors.grey),
                    ),
                  );
                }
                if (state is AmbassadorsLoaded) {
                  if (state.ambassadors.isEmpty) {
                    return Center(
                      child: Text(
                        t.brand.no_ambassadors_found,
                        style: Typographies.bodyMedium
                            .copyWith(color: AppColors.grey),
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    itemCount: state.ambassadors.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => context.pushNamed(
                        AmbassadorDetailsPage.tag,
                        extra: state.ambassadors[index].id,
                      ),
                      child: _AmbassadorCard(
                        ambassador: state.ambassadors[index],
                      ),
                    ),
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

class _AmbassadorCard extends StatelessWidget {
  const _AmbassadorCard({required this.ambassador});

  final AmbassadorEntity ambassador;

  String _formatFollowers(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)} mln';
    }
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    final followersText = ambassador.followersCount != null
        ? t.brand.followers_count(count: _formatFollowers(ambassador.followersCount!))
        : null;
    final experienceText = ambassador.yearsOfExperience != null
        ? t.brand.years_experience(count: ambassador.yearsOfExperience!)
        : null;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar with optional TOP badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ambassador.avatarUrl != null
                    ? Image.network(
                        ambassador.avatarUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => _PlaceholderAvatar(),
                      )
                    : _PlaceholderAvatar(),
              ),
              if (ambassador.isTop)
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      t.brand.top_label,
                      style: Typographies.labelSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          // Info column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + verified
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        ambassador.displayName ?? '—',
                        style: Typographies.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (ambassador.isVerified) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primaryDark,
                        size: 18,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                // Rating · followers · experience
                Wrap(
                  spacing: 4,
                  runSpacing: 2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: ambassador.averageRating != null
                          ? AppColors.orange
                          : AppColors.grey,
                      size: 14,
                    ),
                    Text(
                      ambassador.averageRating != null
                          ? ambassador.averageRating!.toStringAsFixed(2)
                          : '—',
                      style: Typographies.bodySmall
                          .copyWith(color: AppColors.mutedBlack),
                    ),
                    if (followersText != null) ...[
                      Text(
                        '·',
                        style: Typographies.bodySmall
                            .copyWith(color: AppColors.mutedBlack),
                      ),
                      Text(
                        followersText,
                        style: Typographies.bodySmall
                            .copyWith(color: AppColors.mutedBlack),
                      ),
                    ],
                    if (experienceText != null) ...[
                      Text(
                        '·',
                        style: Typographies.bodySmall
                            .copyWith(color: AppColors.mutedBlack),
                      ),
                      Text(
                        experienceText,
                        style: Typographies.bodySmall
                            .copyWith(color: AppColors.mutedBlack),
                      ),
                    ],
                  ],
                ),
                if (ambassador.categories.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: ambassador.categories.map((c) => _CategoryChip(label: c)).toList(),
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

class _PlaceholderAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.borderColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.person, color: AppColors.grey, size: 36),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: Typographies.bodySmall),
    );
  }
}

class _SortBottomSheet extends StatelessWidget {
  const _SortBottomSheet({required this.current});

  final _SortOption current;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(t.brand.sort_by, style: Typographies.titleMedium),
            const SizedBox(height: 8),
            _SortTile(
              label: t.brand.sort_by_ranking,
              selected: current == _SortOption.ranking,
              onTap: () => Navigator.of(context).pop(_SortOption.ranking),
            ),
            _SortTile(
              label: t.brand.sort_by_newly_joined,
              selected: current == _SortOption.newlyJoined,
              onTap: () => Navigator.of(context).pop(_SortOption.newlyJoined),
            ),
            _SortTile(
              label: t.brand.sort_by_followers,
              selected: current == _SortOption.followers,
              onTap: () => Navigator.of(context).pop(_SortOption.followers),
            ),
            _SortTile(
              label: t.brand.sort_by_experience,
              selected: current == _SortOption.experience,
              onTap: () => Navigator.of(context).pop(_SortOption.experience),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _SortTile extends StatelessWidget {
  const _SortTile({
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Typographies.bodyMedium),
            if (selected)
              Icon(Icons.check, color: AppColors.primaryDark, size: 20),
          ],
        ),
      ),
    );
  }
}
