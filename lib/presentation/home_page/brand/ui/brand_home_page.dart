import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/ai_matching/ai_match_result_entity.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ai_matching/ai_matching_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ai_matching/ai_matching_state.dart';
import 'package:brandface/presentation/home_page/brand/bloc/brand_stats_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/brand_stats_state.dart';
import 'package:brandface/presentation/home_page/brand/ui/brand_profile_menu_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/ai_matching_results_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/favourites_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/ambassadors_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/brand_analytics_page.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/components/ui_components/badge.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../notifications/notifications_page.dart';
import 'collaboration_offers_page.dart';

class BrandHomePage extends StatefulWidget {
  const BrandHomePage({super.key});

  static const String tag = '/brand_home_page';

  @override
  State<BrandHomePage> createState() => _BrandHomePageState();
}

class _BrandHomePageState extends State<BrandHomePage> {
  bool _isOpen = false;

  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  scrolledUnderElevation: 0,
                  backgroundColor: AppColors.lightBg,
                  pinned: true,
                  leading: GestureDetector(
                    onTap: () => context.pushNamed(BrandProfileMenuPage.tag),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/im_person_avatar_sample.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(t.brand.title, style: Typographies.titleMedium),
                  actions: [
                    GestureDetector(
                      onTap: () => context.pushNamed(NotificationsPage.tag),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.lightGreen,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 12,
                          ),
                          child: Stack(
                            children: [
                              SvgPicture.asset(AppAssets.icBell),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                  ],
                ),
                SliverToBoxAdapter(child: SizedBox(height: 32)),
                SliverToBoxAdapter(
                  child: Text(
                    t.brand.offers_and_applications,
                    style: Typographies.titleLarge,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: BlocBuilder<BrandStatsCubit, BrandStatsState>(
                    builder: (context, state) {
                      final activeOffers = state is BrandStatsLoaded
                          ? state.activeOffersCount.toString()
                          : state is BrandStatsLoading
                          ? '...'
                          : '—';
                      final applications = state is BrandStatsLoaded
                          ? state.totalApplicationsCount.toString()
                          : state is BrandStatsLoading
                          ? '...'
                          : '—';
                      return IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: _BrandStatCard(
                                title: activeOffers,
                                description: t.common.active_offers,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: _BrandStatCard(
                                title: applications,
                                description: t.brand.new_applications,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 32)),
                SliverToBoxAdapter(
                  child: Text(
                    t.brand.ai_matching,
                    style: Typographies.titleLarge,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: BlocBuilder<AiMatchingCubit, AiMatchingState>(
                    builder: (context, state) {
                      if (state is AiMatchingLoaded &&
                          state.results.isNotEmpty) {
                        return _AiOfferHeader(
                          offerTitle: state.offerTitle,
                          offerId: state.offerId,
                        );
                      }
                      if (state is AiMatchingEmpty) {
                        return _AiOfferHeader(
                          offerTitle: state.offerTitle,
                          offerId: state.offerId,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: BlocBuilder<AiMatchingCubit, AiMatchingState>(
                    builder: (context, state) {
                      if (state is AiMatchingLoading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (state is AiMatchingNoOffers) {
                        return _AiEmptyState(
                          message: t.brand.no_active_campaigns_yet,
                        );
                      }
                      if (state is AiMatchingFailure) {
                        return _AiEmptyState(message: state.message);
                      }
                      if (state is AiMatchingEmpty) {
                        return _AiRunMatchSection(
                          offerId: state.offerId,
                          offerTitle: state.offerTitle,
                        );
                      }
                      if (state is AiMatchingRunning) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                BlocBuilder<AiMatchingCubit, AiMatchingState>(
                  builder: (context, state) {
                    if (state is! AiMatchingLoaded) {
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }
                    return SliverList.separated(
                      itemCount: state.results.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 24),
                      itemBuilder: (context, index) {
                        return _AiMatchItem(item: state.results[index]);
                      },
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16 + MediaQuery.of(context).padding.bottom,
                  ),
                ),
              ],
            ),
          ),
          IgnorePointer(
            ignoring: !_isOpen,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _isOpen ? 1.0 : 0.0,
              child: Container(
                color: AppColors.lightBg,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 56 + MediaQuery.of(context).padding.top,
                        ),
                        Center(child: SvgPicture.asset(AppAssets.icLogo)),
                        SizedBox(height: 24),
                        Center(child: SvgPicture.asset(AppAssets.icOnBoarding)),
                        SizedBox(height: 24),
                        Text(t.common.menu, style: Typographies.headlineSmall),
                        SizedBox(height: 32),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(CollaborationOffersPage.tag);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t.brand.collaboration_offers,
                                style: Typographies.titleMedium,
                              ),
                              SvgPicture.asset(AppAssets.icChevronRight),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Divider(color: AppColors.borderColor),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t.brand.brandfaces,
                                style: Typographies.titleMedium,
                              ),
                              SvgPicture.asset(AppAssets.icChevronRight),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Divider(color: AppColors.borderColor),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () =>
                              context.pushNamed(AmbassadorsPage.tag),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t.brand.ambassadors,
                                style: Typographies.titleMedium,
                              ),
                              SvgPicture.asset(AppAssets.icChevronRight),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Divider(color: AppColors.borderColor),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () =>
                              context.pushNamed(AmbassadorsPage.tag),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t.brand.influencers,
                                style: Typographies.titleMedium,
                              ),
                              SvgPicture.asset(AppAssets.icChevronRight),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Divider(color: AppColors.borderColor),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () =>
                              context.pushNamed(FavouritesPage.tag),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t.brand.favourites,
                                style: Typographies.titleMedium,
                              ),
                              SvgPicture.asset(AppAssets.icChevronRight),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Divider(color: AppColors.borderColor),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () =>
                              context.pushNamed(AiMatchingResultsPage.tag),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t.brand.ai_matching,
                                style: Typographies.titleMedium,
                              ),
                              SvgPicture.asset(AppAssets.icChevronRight),
                            ],
                          ),
                        ),
                        Divider(color: AppColors.borderColor),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => context.pushNamed(BrandAnalyticsPage.tag),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t.brand.analytics,
                                style: Typographies.titleMedium,
                              ),
                              SvgPicture.asset(AppAssets.icChevronRight),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.bottom + 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: _toggleMenu,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (child, anim) => RotationTransition(
            turns: anim,
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: AppColors.black,
              shape: BoxShape.circle,
            ),
            child: _isOpen
                ? Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SvgPicture.asset(AppAssets.icClose),
                  )
                : Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SvgPicture.asset(AppAssets.icBars),
                  ),
          ),
        ),
      ),
    );
  }
}

class _BrandStatCard extends StatelessWidget {
  const _BrandStatCard({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Typographies.headlineMedium),
          const SizedBox(height: 8),
          Text(description, style: Typographies.bodyMedium),
        ],
      ),
    );
  }
}

class _AiOfferHeader extends StatelessWidget {
  const _AiOfferHeader({required this.offerTitle, required this.offerId});

  final String offerTitle;
  final int offerId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.auto_awesome, size: 16, color: AppColors.black),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.brand.ai_matching,
                  style: Typographies.labelSmall
                      .copyWith(color: AppColors.mutedBlack),
                ),
                Text(
                  offerTitle,
                  style: Typographies.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AiRunMatchSection extends StatelessWidget {
  const _AiRunMatchSection({
    required this.offerId,
    required this.offerTitle,
  });

  final int offerId;
  final String offerTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            SvgPicture.asset(AppAssets.icEmptyData),
            const SizedBox(height: 16),
            Text(
              t.brand.ai_matching,
              style: Typographies.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              t.brand.no_active_campaigns_yet,
              style:
                  Typographies.bodySmall.copyWith(color: AppColors.mutedBlack),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppButtons.primary(
              title: t.brand.ai_matching,
              onTap: () {
                context.read<AiMatchingCubit>().runMatching(offerId, offerTitle);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AiEmptyState extends StatelessWidget {
  const _AiEmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            SvgPicture.asset(AppAssets.icEmptyData),
            const SizedBox(height: 16),
            Text(
              message,
              style:
                  Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _AiMatchItem extends StatelessWidget {
  const _AiMatchItem({required this.item});

  final AiMatchResultEntity item;

  @override
  Widget build(BuildContext context) {
    final categoryList = item.categories
        .split(',')
        .map((c) => c.trim())
        .where((c) => c.isNotEmpty)
        .take(3)
        .toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 80,
                width: 80,
                child: item.avatarUrl.isNotEmpty
                    ? Image.network(
                        item.avatarUrl.startsWith('http')
                            ? item.avatarUrl
                            : '${ApiRoutes.mediaBaseUrl}${item.avatarUrl}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) => _defaultAvatar(),
                      )
                    : _defaultAvatar(),
              ),
            ),
            if (item.isTop)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: AppColors.orange,
                  ),
                  child: Text(
                    t.brand.top_label,
                    style: Typographies.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),
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
                      style: Typographies.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (item.isVerified) ...[
                    const SizedBox(width: 4),
                    SvgPicture.asset(AppAssets.icVerified),
                  ],
                  const SizedBox(width: 8),
                  _ScoreBadge(score: item.score),
                ],
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (item.averageRating != '0') ...[
                    SvgPicture.asset(
                      AppAssets.icStar,
                      colorFilter: ColorFilter.mode(
                        AppColors.lightBg2,
                        BlendMode.srcIn,
                      ),
                    ),
                    Text(
                      item.averageRating,
                      style: Typographies.bodySmall.copyWith(
                        color: AppColors.mutedBlack,
                      ),
                    ),
                    Text('·'),
                  ],
                  if (item.totalFollowers.isNotEmpty &&
                      item.totalFollowers != '0')
                    Text(
                      '${item.totalFollowers} followers',
                      style: Typographies.bodySmall.copyWith(
                        color: AppColors.mutedBlack,
                      ),
                    ),
                  if (item.engagementRate.isNotEmpty &&
                      item.engagementRate != '0') ...[
                    Text('·'),
                    Text(
                      '${item.engagementRate}% ER',
                      style: Typographies.bodySmall.copyWith(
                        color: AppColors.mutedBlack,
                      ),
                    ),
                  ],
                ],
              ),
              if (item.city.isNotEmpty || item.region.isNotEmpty) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 12,
                      color: AppColors.mutedBlack,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      [item.city, item.region]
                          .where((s) => s.isNotEmpty)
                          .join(', '),
                      style: Typographies.bodySmall.copyWith(
                        color: AppColors.mutedBlack,
                      ),
                    ),
                  ],
                ),
              ],
              if (categoryList.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: categoryList
                      .map((cat) => AppBadge(title: cat))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _defaultAvatar() {
    return Image.asset(
      'assets/images/im_person_avatar_sample.png',
      fit: BoxFit.cover,
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  const _ScoreBadge({required this.score});

  final double score;

  Color get _color {
    if (score >= 70) return const Color(0xFF497D00);
    if (score >= 40) return AppColors.orange;
    return AppColors.mutedBlack;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _color.withValues(alpha: 0.4)),
      ),
      child: Text(
        '${score.toStringAsFixed(0)}%',
        style: Typographies.labelSmall.copyWith(color: _color),
      ),
    );
  }
}
