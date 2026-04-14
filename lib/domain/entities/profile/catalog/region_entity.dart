import 'package:equatable/equatable.dart';

class RegionEntity extends Equatable {
  final int id;
  final String name;
  final String code;

  const RegionEntity({
    required this.id,
    required this.name,
    required this.code,
  });

  @override
  List<Object?> get props => [id, name, code];
}
