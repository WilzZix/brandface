import 'package:equatable/equatable.dart';

base class CategoryItemEntity extends Equatable {
  final int id;
  final String name;

  final int icon;
  final int? parent;

  const CategoryItemEntity({
    required this.id,
    required this.name,

    required this.icon,
    this.parent,
  });

  @override
  List<Object?> get props => [id, name, icon, parent];
}
