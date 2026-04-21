import 'package:brandface/domain/entities/profile/catalog/region_entity.dart';

class RegionModel extends RegionEntity {
  const RegionModel({
    required super.id,
    required super.name,
    required super.code,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(id: json['id'], name: json['name'], code: json['code']);
  }

  RegionEntity toEntity() {
    return RegionEntity(id: id, name: name, code: code);
  }
}
