import 'package:flutter/foundation.dart';

class PortfolioItem {
  const PortfolioItem({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.heroImageUrl,
    required this.galleryImageUrls,
    required this.links,
    required this.description,
    required this.isActive,
  });

  final int id;
  final String title;
  final String thumbnailUrl;
  final String heroImageUrl;
  final List<String> galleryImageUrls;
  final List<String> links;
  final String description;
  final bool isActive;

  PortfolioItem copyWith({
    int? id,
    String? title,
    String? thumbnailUrl,
    String? heroImageUrl,
    List<String>? galleryImageUrls,
    List<String>? links,
    String? description,
    bool? isActive,
  }) {
    return PortfolioItem(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      heroImageUrl: heroImageUrl ?? this.heroImageUrl,
      galleryImageUrls: galleryImageUrls ?? this.galleryImageUrls,
      links: links ?? this.links,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }
}

class PortfolioStore {
  PortfolioStore._();

  static final ValueNotifier<List<PortfolioItem>>
  items = ValueNotifier<List<PortfolioItem>>([
    const PortfolioItem(
      id: 1,
      title: 'Product campaign for tech brand',
      thumbnailUrl:
          'https://picsum.photos/seed/brandface-portfolio-thumb-1/300/300',
      heroImageUrl:
          'https://picsum.photos/seed/brandface-portfolio-hero-1/1000/600',
      galleryImageUrls: [
        'https://picsum.photos/seed/brandface-portfolio-gallery-1/400/400',
        'https://picsum.photos/seed/brandface-portfolio-gallery-2/400/400',
        'https://picsum.photos/seed/brandface-portfolio-gallery-3/400/400',
      ],
      links: ['Link1', 'Link1', 'Link1'],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip.',
      isActive: true,
    ),
    const PortfolioItem(
      id: 2,
      title: 'UGC set for beauty launch',
      thumbnailUrl:
          'https://picsum.photos/seed/brandface-portfolio-thumb-2/300/300',
      heroImageUrl:
          'https://picsum.photos/seed/brandface-portfolio-hero-2/1000/600',
      galleryImageUrls: [
        'https://picsum.photos/seed/brandface-portfolio-gallery-4/400/400',
        'https://picsum.photos/seed/brandface-portfolio-gallery-5/400/400',
        'https://picsum.photos/seed/brandface-portfolio-gallery-6/400/400',
      ],
      links: ['Link.com'],
      description:
          'A short portfolio case that highlights product storytelling, studio shooting, and distribution-ready edits.',
      isActive: false,
    ),
    const PortfolioItem(
      id: 3,
      title: 'Lifestyle storytelling series',
      thumbnailUrl:
          'https://picsum.photos/seed/brandface-portfolio-thumb-3/300/300',
      heroImageUrl:
          'https://picsum.photos/seed/brandface-portfolio-hero-3/1000/600',
      galleryImageUrls: [
        'https://picsum.photos/seed/brandface-portfolio-gallery-7/400/400',
        'https://picsum.photos/seed/brandface-portfolio-gallery-8/400/400',
        'https://picsum.photos/seed/brandface-portfolio-gallery-9/400/400',
      ],
      links: ['Link.com', 'Behance'],
      description:
          'This portfolio entry showcases a warm, lifestyle-oriented content package with short-form edits and supporting stills.',
      isActive: true,
    ),
  ]);

  static PortfolioItem byId(int id) {
    return items.value.firstWhere(
      (item) => item.id == id,
      orElse: () => items.value.first,
    );
  }

  static void toggle(int id, bool isActive) {
    items.value = items.value
        .map((item) => item.id == id ? item.copyWith(isActive: isActive) : item)
        .toList(growable: false);
  }

  static void update(PortfolioItem updatedItem) {
    items.value = items.value
        .map((item) => item.id == updatedItem.id ? updatedItem : item)
        .toList(growable: false);
  }
}
