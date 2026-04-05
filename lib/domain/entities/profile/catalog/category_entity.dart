import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String message;
  final List<CategoryItemEntity> categories;

  const CategoryEntity({required this.message, required this.categories});

  @override
  List<Object?> get props => [message, categories];
}

class CategoryItemEntity extends Equatable {
  final int id;
  final String nameUz;
  final String nameRu;
  final String nameEn;
  final int icon;
  final int? parent;

  const CategoryItemEntity({
    required this.id,
    required this.nameUz,
    required this.nameRu,
    required this.nameEn,
    required this.icon,
    this.parent,
  });

  @override
  List<Object?> get props => [id, nameUz, nameRu, nameEn, icon, parent];
}
