import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/offer/offer_detail_entity.dart';
import 'package:equatable/equatable.dart';

enum OfferDetailStatus { initial, loading, success, failure }

class OfferDetailState extends Equatable {
  final OfferDetailStatus status;
  final OfferDetailEntity? offer;
  final Failure? failure;
  final bool isApplying;
  final bool isApplied;

  const OfferDetailState({
    this.status = OfferDetailStatus.initial,
    this.offer,
    this.failure,
    this.isApplying = false,
    this.isApplied = false,
  });

  OfferDetailState copyWith({
    OfferDetailStatus? status,
    OfferDetailEntity? offer,
    Failure? failure,
    bool clearFailure = false,
    bool? isApplying,
    bool? isApplied,
  }) {
    return OfferDetailState(
      status: status ?? this.status,
      offer: offer ?? this.offer,
      failure: clearFailure ? null : failure ?? this.failure,
      isApplying: isApplying ?? this.isApplying,
      isApplied: isApplied ?? this.isApplied,
    );
  }

  @override
  List<Object?> get props => [status, offer, failure, isApplying, isApplied];
}
