import 'dart:convert';

import 'package:equatable/equatable.dart';

base class PortfolioImageEntity extends Equatable {
  final int id;
  final int imageId;
  final String imageUrl;
  final int order;

  const PortfolioImageEntity({
    required this.id,
    required this.imageId,
    required this.imageUrl,
    required this.order,
  });

  @override
  List<Object?> get props => [id, imageId, imageUrl, order];
}

base class PortfolioItemEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int? coverImageId;
  final String coverImageUrl;
  final String linksRaw;
  final int order;
  final List<PortfolioImageEntity> images;
  final DateTime? createdAt;

  const PortfolioItemEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImageId,
    required this.coverImageUrl,
    required this.linksRaw,
    required this.order,
    required this.images,
    required this.createdAt,
  });

  List<String> get links {
    final raw = linksRaw.trim();
    if (raw.isEmpty) {
      return const [];
    }

    if (raw.startsWith('[') && raw.endsWith(']')) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          return decoded
              .map((item) => item?.toString().trim() ?? '')
              .where((item) => item.isNotEmpty)
              .toList(growable: false);
        }
      } catch (_) {}
    }

    final separator = raw.contains('\n') ? '\n' : ',';
    return raw
        .split(separator)
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }

  String get thumbnailUrl {
    if (coverImageUrl.isNotEmpty) {
      return coverImageUrl;
    }
    if (images.isNotEmpty) {
      return images.first.imageUrl;
    }
    return '';
  }

  String get heroImageUrl => thumbnailUrl;

  List<String> get galleryImageUrls =>
      images.map((image) => image.imageUrl).toList(growable: false);

  PortfolioItemEntity copyWith({
    int? id,
    String? name,
    String? description,
    int? coverImageId,
    String? coverImageUrl,
    String? linksRaw,
    int? order,
    List<PortfolioImageEntity>? images,
    DateTime? createdAt,
  }) {
    return PortfolioItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      coverImageId: coverImageId ?? this.coverImageId,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      linksRaw: linksRaw ?? this.linksRaw,
      order: order ?? this.order,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    coverImageId,
    coverImageUrl,
    linksRaw,
    order,
    images,
    createdAt,
  ];
}

base class UploadedFileEntity extends Equatable {
  final int id;
  final String fileUrl;

  const UploadedFileEntity({required this.id, required this.fileUrl});

  @override
  List<Object?> get props => [id, fileUrl];
}
