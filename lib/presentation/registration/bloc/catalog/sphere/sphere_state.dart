import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/sphere_entity.dart';

abstract class SphereState {}

class SphereInitial extends SphereState {}

class SphereLoading extends SphereState {}

class SphereLoaded extends SphereState {
  final List<SphereEntity> data;
  SphereLoaded(this.data);
}

class SphereFailure extends SphereState {
  final Failure failure;
  SphereFailure(this.failure);
}
