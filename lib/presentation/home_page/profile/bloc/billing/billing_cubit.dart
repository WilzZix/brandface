import 'package:bloc/bloc.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/domain/usecase/billing/add_billing_card_use_case.dart';
import 'package:brandface/domain/usecase/billing/boost_profile_use_case.dart';
import 'package:brandface/domain/usecase/billing/cancel_subscription_use_case.dart';
import 'package:brandface/domain/usecase/billing/delete_billing_card_use_case.dart';
import 'package:brandface/domain/usecase/billing/get_billing_dashboard_use_case.dart';
import 'package:brandface/domain/usecase/billing/set_default_billing_card_use_case.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_state.dart';

class BillingCubit extends Cubit<BillingState> {
  final GetBillingDashboardUseCase _getBillingDashboardUseCase;
  final AddBillingCardUseCase _addBillingCardUseCase;
  final SetDefaultBillingCardUseCase _setDefaultBillingCardUseCase;
  final DeleteBillingCardUseCase _deleteBillingCardUseCase;
  final CancelSubscriptionUseCase _cancelSubscriptionUseCase;
  final BoostProfileUseCase _boostProfileUseCase;

  BillingCubit({
    required GetBillingDashboardUseCase getBillingDashboardUseCase,
    required AddBillingCardUseCase addBillingCardUseCase,
    required SetDefaultBillingCardUseCase setDefaultBillingCardUseCase,
    required DeleteBillingCardUseCase deleteBillingCardUseCase,
    required CancelSubscriptionUseCase cancelSubscriptionUseCase,
    required BoostProfileUseCase boostProfileUseCase,
  }) : _getBillingDashboardUseCase = getBillingDashboardUseCase,
       _addBillingCardUseCase = addBillingCardUseCase,
       _setDefaultBillingCardUseCase = setDefaultBillingCardUseCase,
       _deleteBillingCardUseCase = deleteBillingCardUseCase,
       _cancelSubscriptionUseCase = cancelSubscriptionUseCase,
       _boostProfileUseCase = boostProfileUseCase,
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

  Future<void> addCard(AddBillingCardParams params) async {
    if (state.isMutating) return;
    emit(state.copyWith(isMutating: true, clearFailure: true));
    final result = await _addBillingCardUseCase.call(params: params);
    await result.fold(
      ifLeft: (failure) async =>
          emit(state.copyWith(isMutating: false, failure: failure)),
      ifRight: (_) async {
        await loadBilling(force: true);
        emit(state.copyWith(isMutating: false));
      },
    );
  }

  Future<void> setDefaultCard(int cardId) async {
    if (state.isMutating) return;
    emit(state.copyWith(isMutating: true, clearFailure: true));
    final result = await _setDefaultBillingCardUseCase.call(params: cardId);
    await result.fold(
      ifLeft: (failure) async =>
          emit(state.copyWith(isMutating: false, failure: failure)),
      ifRight: (_) async {
        await loadBilling(force: true);
        emit(state.copyWith(isMutating: false));
      },
    );
  }

  Future<void> deleteCard(int cardId) async {
    if (state.isMutating) return;
    emit(state.copyWith(isMutating: true, clearFailure: true));
    final result = await _deleteBillingCardUseCase.call(params: cardId);
    await result.fold(
      ifLeft: (failure) async =>
          emit(state.copyWith(isMutating: false, failure: failure)),
      ifRight: (_) async {
        await loadBilling(force: true);
        emit(state.copyWith(isMutating: false));
      },
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
    emit(state.copyWith(isMutating: true, clearFailure: true));
    final result = await _boostProfileUseCase.call(params: params);
    await result.fold(
      ifLeft: (failure) async =>
          emit(state.copyWith(isMutating: false, failure: failure)),
      ifRight: (_) async {
        await loadBilling(force: true);
        emit(state.copyWith(isMutating: false));
      },
    );
  }
}
