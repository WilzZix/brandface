import 'package:brandface/domain/entities/profile/catalog/brand_short_entity.dart';

class BrandShortModel {
  final int id;
  final String brandName;

  BrandShortModel({required this.id, required this.brandName});

  factory BrandShortModel.fromJson(Map<String, dynamic> json) {
    return BrandShortModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      brandName:
          (json['brand_name'] ?? json['name'] ?? json['display_name'] ?? '')
              .toString(),
    );
  }

  BrandShortEntity toEntity() =>
      BrandShortEntity(id: id, brandName: brandName);
}
