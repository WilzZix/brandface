import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract class IPortfolioRepository {
  Future<Either<Failure, List<PortfolioItemEntity>>> getMyPortfolios();
  Future<Either<Failure, PortfolioItemEntity>> getPortfolioDetail({
    required int id,
  });
  Future<Either<Failure, PortfolioItemEntity>> updatePortfolio({
    required int id,
    required Map<String, dynamic> data,
  });
  Future<Either<Failure, void>> deletePortfolio({required int id});
  Future<Either<Failure, UploadedFileEntity>> uploadFile({
    required String path,
  });
  Future<Either<Failure, PortfolioImageEntity>> addPortfolioImage({
    required int portfolioId,
    required int imageId,
  });
  Future<Either<Failure, void>> removePortfolioImage({
    required int portfolioId,
    required int imageId,
  });
}
