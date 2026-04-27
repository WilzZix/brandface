import 'package:brandface/domain/entities/ai_matching/ai_match_result_entity.dart';

abstract class AiMatchingState {}

class AiMatchingInitial extends AiMatchingState {}

class AiMatchingLoading extends AiMatchingState {}

class AiMatchingRunning extends AiMatchingState {
  final int offerId;
  AiMatchingRunning(this.offerId);
}

class AiMatchingLoaded extends AiMatchingState {
  final List<AiMatchResultEntity> results;
  final int offerId;
  final String offerTitle;

  AiMatchingLoaded({
    required this.results,
    required this.offerId,
    required this.offerTitle,
  });
}

class AiMatchingNoOffers extends AiMatchingState {}

class AiMatchingEmpty extends AiMatchingState {
  final int offerId;
  final String offerTitle;

  AiMatchingEmpty({required this.offerId, required this.offerTitle});
}

class AiMatchingFailure extends AiMatchingState {
  final String message;
  AiMatchingFailure(this.message);
}
