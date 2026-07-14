import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';

final class PortfolioModel extends PortfolioItemEntity {
  const PortfolioModel({
    required super.id,
    required super.name,
    required super.description,
    required super.coverImageId,
    required super.coverImageUrl,
    required super.linksRaw,
    required super.order,
    required super.images,
    required super.createdAt,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    final imagesData = json['images'] as List? ?? const [];
    return PortfolioModel(
      id: _readInt(json['id']),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      coverImageId: json['cover_image'] is int
          ? json['cover_image'] as int
          : null,
      coverImageUrl: _absoluteUrl(json['cover_image_url']?.toString() ?? ''),
      linksRaw: json['links']?.toString() ?? '',
      order: _readInt(json['order']),
      images: imagesData
          .map(
            (item) => PortfolioImageModel.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(growable: false),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }

  static int _readInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    if (value is double) {
      return value.round();
    }
    return 0;
  }

  static String _absoluteUrl(String url) {
    if (url.isEmpty || url.startsWith('http')) {
      return url;
    }
    final base = ApiRoutes.baseUrl.replaceFirst('/api/', '');
    return '$base$url';
  }
}

final class PortfolioImageModel extends PortfolioImageEntity {
  const PortfolioImageModel({
    required super.id,
    required super.imageId,
    required super.imageUrl,
    required super.order,
  });

  factory PortfolioImageModel.fromJson(Map<String, dynamic> json) {
    return PortfolioImageModel(
      id: PortfolioModel._readInt(json['id']),
      imageId: PortfolioModel._readInt(json['image']),
      imageUrl: PortfolioModel._absoluteUrl(
        json['image_url']?.toString() ?? '',
      ),
      order: PortfolioModel._readInt(json['order']),
    );
  }
}

final class UploadedFileModel extends UploadedFileEntity {
  const UploadedFileModel({required super.id, required super.fileUrl});

  factory UploadedFileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json['data'] is Map
        ? Map<String, dynamic>.from(json['data'] as Map)
        : json;

    return UploadedFileModel(
      id: PortfolioModel._readInt(data['id']),
      fileUrl: PortfolioModel._absoluteUrl(data['file']?.toString() ?? ''),
    );
  }
}
