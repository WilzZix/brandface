import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/domain/usecase/billing/boost_profile_use_case.dart';
import 'package:brandface/domain/usecase/billing/cancel_subscription_use_case.dart';
import 'package:brandface/domain/usecase/billing/get_billing_dashboard_use_case.dart';
import 'package:brandface/domain/usecase/billing/get_paylov_checkout_use_case.dart';
import 'package:brandface/domain/usecase/billing/subscribe_billing_plan_use_case.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_state.dart';

/// Where Paylov returns the user after a checkout payment. It is never actually
/// loaded — the in-app WebView intercepts navigation to this URL and closes.
const String kPaylovReturnUrl = 'https://brandface.uz/payment/result';

class BillingCubit extends Cubit<BillingState> {
  final GetBillingDashboardUseCase _getBillingDashboardUseCase;
  final CancelSubscriptionUseCase _cancelSubscriptionUseCase;
  final BoostProfileUseCase _boostProfileUseCase;
  final SubscribeBillingPlanUseCase _subscribeBillingPlanUseCase;
  final GetPaylovCheckoutUseCase _getPaylovCheckoutUseCase;

  BillingCubit({
    required GetBillingDashboardUseCase getBillingDashboardUseCase,
    required CancelSubscriptionUseCase cancelSubscriptionUseCase,
    required BoostProfileUseCase boostProfileUseCase,
    required SubscribeBillingPlanUseCase subscribeBillingPlanUseCase,
    required GetPaylovCheckoutUseCase getPaylovCheckoutUseCase,
  }) : _getBillingDashboardUseCase = getBillingDashboardUseCase,
       _cancelSubscriptionUseCase = cancelSubscriptionUseCase,
       _boostProfileUseCase = boostProfileUseCase,
       _subscribeBillingPlanUseCase = subscribeBillingPlanUseCase,
       _getPaylovCheckoutUseCase = getPaylovCheckoutUseCase,
       super(const BillingState());

  Future<void> loadBilling({bool force = false}) async {
    if (!force && state.status == BillingStatus.loading) {
      return;
    }

    emit(state.copyWith(status: BillingStatus.loading, clearFailure: true));

    final result = await _getBillingDashboardUseCase.call(params: null);
    result.fold(
      ifLeft: (failure) =>
          emit(state.copyWith(status: BillingStatus.failure, failure: failure)),
      ifRight: (dashboard) => emit(
        state.copyWith(
          status: BillingStatus.success,
          dashboard: dashboard,
          clearFailure: true,
        ),
      ),
    );
  }

  Future<void> cancelSubscription() async {
    if (state.isMutating) return;
    emit(state.copyWith(isMutating: true, clearFailure: true));
    final result = await _cancelSubscriptionUseCase.call(params: null);
    await result.fold(
      ifLeft: (failure) async =>
          emit(state.copyWith(isMutating: false, failure: failure)),
      ifRight: (_) async {
        await loadBilling(force: true);
        emit(state.copyWith(isMutating: false));
      },
    );
  }

  Future<void> boostProfile(BoostProfileParams params) async {
    if (state.isMutating) return;
    emit(
      state.copyWith(
        isMutating: true,
        clearFailure: true,
        clearPaymentRedirect: true,
      ),
    );
    final result = await _boostProfileUseCase.call(params: params);
    await result.fold(
      ifLeft: (failure) async =>
          emit(state.copyWith(isMutating: false, failure: failure)),
      ifRight: (transaction) async {
        final url = transaction.paymentUrl?.trim();
        if (url != null && url.isNotEmpty && !transaction.isPaid) {
          // Checkout link — user must pay in the WebView.
          emit(
            state.copyWith(
              isMutating: false,
              paymentRedirect: PaymentRedirect(
                paymentUrl: url,
                transactionId: transaction.id,
              ),
            ),
          );
        } else {
          // Saved-card path: charged immediately.
          await loadBilling(force: true);
          emit(state.copyWith(isMutating: false));
        }
      },
    );
  }

  Future<void> subscribeToPlan(SubscribeBillingPlanParams params) async {
    if (state.isMutating) return;
    emit(
      state.copyWith(
        isMutating: true,
        clearFailure: true,
        clearPaymentRedirect: true,
      ),
    );
    final result = await _subscribeBillingPlanUseCase.call(params: params);
    await result.fold(
      ifLeft: (failure) async =>
          emit(state.copyWith(isMutating: false, failure: failure)),
      ifRight: (subscription) async {
        if (subscription.needsCheckout) {
          emit(
            state.copyWith(
              isMutating: false,
              paymentRedirect: PaymentRedirect(
                paymentUrl: subscription.paymentUrl!.trim(),
                transactionId: subscription.transactionId,
              ),
            ),
          );
        } else {
          // Saved-card path: subscription is already active.
          await loadBilling(force: true);
          emit(state.copyWith(isMutating: false));
        }
      },
    );
  }

  /// Re-fetch a checkout link for an existing pending transaction and signal a
  /// redirect. Used to resume an abandoned payment.
  Future<void> retryCheckout(int transactionId) async {
    if (state.isMutating) return;
    emit(
      state.copyWith(
        isMutating: true,
        clearFailure: true,
        clearPaymentRedirect: true,
      ),
    );
    final result = await _getPaylovCheckoutUseCase.call(
      params: PaylovCheckoutParams(
        transactionId: transactionId,
        returnUrl: kPaylovReturnUrl,
      ),
    );
    result.fold(
      ifLeft: (failure) =>
          emit(state.copyWith(isMutating: false, failure: failure)),
      ifRight: (checkout) => emit(
        state.copyWith(
          isMutating: false,
          paymentRedirect: PaymentRedirect(
            paymentUrl: checkout.paymentUrl,
            transactionId: checkout.transactionId,
          ),
        ),
      ),
    );
  }

  /// Clears the one-shot redirect signal once the UI has opened the WebView.
  void consumePaymentRedirect() {
    if (state.paymentRedirect == null) return;
    emit(state.copyWith(clearPaymentRedirect: true));
  }

  /// Polls the transaction after the user returns from the Paylov checkout.
  /// Webhooks land within a few seconds, so poll ~every 2s up to ~30s.
  /// Refreshes the dashboard when the transaction becomes `paid`.
  Future<bool> pollPaymentStatus(int? transactionId) async {
    emit(state.copyWith(isMutating: true, clearFailure: true));
    const attempts = 15;
    const interval = Duration(seconds: 2);

    for (var i = 0; i < attempts; i++) {
      await Future.delayed(interval);
      final result = await _getBillingDashboardUseCase.call(params: null);
      final dashboard = result.orNull();
      if (dashboard == null) continue;

      final paid = transactionId == null
          ? false
          : dashboard.transactions.any(
              (t) => t.id == transactionId && t.isPaid,
            );
      if (paid) {
        emit(
          state.copyWith(
            status: BillingStatus.success,
            dashboard: dashboard,
            isMutating: false,
            clearFailure: true,
          ),
        );
        return true;
      }
    }

    // Timed out still pending — refresh once so the latest state shows.
    await loadBilling(force: true);
    emit(
      state.copyWith(
        isMutating: false,
        failure: const ServerFailure(
          'To\'lov hali tasdiqlanmadi. Biroz keyin tekshiring.',
        ),
      ),
    );
    return false;
  }
}
