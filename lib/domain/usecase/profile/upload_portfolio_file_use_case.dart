import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

import '../../repository/portfolio_repository.dart';

final class UploadPortfolioFileUseCase
    implements UseCase<UploadedFileEntity, String> {
  final IPortfolioRepository repository;

  UploadPortfolioFileUseCase({required this.repository});

  @override
  Future<Either<Failure, UploadedFileEntity>> call({required String params}) {
    return repository.uploadFile(path: params);
  }
}
