import 'package:equatable/equatable.dart';

class SphereEntity extends Equatable {
  final int id;
  final String name;

  const SphereEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
