import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/presentation/home_page/profile/bloc/portfolio/portfolio_item_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/portfolio/portfolio_item_state.dart';
import 'package:brandface/presentation/home_page/profile/ui/edit_portfolio_page.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PortfolioDetailsPage extends StatelessWidget {
  const PortfolioDetailsPage({super.key, required this.portfolioId});

  static const String tag = '/portfolio-details';
  final int portfolioId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioItemCubit, PortfolioItemState>(
      builder: (context, state) {
        if (state.status == PortfolioItemStatus.loading ||
            state.status == PortfolioItemStatus.initial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == PortfolioItemStatus.failure || state.item == null) {
          return Scaffold(
            backgroundColor: AppColors.lightBg,
            appBar: AppBar(backgroundColor: AppColors.lightBg),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.failure?.message ??
                          'Portfolio detail ma\'lumotlarini yuklab bo\'lmadi.',
                      style: Typographies.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context
                          .read<PortfolioItemCubit>()
                          .loadPortfolio(portfolioId, force: true),
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final item = state.item!;

        return Scaffold(
          backgroundColor: AppColors.lightBg,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.lightBg,
            titleSpacing: 4,
            title: Text('Portfolio details', style: Typographies.titleLarge),
            actions: [
              IconButton(
                onPressed: () async {
                  final updated = await context.pushNamed(
                    EditPortfolioPage.tag,
                    extra: item.id,
                  );
                  if (context.mounted && updated == true) {
                    await context.read<PortfolioItemCubit>().loadPortfolio(
                      portfolioId,
                      force: true,
                    );
                  }
                },
                icon: SvgPicture.asset(
                  AppAssets.icPen,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryDark,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            top: false,
            child: RefreshIndicator(
              onRefresh: () => context.read<PortfolioItemCubit>().loadPortfolio(
                portfolioId,
                force: true,
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  MediaQuery.of(context).padding.bottom + 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Typographies.titleLarge.copyWith(
                        fontSize: 28,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _HeroImage(imageUrl: item.heroImageUrl),
                    const SizedBox(height: 16),
                    Text('Information', style: Typographies.titleSmall),
                    const SizedBox(height: 8),
                    AppContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: Typographies.titleSmall.copyWith(
                              color: AppColors.mutedBlack,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.description.isEmpty
                                ? 'No description'
                                : item.description,
                            style: Typographies.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Links', style: Typographies.titleSmall),
                    const SizedBox(height: 8),
                    AppContainer(
                      child: item.links.isEmpty
                          ? Text(
                              'No links added.',
                              style: Typographies.bodyMedium.copyWith(
                                color: AppColors.mutedBlack,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: item.links
                                  .map(
                                    (link) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        link,
                                        style: Typographies.bodyMedium.copyWith(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                    const SizedBox(height: 16),
                    Text('Portfolio images', style: Typographies.titleSmall),
                    const SizedBox(height: 8),
                    AppContainer(
                      child: SizedBox(
                        height: 157,
                        child: item.images.isEmpty
                            ? Center(
                                child: Text(
                                  'No images added.',
                                  style: Typographies.bodyMedium.copyWith(
                                    color: AppColors.mutedBlack,
                                  ),
                                ),
                              )
                            : ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: item.images.length,
                                separatorBuilder: (_, _) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  return _GalleryImage(
                                    imageUrl: item.images[index].imageUrl,
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: AppColors.borderColor,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.image_outlined, color: AppColors.grey, size: 32),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        width: double.infinity,
        height: 180,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(
          height: 180,
          color: AppColors.borderColor,
          alignment: Alignment.center,
          child: Icon(Icons.image_outlined, color: AppColors.grey, size: 32),
        ),
      ),
    );
  }
}

class _GalleryImage extends StatelessWidget {
  const _GalleryImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        width: 157,
        height: 157,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(
          width: 157,
          height: 157,
          color: AppColors.borderColor,
          alignment: Alignment.center,
          child: Icon(Icons.image_outlined, color: AppColors.grey),
        ),
      ),
    );
  }
}
