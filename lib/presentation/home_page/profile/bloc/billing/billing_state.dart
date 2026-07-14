import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:equatable/equatable.dart';

enum BillingStatus { initial, loading, success, failure }

/// One-shot signal that a Paylov checkout link must be opened in a WebView.
/// The UI listens for it, opens [PaylovWebViewPage], then polls the transaction.
class PaymentRedirect extends Equatable {
  final String paymentUrl;
  final int? transactionId;

  const PaymentRedirect({required this.paymentUrl, this.transactionId});

  @override
  List<Object?> get props => [paymentUrl, transactionId];
}

class BillingState extends Equatable {
  final BillingStatus status;
  final BillingDashboardEntity? dashboard;
  final Failure? failure;
  final bool isMutating;

  /// Set once when a checkout redirect is needed; cleared after the UI reacts.
  final PaymentRedirect? paymentRedirect;

  const BillingState({
    this.status = BillingStatus.initial,
    this.dashboard,
    this.failure,
    this.isMutating = false,
    this.paymentRedirect,
  });

  BillingState copyWith({
    BillingStatus? status,
    BillingDashboardEntity? dashboard,
    Failure? failure,
    bool clearFailure = false,
    bool? isMutating,
    PaymentRedirect? paymentRedirect,
    bool clearPaymentRedirect = false,
  }) {
    return BillingState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
      failure: clearFailure ? null : failure ?? this.failure,
      isMutating: isMutating ?? this.isMutating,
      paymentRedirect: clearPaymentRedirect
          ? null
          : paymentRedirect ?? this.paymentRedirect,
    );
  }

  @override
  List<Object?> get props => [
    status,
    dashboard,
    failure,
    isMutating,
    paymentRedirect,
  ];
}
