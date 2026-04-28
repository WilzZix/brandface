import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_state.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_state.dart';
import 'package:brandface/presentation/home_page/brand/ui/ambassador_portfolio_details_page.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AmbassadorDetailsPage extends StatelessWidget {
  const AmbassadorDetailsPage({super.key, required this.ambassadorId});

  static const String tag = '/ambassador-details';

  final int ambassadorId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmbassadorDetailCubit, AmbassadorDetailState>(
      builder: (context, state) {
        if (state is AmbassadorDetailLoading ||
            state is AmbassadorDetailInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is AmbassadorDetailFailure) {
          return Scaffold(
            backgroundColor: AppColors.lightBg,
            appBar: AppBar(backgroundColor: AppColors.lightBg),
            body: Center(
              child: Text(state.message, style: Typographies.bodyMedium),
            ),
          );
        }
        final detail = (state as AmbassadorDetailLoaded).detail;
        return _DetailsScaffold(detail: detail);
      },
    );
  }
}

class _DetailsScaffold extends StatelessWidget {
  const _DetailsScaffold({required this.detail});

  final AmbassadorDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.lightBg,
        appBar: AppBar(
          backgroundColor: AppColors.lightBg,
          scrolledUnderElevation: 0,
          title: Text('Ambassador details', style: Typographies.titleMedium),
          centerTitle: false,
          bottom: TabBar(
            labelStyle: Typographies.labelLarge,
            unselectedLabelStyle: Typographies.bodyMedium,
            indicatorColor: AppColors.primaryDark,
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.grey,
            tabs: const [
              Tab(text: 'Information'),
              Tab(text: 'Portfolio'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _InformationTab(detail: detail),
            _PortfolioTab(ambassadorId: detail.id),
          ],
        ),
      ),
    );
  }
}

class _InformationTab extends StatelessWidget {
  const _InformationTab({required this.detail});

  final AmbassadorDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeroAvatar(avatarUrl: detail.avatarUrl),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  detail.displayName ?? '—',
                  style: Typographies.titleLarge,
                ),
              ),
              if (detail.isVerified) ...[
                const SizedBox(width: 6),
                Icon(
                  Icons.check_circle,
                  color: AppColors.primaryDark,
                  size: 22,
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: detail.averageRating != null
                    ? AppColors.orange
                    : AppColors.grey,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                detail.averageRating != null
                    ? detail.averageRating!.toStringAsFixed(2)
                    : '—',
                style: Typographies.bodyMedium.copyWith(
                  color: AppColors.mutedBlack,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${detail.totalReviews} reviews',
                style:
                    Typographies.bodySmall.copyWith(color: AppColors.grey),
              ),
            ],
          ),
          if (detail.bio != null && detail.bio!.isNotEmpty) ...[
            const SizedBox(height: 16),
            AppContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bio',
                    style: Typographies.titleSmall.copyWith(
                      color: AppColors.mutedBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(detail.bio!, style: Typographies.bodyMedium),
                ],
              ),
            ),
          ],
          if (detail.categories.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Categories', style: Typographies.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: detail.categories.map((c) => _Chip(label: c)).toList(),
            ),
          ],
          if (detail.services.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Services', style: Typographies.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: detail.services.map((s) => _Chip(label: s)).toList(),
            ),
          ],
          if (detail.languages.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Languages', style: Typographies.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children:
                  detail.languages.map((l) => _Chip(label: l)).toList(),
            ),
          ],
          if (detail.regionName != null || detail.cityName != null) ...[
            const SizedBox(height: 16),
            AppContainer(
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.grey,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    [detail.cityName, detail.regionName]
                        .whereType<String>()
                        .join(', '),
                    style: Typographies.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PortfolioTab extends StatelessWidget {
  const _PortfolioTab({required this.ambassadorId});

  final int ambassadorId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmbassadorPortfolioCubit, AmbassadorPortfolioState>(
      builder: (context, state) {
        if (state is AmbassadorPortfolioLoading ||
            state is AmbassadorPortfolioInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AmbassadorPortfolioFailure) {
          return Center(
            child: Text(state.message, style: Typographies.bodyMedium),
          );
        }
        if (state is AmbassadorPortfolioLoaded) {
          if (state.items.isEmpty) {
            return Center(
              child: Text(
                'No portfolio items.',
                style: Typographies.bodyMedium.copyWith(
                  color: AppColors.grey,
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            itemCount: state.items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _PortfolioCard(
              item: state.items[index],
              onTap: () => context.pushNamed(
                AmbassadorPortfolioDetailsPage.tag,
                extra: state.items[index],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({required this.item, required this.onTap});

  final PortfolioItemEntity item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightBg3,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.thumbnailUrl.isNotEmpty)
              Image.network(
                item.thumbnailUrl,
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (_, __, _) => Container(
                  height: 160,
                  color: AppColors.borderColor,
                  alignment: Alignment.center,
                  child: Icon(Icons.image_outlined, color: AppColors.grey),
                ),
              )
            else
              Container(
                height: 160,
                color: AppColors.borderColor,
                alignment: Alignment.center,
                child: Icon(
                  Icons.image_outlined,
                  color: AppColors.grey,
                  size: 32,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(item.name, style: Typographies.titleSmall),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroAvatar extends StatelessWidget {
  const _HeroAvatar({required this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl == null || avatarUrl!.isEmpty) {
      return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.borderColor,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.person, color: AppColors.grey, size: 64),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        avatarUrl!,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (_, __, _) => Container(
          height: 200,
          color: AppColors.borderColor,
          alignment: Alignment.center,
          child: Icon(Icons.person, color: AppColors.grey, size: 64),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: Typographies.bodySmall),
    );
  }
}
