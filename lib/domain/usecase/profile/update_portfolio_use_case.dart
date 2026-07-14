import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

import '../../repository/portfolio_repository.dart';

final class UpdatePortfolioParams {
  final int id;
  final Map<String, dynamic> data;

  const UpdatePortfolioParams({required this.id, required this.data});
}

final class UpdatePortfolioUseCase
    implements UseCase<PortfolioItemEntity, UpdatePortfolioParams> {
  final IPortfolioRepository repository;

  UpdatePortfolioUseCase({required this.repository});

  @override
  Future<Either<Failure, PortfolioItemEntity>> call({
    required UpdatePortfolioParams params,
  }) {
    return repository.updatePortfolio(id: params.id, data: params.data);
  }
}
