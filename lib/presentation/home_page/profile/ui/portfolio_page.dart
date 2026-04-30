import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/presentation/home_page/profile/bloc/portfolio/portfolio_list_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/portfolio/portfolio_list_state.dart';
import 'package:brandface/presentation/home_page/profile/ui/portfolio_details_page.dart';
import 'package:brandface/uikit/components/ui_components/app_empty_state.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  static const String tag = '/portfolio';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.lightBg,
        titleSpacing: 4,
        title: Text('Portfolio', style: Typographies.titleLarge),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.of(context).padding.bottom + 16,
          ),
          child: BlocBuilder<PortfolioListCubit, PortfolioListState>(
            builder: (context, state) {
              return switch (state.status) {
                PortfolioListStatus.loading || PortfolioListStatus.initial =>
                  const Center(child: CircularProgressIndicator()),
                PortfolioListStatus.failure => _PortfolioFailureView(
                  message:
                      state.failure?.message ??
                      'Portfolio ma\'lumotlarini yuklab bo\'lmadi.',
                  onRetry: () => context
                      .read<PortfolioListCubit>()
                      .loadPortfolios(force: true),
                ),
                PortfolioListStatus.success => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Client reviews',
                      style: Typographies.titleLarge.copyWith(
                        fontSize: 28,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => context
                            .read<PortfolioListCubit>()
                            .loadPortfolios(force: true),
                        child: state.items.isEmpty
                            ? const CustomScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                slivers: [
                                  SliverFillRemaining(
                                    hasScrollBody: false,
                                    child: AppEmptyState(
                                      title: 'No portfolio found',
                                    ),
                                  ),
                                ],
                              )
                            : ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: state.items.length,
                                separatorBuilder: (_, _) =>
                                    const SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  final item = state.items[index];
                                  return _PortfolioCard(
                                    item: item,
                                    onTap: () async {
                                      await context.pushNamed(
                                        PortfolioDetailsPage.tag,
                                        extra: item.id,
                                      );
                                      if (context.mounted) {
                                        await context
                                            .read<PortfolioListCubit>()
                                            .loadPortfolios(force: true);
                                      }
                                    },
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              };
            },
          ),
        ),
      ),
    );
  }
}

class _PortfolioFailureView extends StatelessWidget {
  const _PortfolioFailureView({required this.message, required this.onRetry});

  final String message;
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
              message,
              style: Typographies.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.black,
              ),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({required this.item, required this.onTap});

  final PortfolioItemEntity item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasContent = item.coverImageUrl.isNotEmpty || item.images.isNotEmpty;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.lightBg3,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              _PortfolioImage(
                imageUrl: item.thumbnailUrl,
                width: 88,
                height: 88,
                radius: 12,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 88,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Typographies.titleMedium.copyWith(
                                height: 1.25,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: SvgPicture.asset(
                              AppAssets.icChevronRight,
                              colorFilter: ColorFilter.mode(
                                AppColors.grey,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _PortfolioToggle(isActive: hasContent),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PortfolioToggle extends StatelessWidget {
  const _PortfolioToggle({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 36,
      height: 20,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isActive ? AppColors.primaryDark : AppColors.borderColor,
        ),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryDark : AppColors.borderColor,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}

class _PortfolioImage extends StatelessWidget {
  const _PortfolioImage({
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.radius,
  });

  final String imageUrl;
  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.borderColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.image_outlined, color: AppColors.grey),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(
          width: width,
          height: height,
          color: AppColors.borderColor,
          alignment: Alignment.center,
          child: Icon(Icons.image_outlined, color: AppColors.grey),
        ),
      ),
    );
  }
}
