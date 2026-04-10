import '../../../../domain/entities/profile/catalog/service_type_entity.dart';

class ServiceTypeModel {
  final String? message;
  final List<ServiceTypeData>? data;

  ServiceTypeModel({required this.message, required this.data});

  factory ServiceTypeModel.fromJson(Map<String, dynamic> json) {
    return ServiceTypeModel(
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
                .map((i) => ServiceTypeData.fromJson(i))
                .toList()
          : null,
    );
  }
}

class ServiceTypeData {
  final int id;
  final String name;
  final String code;

  ServiceTypeData({required this.id, required this.name, required this.code});

  factory ServiceTypeData.fromJson(Map<String, dynamic> json) {
    return ServiceTypeData(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }

  ServiceTypeEntity toEntity() {
    return ServiceTypeEntity(id: id, name: name, code: code);
  }
}
