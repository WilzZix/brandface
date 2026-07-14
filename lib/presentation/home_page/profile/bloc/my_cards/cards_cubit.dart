import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../domain/entities/billing/billing_entities.dart';
import '../../../../../domain/repository/billing_repository.dart';
import '../../../../../domain/usecase/billing/confirm_billing_card_use_case.dart';
import '../../../../../domain/usecase/billing/delete_billing_card_use_case.dart';
import '../../../../../domain/usecase/billing/get_billing_cards_use_case.dart';
import '../../../../../domain/usecase/billing/init_billing_card_use_case.dart';
import '../../../../../domain/usecase/billing/set_default_billing_card_use_case.dart';

part 'cards_state.dart';

/// Owns everything about saved cards: the list, the two-step OTP add flow,
/// and set-default / delete. Cards were previously part of the billing
/// dashboard; they now live here as the single source of truth.
class CardsCubit extends Cubit<CardsState> {
  final GetBillingCardsUseCase _getBillingCardsUseCase;
  final InitBillingCardUseCase _initBillingCardUseCase;
  final ConfirmBillingCardUseCase _confirmBillingCardUseCase;
  final SetDefaultBillingCardUseCase _setDefaultBillingCardUseCase;
  final DeleteBillingCardUseCase _deleteBillingCardUseCase;

  CardsCubit({
    required GetBillingCardsUseCase getBillingCardsUseCase,
    required InitBillingCardUseCase initBillingCardUseCase,
    required ConfirmBillingCardUseCase confirmBillingCardUseCase,
    required SetDefaultBillingCardUseCase setDefaultBillingCardUseCase,
    required DeleteBillingCardUseCase deleteBillingCardUseCase,
  }) : _getBillingCardsUseCase = getBillingCardsUseCase,
       _initBillingCardUseCase = initBillingCardUseCase,
       _confirmBillingCardUseCase = confirmBillingCardUseCase,
       _setDefaultBillingCardUseCase = setDefaultBillingCardUseCase,
       _deleteBillingCardUseCase = deleteBillingCardUseCase,
       super(const CardsState());

  Future<void> loadCards({bool force = false}) async {
    if (!force && state.status == CardsStatus.loading) return;
    emit(state.copyWith(status: CardsStatus.loading, clearFailure: true));

    final result = await _getBillingCardsUseCase.call(params: null);
    result.fold(
      ifLeft: (failure) =>
          emit(state.copyWith(status: CardsStatus.failure, failure: failure)),
      ifRight: (cards) => emit(
        state.copyWith(
          status: CardsStatus.success,
          cards: cards,
          clearFailure: true,
        ),
      ),
    );
  }

  /// Step 1: submit card details and trigger the OTP.
  ///
  /// Returns `true` when the OTP was sent (caller navigates to the OTP screen);
  /// `false` when it failed (read [CardsState.addFailure] for the message).
  Future<bool> startAddCard(InitBillingCardParams params) async {
    if (state.addStage == AddCardStage.initializing ||
        state.addStage == AddCardStage.confirming) {
      return false;
    }
    emit(
      state.copyWith(
        addStage: AddCardStage.initializing,
        clearAddFailure: true,
        clearPendingCard: true,
      ),
    );

    final result = await _initBillingCardUseCase.call(params: params);
    return result.fold(
      ifLeft: (failure) {
        emit(state.copyWith(addStage: AddCardStage.idle, addFailure: failure));
        return false;
      },
      ifRight: (init) {
        emit(
          state.copyWith(
            addStage: AddCardStage.otpSent,
            pendingCardId: init.cardId,
            pendingCardName: params.cardName,
            otpSentPhone: init.otpSentPhone,
            clearAddFailure: true,
          ),
        );
        return true;
      },
    );
  }

  /// Re-request the OTP for the same card (resend). Keeps the OTP screen open.
  Future<void> resendOtp(InitBillingCardParams params) async {
    if (state.addStage == AddCardStage.confirming) return;
    emit(state.copyWith(addStage: AddCardStage.initializing, clearAddFailure: true));

    final result = await _initBillingCardUseCase.call(params: params);
    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(addStage: AddCardStage.otpSent, addFailure: failure),
      ),
      ifRight: (init) => emit(
        state.copyWith(
          addStage: AddCardStage.otpSent,
          pendingCardId: init.cardId,
          otpSentPhone: init.otpSentPhone,
          clearAddFailure: true,
        ),
      ),
    );
  }

  /// Step 2: confirm the OTP. On success the card is saved and the list reloads;
  /// the add flow resets to idle. On failure stays on [AddCardStage.otpSent].
  Future<void> confirmOtp({required String otp, bool isDefault = false}) async {
    final cardId = state.pendingCardId;
    if (cardId == null || state.addStage == AddCardStage.confirming) return;

    emit(state.copyWith(addStage: AddCardStage.confirming, clearAddFailure: true));

    final result = await _confirmBillingCardUseCase.call(
      params: ConfirmBillingCardParams(
        cardId: cardId,
        otp: otp,
        cardName: state.pendingCardName ?? '',
        isDefault: isDefault,
      ),
    );
    await result.fold(
      ifLeft: (failure) async => emit(
        state.copyWith(addStage: AddCardStage.otpSent, addFailure: failure),
      ),
      ifRight: (_) async {
        emit(
          state.copyWith(
            addStage: AddCardStage.idle,
            clearPendingCard: true,
            clearAddFailure: true,
          ),
        );
        await loadCards(force: true);
      },
    );
  }

  /// Abandon an in-progress add flow (e.g. user leaves the OTP screen).
  void cancelAddCard() {
    emit(
      state.copyWith(
        addStage: AddCardStage.idle,
        clearPendingCard: true,
        clearAddFailure: true,
      ),
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
        await loadCards(force: true);
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
        await loadCards(force: true);
        emit(state.copyWith(isMutating: false));
      },
    );
  }
}
