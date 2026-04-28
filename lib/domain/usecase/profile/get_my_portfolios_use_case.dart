import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

import '../../repository/portfolio_repository.dart';

class GetMyPortfoliosUseCase
    implements UseCase<List<PortfolioItemEntity>, void> {
  final IPortfolioRepository repository;

  GetMyPortfoliosUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PortfolioItemEntity>>> call({
    required void params,
  }) {
    return repository.getMyPortfolios();
  }
}
