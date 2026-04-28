import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';

abstract class AmbassadorDetailState {}

class AmbassadorDetailInitial extends AmbassadorDetailState {}

class AmbassadorDetailLoading extends AmbassadorDetailState {}

class AmbassadorDetailLoaded extends AmbassadorDetailState {
  final AmbassadorDetailEntity detail;
  AmbassadorDetailLoaded(this.detail);
}

class AmbassadorDetailFailure extends AmbassadorDetailState {
  final String message;
  AmbassadorDetailFailure(this.message);
}
