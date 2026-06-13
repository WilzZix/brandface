import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/home/home_dashboard_entity.dart';
import 'package:brandface/presentation/home_page/bloc/home_cubit.dart';
import 'package:brandface/presentation/home_page/bloc/home_state.dart';
import 'package:brandface/presentation/home_page/messages/messages_page.dart';
import 'package:brandface/presentation/home_page/offers/offer_detail_page.dart';
import 'package:brandface/presentation/home_page/profile/ui/profile_page.dart';
import 'package:brandface/presentation/home_page/recomendations/recomendations.dart';
import 'package:brandface/uikit/components/ui_components/profile_image.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/extansions/snackbar_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/i18n/strings.g.dart';
import 'notifications/notifications_page.dart';
import 'offers/offers_from_brands_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String tag = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isOpen = false;

  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Stack(
        children: [
          BlocListener<HomeCubit, HomeState>(
            listenWhen: (previous, current) =>
                previous.failure != current.failure &&
                current.failure != null &&
                current.dashboard != null,
            listener: (context, state) {
              context.showAppSnackBar(
                state.failure!.message,
                type: AppSnackBarType.error,
              );
            },
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return RefreshIndicator(
                  color: AppColors.black,
                  onRefresh: () => context.read<HomeCubit>().loadHome(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: _buildSlivers(
                        context,
                        state: state,
                        bottomPadding: bottomPadding,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          IgnorePointer(
            ignoring: !_isOpen,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isOpen ? 1.0 : 0.0,
              child: Container(
                color: AppColors.lightBg,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 56 + MediaQuery.of(context).padding.top),
                      Center(child: SvgPicture.asset(AppAssets.icLogo)),
                      const SizedBox(height: 24),
                      Center(child: SvgPicture.asset(AppAssets.icOnBoarding)),
                      const SizedBox(height: 24),
                      Text(t.common.menu, style: Typographies.headlineSmall),
                      const SizedBox(height: 32),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () =>
                            context.pushNamed(OffersFromBrandsPage.tag),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              t.common.offers_from_brands,
                              style: Typographies.titleMedium,
                            ),
                            SvgPicture.asset(AppAssets.icChevronRight),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      Divider(color: AppColors.borderColor),
                      const SizedBox(height: 18),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => context.pushNamed(Recommendation.tag),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              t.common.recommended_for_you,
                              style: Typographies.titleMedium,
                            ),
                            SvgPicture.asset(AppAssets.icChevronRight),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      Divider(color: AppColors.borderColor),
                      const SizedBox(height: 18),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => context.pushNamed(MessagesPage.tag),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(t.common.messages, style: Typographies.titleMedium),
                            SvgPicture.asset(AppAssets.icChevronRight),
                          ],
                        ),
                      ),
                    ],
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
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) => RotationTransition(
            turns: anim,
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: Container(
            key: ValueKey(_isOpen),
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: AppColors.black,
              shape: BoxShape.circle,
            ),
            child: _isOpen
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: SvgPicture.asset(AppAssets.icClose),
                  )
                : Padding(
                    padding: const EdgeInsets.all(24),
                    child: SvgPicture.asset(AppAssets.icBars),
                  ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSlivers(
    BuildContext context, {
    required HomeState state,
    required double bottomPadding,
  }) {
    final dashboard = state.dashboard;

    return [
      _buildAppBar(
        context,
        dashboard: dashboard,
        showNotificationBadge: (dashboard?.unreadNotificationsCount ?? 0) > 0,
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 32)),
      if (state.status == HomeStatus.loading && dashboard == null)
        const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        )
      else if (state.status == HomeStatus.failure && dashboard == null)
        SliverFillRemaining(
          hasScrollBody: false,
          child: _HomeErrorState(
            failure: state.failure,
            onRetry: () => context.read<HomeCubit>().loadHome(),
          ),
        )
      else if (dashboard != null) ...[
        if (state.status == HomeStatus.loading)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: LinearProgressIndicator(minHeight: 2),
            ),
          ),
        ..._buildDashboardSlivers(dashboard),
      ] else
        SliverFillRemaining(
          hasScrollBody: false,
          child: _HomeErrorState(
            failure: state.failure,
            onRetry: () => context.read<HomeCubit>().loadHome(),
          ),
        ),
      SliverToBoxAdapter(child: SizedBox(height: 16 + bottomPadding)),
    ];
  }

  SliverAppBar _buildAppBar(
    BuildContext context, {
    required HomeDashboardEntity? dashboard,
    required bool showNotificationBadge,
  }) {
    final profile = dashboard?.profile;

    return SliverAppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.lightBg,
      pinned: true,
      leading: GestureDetector(
        onTap: () => context.pushNamed(ProfilePage.tag),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: _ProfileAvatar(avatarUrl: profile?.avatarUrl),
        ),
      ),
      title: _HomeProfileTitle(
        displayName: _resolveDisplayName(profile),
        status: _resolveProfileStatus(profile),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(AppAssets.icBell),
                  if (showNotificationBadge)
                    Positioned(
                      right: -2,
                      top: -1,
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
        const SizedBox(width: 16),
      ],
    );
  }

  List<Widget> _buildDashboardSlivers(HomeDashboardEntity dashboard) {
    final isPendingApproval = dashboard.profile.moderationStatus != 'approved';

    return [
      if (isPendingApproval)
        const SliverToBoxAdapter(child: _PendingApprovalBanner()),
      if (isPendingApproval)
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      SliverToBoxAdapter(
        child: Text(t.home.offers_and_messages, style: Typographies.titleLarge),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 16)),
      SliverToBoxAdapter(
        child: Row(
          children: [
            Expanded(
              child: HomePageContainer(
                title: dashboard.activeOffersCount.toString(),
                description: t.common.active_offers,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: HomePageContainer(
                title: dashboard.messagesCount.toString(),
                description: t.common.messages,
                onTap: () => context.pushNamed(MessagesPage.tag),
              ),
            ),
          ],
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 32)),
      SliverToBoxAdapter(
        child: Text(t.common.recommended_for_you, style: Typographies.titleLarge),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 16)),
      if (dashboard.recommendations.isEmpty)
        SliverToBoxAdapter(
          child: _HomeEmptyRecommendations(
            isPendingApproval: isPendingApproval,
          ),
        )
      else
        SliverList.separated(
          itemCount: dashboard.recommendations.length,
          itemBuilder: (context, index) {
            return _RecommendedOfferCard(
              item: dashboard.recommendations[index],
              onTap: () => context.pushNamed(
                OfferDetailPage.tag,
                extra: dashboard.recommendations[index].id,
              ),
            );
          },
          separatorBuilder: (_, _) => const SizedBox(height: 16),
        ),
    ];
  }

  String _resolveDisplayName(dynamic profile) {
    if (profile == null) {
      return 'BrandFace';
    }

    final displayName = profile.displayName?.toString().trim();
    if (displayName != null && displayName.isNotEmpty) {
      return displayName;
    }

    final contacts = profile.contacts;
    if (contacts is List && contacts.isNotEmpty) {
      final firstValue = contacts.first.value?.toString().trim();
      if (firstValue != null && firstValue.isNotEmpty) {
        return firstValue;
      }
    }

    return 'BrandFace';
  }

  _ProfileStatus _resolveProfileStatus(dynamic profile) {
    if (profile == null) {
      return _ProfileStatus.pending;
    }

    if (profile.isVerified == true) {
      return _ProfileStatus.verified;
    }

    final status = profile.moderationStatus?.toString().trim().toLowerCase();
    switch (status) {
      case 'approved':
      case 'verified':
        return _ProfileStatus.verified;
      case 'rejected':
        return _ProfileStatus.rejected;
      case 'blocked':
      case 'banned':
        return _ProfileStatus.blocked;
      case 'pending':
      default:
        return _ProfileStatus.pending;
    }
  }
}

enum _ProfileStatus { verified, pending, rejected, blocked }

class _HomeProfileTitle extends StatelessWidget {
  const _HomeProfileTitle({required this.displayName, required this.status});

  final String displayName;
  final _ProfileStatus status;

  @override
  Widget build(BuildContext context) {
    final config = _statusConfig(status);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Typographies.titleMedium.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(config.icon, size: 16, color: config.color),
            const SizedBox(width: 4),
            Text(
              config.label,
              style: Typographies.bodySmall.copyWith(
                color: const Color(0xFF4A5565),
                letterSpacing: 0.25,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _ProfileStatusConfig _statusConfig(_ProfileStatus status) {
    switch (status) {
      case _ProfileStatus.verified:
        return _ProfileStatusConfig(
          label: 'Verified',
          icon: Icons.verified,
          color: AppColors.primaryDark,
        );
      case _ProfileStatus.rejected:
        return _ProfileStatusConfig(
          label: 'Rejected',
          icon: Icons.cancel,
          color: AppColors.red,
        );
      case _ProfileStatus.blocked:
        return _ProfileStatusConfig(
          label: 'Blocked',
          icon: Icons.block,
          color: AppColors.red,
        );
      case _ProfileStatus.pending:
        return _ProfileStatusConfig(
          label: 'Pending',
          icon: Icons.schedule,
          color: AppColors.orange,
        );
    }
  }
}

class _ProfileStatusConfig {
  const _ProfileStatusConfig({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;
}

class HomePageContainer extends StatelessWidget {
  const HomePageContainer({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
  });

  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.lightBg3,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Typographies.headlineMedium),
            Text(description, style: Typographies.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _ProfileAvatar extends ProfileImage {
  const _ProfileAvatar({String? avatarUrl})
    : super(imageUrl: avatarUrl, size: 40, borderRadius: 999);
}

class _RecommendedOfferCard extends StatelessWidget {
  const _RecommendedOfferCard({required this.item, required this.onTap});

  final RecommendedHomeOfferEntity item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final subtitle = item.brandName?.trim().isNotEmpty == true
        ? item.brandName!.trim()
        : _fallbackDescription(item.description);
    final categories = item.categories.take(3).toList();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.lightBg3,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(item.title, style: Typographies.titleMedium),
                ),
                if (item.score > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      _formatScore(item.score),
                      style: Typographies.labelMedium,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: Typographies.bodySmall.copyWith(
                color: AppColors.mutedBlack,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Divider(color: AppColors.borderColor),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoColumn(
                  label: t.common.deadline,
                  value: _formatDeadline(item.deadline),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: categories.isEmpty
                      ? _InfoColumn(
                          label: t.offer.reward,
                          value: _buildRewardText(item),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.registration.categories,
                              style: Typographies.titleSmall.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: categories
                                  .map(
                                    (category) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightBg2,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        category,
                                        style: Typographies.labelMedium,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                ),
                const SizedBox(width: 12),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _fallbackDescription(String? description) {
    final trimmed = description?.trim();
    if (trimmed != null && trimmed.isNotEmpty) {
      return trimmed;
    }

    return t.home.new_recommendation;
  }

  String _formatDeadline(DateTime? deadline) {
    if (deadline == null) {
      return t.common.open;
    }

    final day = deadline.day.toString().padLeft(2, '0');
    final month = deadline.month.toString().padLeft(2, '0');
    final year = deadline.year.toString();
    return '$day.$month.$year';
  }

  String _buildRewardText(RecommendedHomeOfferEntity item) {
    final amount = item.rewardAmount?.trim();
    final currency = item.rewardCurrency?.trim();
    final reward = item.reward?.trim();

    if (amount != null && amount.isNotEmpty) {
      return [
        amount,
        if (currency != null && currency.isNotEmpty) currency,
      ].join(' ');
    }

    if (reward != null && reward.isNotEmpty) {
      return reward;
    }

    return t.home.flexible_reward;
  }

  String _formatScore(double score) {
    final scoreText = score.truncateToDouble() == score
        ? score.toStringAsFixed(0)
        : score.toStringAsFixed(1);
    return '$scoreText%';
  }
}

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Typographies.titleSmall.copyWith(color: AppColors.grey),
        ),
        const SizedBox(height: 4),
        Text(value, style: Typographies.bodyMedium),
      ],
    );
  }
}

class _HomeEmptyRecommendations extends StatelessWidget {
  const _HomeEmptyRecommendations({required this.isPendingApproval});

  final bool isPendingApproval;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        isPendingApproval
            ? t.home.pending_approval_text
            : t.home.empty_recommendations,
        style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
      ),
    );
  }
}

class _PendingApprovalBanner extends StatelessWidget {
  const _PendingApprovalBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.schedule_rounded, color: AppColors.black),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              t.home.pending_approval_banner,
              style: Typographies.bodyMedium.copyWith(color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeErrorState extends StatelessWidget {
  const _HomeErrorState({required this.failure, required this.onRetry});

  final Failure? failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              failure?.message ?? t.home.error_load,
              style: Typographies.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              t.common.pull_refresh_or_retry,
              style: Typographies.bodyMedium.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                foregroundColor: AppColors.white,
              ),
              child: Text(t.common.try_again),
            ),
          ],
        ),
      ),
    );
  }
}
