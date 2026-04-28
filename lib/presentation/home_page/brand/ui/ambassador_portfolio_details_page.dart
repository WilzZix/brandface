import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

class AmbassadorPortfolioDetailsPage extends StatelessWidget {
  const AmbassadorPortfolioDetailsPage({super.key, required this.item});

  static const String tag = '/ambassador-portfolio-details';

  final PortfolioItemEntity item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.lightBg,
        titleSpacing: 4,
        title: Text('Portfolio details', style: Typographies.titleLarge),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
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
                                    decorationColor: AppColors.primaryDark,
                                    color: AppColors.primaryDark,
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
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (_, i) =>
                              _GalleryImage(imageUrl: item.images[i].imageUrl),
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
        errorBuilder: (_, __, _) => Container(
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
        errorBuilder: (_, __, _) => Container(
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
