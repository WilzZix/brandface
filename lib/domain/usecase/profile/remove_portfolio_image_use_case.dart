import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

import '../../repository/portfolio_repository.dart';

class RemovePortfolioImageParams {
  final int portfolioId;
  final int imageId;

  const RemovePortfolioImageParams({
    required this.portfolioId,
    required this.imageId,
  });
}

class RemovePortfolioImageUseCase
    implements UseCase<void, RemovePortfolioImageParams> {
  final IPortfolioRepository repository;

  RemovePortfolioImageUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call({
    required RemovePortfolioImageParams params,
  }) {
    return repository.removePortfolioImage(
      portfolioId: params.portfolioId,
      imageId: params.imageId,
    );
  }
}
