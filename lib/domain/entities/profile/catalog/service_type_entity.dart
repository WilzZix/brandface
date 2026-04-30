import 'package:equatable/equatable.dart';

class ServiceTypeEntity extends Equatable {
  final int id;
  final String name;
  final String? code;

  const ServiceTypeEntity({
    required this.id,
    required this.name,
    required this.code,
  });

  @override
  List<Object?> get props => [id, name, code];
}
