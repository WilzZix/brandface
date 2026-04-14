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
  final String? nameUz;
  final String? nameRu;
  final String? nameEn;
  final int? icon;
  final int? parent;

  CategoryData({
    this.id,
    this.nameUz,
    this.nameRu,
    this.nameEn,
    this.icon,
    this.parent,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'],
      nameUz: json['name'],
      nameRu: json['name_ru'],
      nameEn: json['name_en'],
      icon: json['icon'],
      parent: json['parent'],
    );
  }

  CategoryItemEntity toEntity() {
    return CategoryItemEntity(
      id: id ?? 0,
      nameUz: nameUz ?? '',
      nameRu: nameRu ?? '',
      nameEn: nameEn ?? '',
      icon: icon ?? 0,
      parent: parent,
    );
  }
}
