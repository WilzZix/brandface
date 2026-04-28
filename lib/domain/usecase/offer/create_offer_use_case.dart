import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/offer/create_offer_params.dart';
import 'package:brandface/domain/repository/offer_repository.dart';
import 'package:dart_either/dart_either.dart';

class CreateOfferUseCase {
  final IOfferRepository repository;

  CreateOfferUseCase({required this.repository});

  Future<Either<Failure, void>> call({required CreateOfferParams params}) {
    return repository.createOffer(params);
  }
}
