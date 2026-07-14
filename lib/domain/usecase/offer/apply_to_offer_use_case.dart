import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/repository/offer_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

final class ApplyToOfferParams {
  final int id;
  final String? coverLetter;

  const ApplyToOfferParams({required this.id, this.coverLetter});
}

final class ApplyToOfferUseCase implements UseCase<void, ApplyToOfferParams> {
  final IOfferRepository repository;

  ApplyToOfferUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call({required ApplyToOfferParams params}) {
    return repository.applyToOffer(
      id: params.id,
      coverLetter: params.coverLetter,
    );
  }
}
