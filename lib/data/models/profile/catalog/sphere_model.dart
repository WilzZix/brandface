import 'package:brandface/domain/entities/profile/catalog/sphere_entity.dart';

class SphereModel extends SphereEntity {
  const SphereModel({required super.id, required super.name});

  factory SphereModel.fromJson(Map<String, dynamic> json) =>
      SphereModel(id: json['id'] ?? 0, name: json['name'] ?? '');

  SphereEntity toEntity() => SphereEntity(id: id, name: name);
}
