import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/offer/offer_detail_entity.dart';
import 'package:brandface/domain/repository/offer_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

final class GetOfferDetailUseCase implements UseCase<OfferDetailEntity, int> {
  final IOfferRepository repository;

  GetOfferDetailUseCase({required this.repository});

  @override
  Future<Either<Failure, OfferDetailEntity>> call({required int params}) {
    return repository.getAvailableOfferDetail(id: params);
  }
}
