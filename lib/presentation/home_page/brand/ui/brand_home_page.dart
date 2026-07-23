import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/uikit/components/avatar/avatar_placeholder.dart';
import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassadors/ambassadors_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/brand_analytics/brand_analytics_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/brand_analytics/brand_analytics_state.dart';
import 'package:brandface/presentation/home_page/brand/bloc/people_lists/brand_people_lists_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/people_lists/brand_people_lists_state.dart';
import 'package:brandface/presentation/home_page/brand/ui/ambassador_details_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/brand_profile_menu_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/widgets/ai_insights_section.dart';
import 'package:brandface/presentation/home_page/brand/ui/widgets/ambassador_row_card.dart';
import 'package:brandface/presentation/home_page/brand/ui/widgets/audience_insights_section.dart';
import 'package:brandface/presentation/home_page/brand/ui/widgets/brand_activity_summary.dart';
import 'package:brandface/presentation/home_page/brand/ui/widgets/brand_home_primitives.dart';
import 'package:brandface/presentation/home_page/brand/ui/widgets/offer_performance_section.dart';
import 'package:brandface/presentation/home_page/brand/ui/widgets/people_list_section.dart';
import 'package:brandface/presentation/home_page/profile/bloc/profile_information/profile_information_cubit.dart';
import 'package:brandface/presentation/home_page/brand/ui/ai_matching_results_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/favourites_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/ambassadors_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/brand_analytics_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/shared/influencer_card_widgets.dart';
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

  /// Which side of the AI Matching toggle is showing: 0 influencers,
  /// 1 ambassadors.
  int _aiTab = 0;

  static const _sectionGap = SizedBox(height: 40);

  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _openAmbassador(int id, String title) {
    context.pushNamed(AmbassadorDetailsPage.tag, extra: (id, title));
  }

  void _openAmbassadorList({
    String? role,
    String? title,
    AmbassadorsFilterParams? filter,
  }) {
    context.pushNamed(
      AmbassadorsPage.tag,
      extra: AmbassadorsPageArguments(
        role: role,
        title: title ?? t.brand.ambassadors,
        filter: filter,
      ),
    );
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
                        child: BlocBuilder<ProfileInformationCubit,
                            ProfileInformationState>(
                          builder: (context, state) {
                            final avatarUrl = state.maybeWhen(
                              infoLoaded: (data) => data.avatarUrl,
                              orElse: () => null,
                            );
                            return _BrandAvatar(avatarUrl: avatarUrl);
                          },
                        ),
                      ),
                    ),
                  ),
                  title: BlocBuilder<ProfileInformationCubit,
                      ProfileInformationState>(
                    builder: (context, state) {
                      final name = state.maybeWhen(
                        infoLoaded: (data) =>
                            data.displayName?.trim().isNotEmpty == true
                                ? data.displayName!.trim()
                                : t.brand.title,
                        orElse: () => t.brand.title,
                      );
                      return Text(name, style: Typographies.titleMedium);
                    },
                  ),
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
                SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(child: _analyticsSections()),
                SliverToBoxAdapter(child: _sectionGap),
                SliverToBoxAdapter(child: _peopleSections()),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 96 + MediaQuery.of(context).padding.bottom,
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
                          behavior: HitTestBehavior.opaque,
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
                          behavior: HitTestBehavior.opaque,
                          onTap: () => _openAmbassadorList(
                            role: 'brandface',
                            title: t.brand.brandfaces,
                          ),
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
                          behavior: HitTestBehavior.opaque,
                          onTap: () => _openAmbassadorList(
                            role: 'ambassador',
                            title: t.brand.ambassadors,
                          ),
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
                          behavior: HitTestBehavior.opaque,
                          onTap: () => _openAmbassadorList(
                            role: 'influencer',
                            title: t.brand.influencers,
                          ),
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
                          behavior: HitTestBehavior.opaque,
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
                          behavior: HitTestBehavior.opaque,
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
                          behavior: HitTestBehavior.opaque,
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

  /// Activity summary → offer performance → AI insights → recommended →
  /// audience. All five read the same analytics payload, so they share one
  /// builder and appear together once it lands.
  Widget _analyticsSections() {
    return BlocBuilder<BrandAnalyticsCubit, BrandAnalyticsState>(
      builder: (context, state) {
        if (state is BrandAnalyticsFailure) return const SizedBox.shrink();
        if (state is! BrandAnalyticsLoaded) {
          return const Column(
            children: [
              BrandBlockSkeleton(height: 220),
              SizedBox(height: 16),
              BrandBlockSkeleton(height: 320),
            ],
          );
        }

        final data = state.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrandActivitySummary(
              data: data,
              onOffersTap: () =>
                  context.pushNamed(CollaborationOffersPage.tag),
              onApplicationsTap: () =>
                  context.pushNamed(CollaborationOffersPage.tag),
            ),
            _sectionGap,
            OfferPerformanceSection(state: state),
            _sectionGap,
            AiMatchingInsights(data: data),
            if (data.topRecommendedAmbassadors.isNotEmpty) ...[
              _sectionGap,
              TopRecommendedAmbassadors(
                items: data.topRecommendedAmbassadors,
                onTap: (id) => _openAmbassador(id, t.ambassador.ambassador_details),
              ),
            ],
            _sectionGap,
            AudienceInsightsSection(data: data),
          ],
        );
      },
    );
  }

  /// Most viewed (from analytics) followed by the three ambassador-endpoint
  /// blocks. Each hides itself when it has nothing to show.
  Widget _peopleSections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mostViewedSection(),
        BlocBuilder<BrandPeopleListsCubit, BrandPeopleListsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!state.vip.isEmpty) ...[
                  _sectionGap,
                  _slotSection(
                    title: t.analytics.vip_users,
                    slot: state.vip,
                    detailsTitle: t.ambassador.ambassador_details,
                    onBrowseAll: () => _openAmbassadorList(
                      title: t.analytics.vip_users,
                      filter: const AmbassadorsFilterParams(isVip: true),
                    ),
                  ),
                ],
                if (!state.top.isEmpty) ...[
                  _sectionGap,
                  _slotSection(
                    title: t.analytics.top_users,
                    slot: state.top,
                    detailsTitle: t.ambassador.ambassador_details,
                    onBrowseAll: () => _openAmbassadorList(
                      title: t.analytics.top_users,
                      filter: const AmbassadorsFilterParams(isTop: true),
                    ),
                  ),
                ],
                _sectionGap,
                _aiMatchingSection(state),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _mostViewedSection() {
    return BlocBuilder<BrandAnalyticsCubit, BrandAnalyticsState>(
      builder: (context, state) {
        if (state is! BrandAnalyticsLoaded) return const SizedBox.shrink();
        final items = state.data.mostViewedAmbassadors;
        if (items.isEmpty) return const SizedBox.shrink();

        return PeopleListSection(
          title: t.analytics.most_viewed_ambassadors,
          rows: items
              .take(BrandPeopleListsCubit.previewCount)
              .map(
                (a) => AmbassadorRowCard.fromMatchResult(
                  a,
                  onTap: () => _openAmbassador(
                    a.influencerId,
                    t.ambassador.ambassador_details,
                  ),
                ),
              )
              .toList(),
          onBrowseAll: () => _openAmbassadorList(
            role: 'ambassador',
            title: t.brand.ambassadors,
          ),
        );
      },
    );
  }

  Widget _slotSection({
    required String title,
    required PeopleSlot slot,
    required String detailsTitle,
    required VoidCallback onBrowseAll,
    Widget? header,
  }) {
    if (slot.isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BrandSectionTitle(title),
          const SizedBox(height: 16),
          const BrandBlockSkeleton(height: 240),
        ],
      );
    }

    return PeopleListSection(
      title: title,
      header: header,
      rows: slot.items
          .map(
            (a) => AmbassadorRowCard.fromAmbassador(
              a,
              onTap: () => _openAmbassador(a.id, detailsTitle),
            ),
          )
          .toList(),
      onBrowseAll: onBrowseAll,
    );
  }

  Widget _aiMatchingSection(BrandPeopleListsState state) {
    final isInfluencers = _aiTab == 0;
    final slot = isInfluencers ? state.influencers : state.ambassadors;
    final role = isInfluencers ? 'influencer' : 'ambassador';
    final listTitle = isInfluencers ? t.brand.influencers : t.brand.ambassadors;
    final detailsTitle = isInfluencers
        ? t.ambassador.influencer_details
        : t.ambassador.ambassador_details;

    return _slotSection(
      title: t.brand.ai_matching,
      slot: slot,
      detailsTitle: detailsTitle,
      header: InfluencerToggle(
        selected: _aiTab,
        onChanged: (value) => setState(() => _aiTab = value),
      ),
      onBrowseAll: () => _openAmbassadorList(role: role, title: listTitle),
    );
  }
}

class _BrandAvatar extends StatelessWidget {
  const _BrandAvatar({this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final url = avatarUrl?.trim();
    if (url == null || url.isEmpty) {
      return _placeholder();
    }
    final absoluteUrl =
        url.startsWith('http') ? url : '${ApiRoutes.mediaBaseUrl}$url';
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        absoluteUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _placeholder(),
      ),
    );
  }

  Widget _placeholder() =>
      const AvatarPlaceholder(size: 56, borderRadius: 8);
}
