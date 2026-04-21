import '../../../../domain/entities/profile/catalog/category_entity.dart';

class CategoryModel {
  final String? message;
  final List<CategoryData>? data;

  CategoryModel({this.message, this.data});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => CategoryData.fromJson(i)).toList()
          : null,
    );
  }
}

class CategoryData {
  final int? id;
  final String? name;
  final int? icon;
  final int? parent;

  CategoryData({this.id, this.name, this.icon, this.parent});

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      parent: json['parent'],
    );
  }

  CategoryItemEntity toEntity() {
    return CategoryItemEntity(
      id: id ?? 0,
      name: name ?? '',
      icon: icon ?? 0,
      parent: parent,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon': icon, 'parent': parent};
  }
}
