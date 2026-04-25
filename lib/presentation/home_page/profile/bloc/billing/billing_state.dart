import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:equatable/equatable.dart';

enum BillingStatus { initial, loading, success, failure }

class BillingState extends Equatable {
  final BillingStatus status;
  final BillingDashboardEntity? dashboard;
  final Failure? failure;
  final bool isMutating;

  const BillingState({
    this.status = BillingStatus.initial,
    this.dashboard,
    this.failure,
    this.isMutating = false,
  });

  BillingState copyWith({
    BillingStatus? status,
    BillingDashboardEntity? dashboard,
    Failure? failure,
    bool clearFailure = false,
    bool? isMutating,
  }) {
    return BillingState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
      failure: clearFailure ? null : failure ?? this.failure,
      isMutating: isMutating ?? this.isMutating,
    );
  }

  @override
  List<Object?> get props => [status, dashboard, failure, isMutating];
}
