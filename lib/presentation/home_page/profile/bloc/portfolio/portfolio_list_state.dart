import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:equatable/equatable.dart';

enum PortfolioListStatus { initial, loading, success, failure }

class PortfolioListState extends Equatable {
  final PortfolioListStatus status;
  final List<PortfolioItemEntity> items;
  final Failure? failure;

  const PortfolioListState({
    this.status = PortfolioListStatus.initial,
    this.items = const [],
    this.failure,
  });

  PortfolioListState copyWith({
    PortfolioListStatus? status,
    List<PortfolioItemEntity>? items,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return PortfolioListState(
      status: status ?? this.status,
      items: items ?? this.items,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, items, failure];
}
