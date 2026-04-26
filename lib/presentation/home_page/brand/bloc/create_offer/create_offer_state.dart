enum CreateOfferStatus { idle, loading, success, failure }

class CreateOfferState {
  final CreateOfferStatus status;
  final String? errorMessage;

  const CreateOfferState({
    this.status = CreateOfferStatus.idle,
    this.errorMessage,
  });

  CreateOfferState copyWith({
    CreateOfferStatus? status,
    String? errorMessage,
  }) {
    return CreateOfferState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
