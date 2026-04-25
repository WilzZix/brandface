import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';
import 'package:equatable/equatable.dart';

enum OffersFeedStatus { initial, loading, success, failure }

class OffersFeedState extends Equatable {
  final OffersFeedStatus status;
  final List<OfferSummaryEntity> offers;
  final Failure? failure;

  const OffersFeedState({
    this.status = OffersFeedStatus.initial,
    this.offers = const [],
    this.failure,
  });

  OffersFeedState copyWith({
    OffersFeedStatus? status,
    List<OfferSummaryEntity>? offers,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return OffersFeedState(
      status: status ?? this.status,
      offers: offers ?? this.offers,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, offers, failure];
}
