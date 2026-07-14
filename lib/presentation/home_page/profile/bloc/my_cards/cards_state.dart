part of 'cards_cubit.dart';

/// Loading state of the cards list.
enum CardsStatus { initial, loading, success, failure }

/// The two-step OTP add-card flow.
///  idle          → no add in progress
///  initializing  → step 1 in flight (POST /cards/)
///  otpSent       → OTP delivered, waiting for confirmation
///  confirming    → step 2 in flight (POST /cards/confirm/)
enum AddCardStage { idle, initializing, otpSent, confirming }

class CardsState extends Equatable {
  final CardsStatus status;
  final List<BillingCardEntity> cards;

  /// List-load failure (whole-screen error with retry).
  final Failure? failure;

  /// A set-default / delete operation is in flight.
  final bool isMutating;

  // ── Add-card (OTP) sub-flow ────────────────────────────────────────────
  final AddCardStage addStage;

  /// Transient Paylov card id (UUID) returned by step 1.
  final String? pendingCardId;

  /// Card holder name captured on the form — required by the confirm step.
  final String? pendingCardName;

  /// Masked phone the OTP was sent to (e.g. `********1234`).
  final String? otpSentPhone;

  /// Failure surfaced on the add-card form / OTP screen (init or confirm).
  final Failure? addFailure;

  const CardsState({
    this.status = CardsStatus.initial,
    this.cards = const [],
    this.failure,
    this.isMutating = false,
    this.addStage = AddCardStage.idle,
    this.pendingCardId,
    this.pendingCardName,
    this.otpSentPhone,
    this.addFailure,
  });

  /// Default card (explicit default, else first), or null when there are none.
  BillingCardEntity? get defaultCard {
    for (final card in cards) {
      if (card.isDefault) return card;
    }
    return cards.isEmpty ? null : cards.first;
  }

  bool get hasCards => cards.isNotEmpty;

  CardsState copyWith({
    CardsStatus? status,
    List<BillingCardEntity>? cards,
    Failure? failure,
    bool clearFailure = false,
    bool? isMutating,
    AddCardStage? addStage,
    String? pendingCardId,
    String? pendingCardName,
    bool clearPendingCard = false,
    String? otpSentPhone,
    Failure? addFailure,
    bool clearAddFailure = false,
  }) {
    return CardsState(
      status: status ?? this.status,
      cards: cards ?? this.cards,
      failure: clearFailure ? null : failure ?? this.failure,
      isMutating: isMutating ?? this.isMutating,
      addStage: addStage ?? this.addStage,
      pendingCardId: clearPendingCard
          ? null
          : pendingCardId ?? this.pendingCardId,
      pendingCardName: clearPendingCard
          ? null
          : pendingCardName ?? this.pendingCardName,
      otpSentPhone: clearPendingCard
          ? null
          : otpSentPhone ?? this.otpSentPhone,
      addFailure: clearAddFailure ? null : addFailure ?? this.addFailure,
    );
  }

  @override
  List<Object?> get props => [
    status,
    cards,
    failure,
    isMutating,
    addStage,
    pendingCardId,
    pendingCardName,
    otpSentPhone,
    addFailure,
  ];
}
