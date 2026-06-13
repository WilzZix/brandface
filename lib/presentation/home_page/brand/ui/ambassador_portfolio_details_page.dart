import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

class AmbassadorPortfolioDetailsPage extends StatelessWidget {
  const AmbassadorPortfolioDetailsPage({super.key, required this.item});

  static const String tag = '/ambassador-portfolio-details';

  final PortfolioItemEntity item;

  List<String> _allImageUrls() {
    final urls = <String>[];
    if (item.heroImageUrl.isNotEmpty) {
      urls.add(item.heroImageUrl);
    }
    for (final img in item.images) {
      if (img.imageUrl.isNotEmpty) {
        urls.add(img.imageUrl);
      }
    }
    return urls;
  }

  void _openZoom(BuildContext context, int initialIndex) {
    final urls = _allImageUrls();
    if (urls.isEmpty) return;
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withValues(alpha: 0.9),
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (_, _, _) =>
            _ImageZoomViewer(urls: urls, initialIndex: initialIndex),
        transitionsBuilder: (_, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

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
                style: Typographies.titleMedium,
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => _openZoom(context, 0),
                child: _HeroImage(imageUrl: item.heroImageUrl),
              ),
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
                                    color: AppColors.black,
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
                          separatorBuilder: (c, i) =>
                              const SizedBox(width: 12),
                          itemBuilder: (_, i) => GestureDetector(
                            onTap: () {
                              // hero is at index 0 if present
                              final offset =
                                  item.heroImageUrl.isNotEmpty ? 1 : 0;
                              _openZoom(context, i + offset);
                            },
                            child: _GalleryImage(
                              imageUrl: item.images[i].imageUrl,
                            ),
                          ),
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
        errorBuilder: (ctx, err, st) => Container(
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
        errorBuilder: (ctx, err, st) => Container(
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

class _ImageZoomViewer extends StatefulWidget {
  const _ImageZoomViewer({required this.urls, required this.initialIndex});

  final List<String> urls;
  final int initialIndex;

  @override
  State<_ImageZoomViewer> createState() => _ImageZoomViewerState();
}

class _ImageZoomViewerState extends State<_ImageZoomViewer> {
  late final PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.urls.length - 1);
    _controller = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onVerticalDragEnd: (details) {
              if ((details.primaryVelocity ?? 0).abs() > 300) {
                Navigator.of(context).maybePop();
              }
            },
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.urls.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (_, i) => Center(
                child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Image.network(
                    widget.urls[i],
                    fit: BoxFit.contain,
                    errorBuilder: (ctx, err, st) => Container(
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_outlined,
                        color: Colors.white54,
                        size: 64,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          if (widget.urls.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).padding.bottom + 32,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${_currentIndex + 1}/${widget.urls.length}',
                    style: Typographies.bodyMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
