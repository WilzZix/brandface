import 'package:brandface/domain/entities/profile/ambassador_entity.dart';

abstract class AmbassadorsState {}

class AmbassadorsInitial extends AmbassadorsState {}

class AmbassadorsLoading extends AmbassadorsState {}

class AmbassadorsLoaded extends AmbassadorsState {
  final List<AmbassadorEntity> ambassadors;
  AmbassadorsLoaded(this.ambassadors);
}

class AmbassadorsFailure extends AmbassadorsState {
  final String message;
  AmbassadorsFailure(this.message);
}
