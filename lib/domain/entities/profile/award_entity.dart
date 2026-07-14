import 'package:equatable/equatable.dart';

base class AwardEntity extends Equatable {
  final int id;
  final String title;

  const AwardEntity({required this.id, required this.title});

  @override
  List<Object?> get props => [id, title];
}
