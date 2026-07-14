import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

import '../../repository/portfolio_repository.dart';

final class AddPortfolioImageParams {
  final int portfolioId;
  final int imageId;

  const AddPortfolioImageParams({
    required this.portfolioId,
    required this.imageId,
  });
}

final class AddPortfolioImageUseCase
    implements UseCase<PortfolioImageEntity, AddPortfolioImageParams> {
  final IPortfolioRepository repository;

  AddPortfolioImageUseCase({required this.repository});

  @override
  Future<Either<Failure, PortfolioImageEntity>> call({
    required AddPortfolioImageParams params,
  }) {
    return repository.addPortfolioImage(
      portfolioId: params.portfolioId,
      imageId: params.imageId,
    );
  }
}
