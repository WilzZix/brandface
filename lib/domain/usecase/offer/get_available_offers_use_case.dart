import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';
import 'package:brandface/domain/repository/offer_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

final class GetAvailableOffersUseCase
    implements UseCase<List<OfferSummaryEntity>, int?> {
  final IOfferRepository repository;

  GetAvailableOffersUseCase({required this.repository});

  @override
  Future<Either<Failure, List<OfferSummaryEntity>>> call({
    required int? params,
  }) {
    return repository.getAvailableOffers(categoryId: params);
  }
}
