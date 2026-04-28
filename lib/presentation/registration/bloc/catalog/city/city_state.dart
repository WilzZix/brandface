import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/city_entity.dart';

abstract class CityState {}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  final List<CityEntity> data;
  CityLoaded(this.data);
}

class CityFailure extends CityState {
  final Failure failure;
  CityFailure(this.failure);
}
