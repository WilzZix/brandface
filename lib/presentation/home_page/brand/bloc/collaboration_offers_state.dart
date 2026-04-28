import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';

abstract class CollaborationOffersState {}

class CollaborationOffersInitial extends CollaborationOffersState {}

class CollaborationOffersLoading extends CollaborationOffersState {}

class CollaborationOffersLoaded extends CollaborationOffersState {
  final List<OfferSummaryEntity> offers;
  CollaborationOffersLoaded(this.offers);
}

class CollaborationOffersFailure extends CollaborationOffersState {
  final String message;
  CollaborationOffersFailure(this.message);
}
