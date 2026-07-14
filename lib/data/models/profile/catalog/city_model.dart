import 'package:brandface/domain/entities/profile/catalog/city_entity.dart';

final class CityModel extends CityEntity {
  const CityModel({required super.id, required super.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  CityEntity toEntity() => CityEntity(id: id, name: name);
}
