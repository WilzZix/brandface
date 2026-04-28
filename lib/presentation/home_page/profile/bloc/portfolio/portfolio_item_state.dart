import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:equatable/equatable.dart';

enum PortfolioItemStatus { initial, loading, ready, saving, failure }

class PortfolioItemState extends Equatable {
  final PortfolioItemStatus status;
  final PortfolioItemEntity? item;
  final Failure? failure;

  const PortfolioItemState({
    this.status = PortfolioItemStatus.initial,
    this.item,
    this.failure,
  });

  PortfolioItemState copyWith({
    PortfolioItemStatus? status,
    PortfolioItemEntity? item,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return PortfolioItemState(
      status: status ?? this.status,
      item: item ?? this.item,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, item, failure];
}
