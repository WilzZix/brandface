import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

import '../../repository/portfolio_repository.dart';

final class GetPortfolioDetailUseCase
    implements UseCase<PortfolioItemEntity, int> {
  final IPortfolioRepository repository;

  GetPortfolioDetailUseCase({required this.repository});

  @override
  Future<Either<Failure, PortfolioItemEntity>> call({required int params}) {
    return repository.getPortfolioDetail(id: params);
  }
}
