import 'package:brandface/core/error/exception_mapper.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/portfolio/portfolio_data_source.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/domain/repository/portfolio_repository.dart';
import 'package:dart_either/dart_either.dart';

final class PortfolioRepositoryImpl implements IPortfolioRepository {
  final PortfolioDataSource _dataSource;

  PortfolioRepositoryImpl({required PortfolioDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<PortfolioItemEntity>>> getMyPortfolios() {
    return guard(() => _dataSource.getMyPortfolios());
  }

  @override
  Future<Either<Failure, PortfolioItemEntity>> getPortfolioDetail({
    required int id,
  }) {
    return guard(() => _dataSource.getPortfolioDetail(id: id));
  }

  @override
  Future<Either<Failure, PortfolioItemEntity>> updatePortfolio({
    required int id,
    required Map<String, dynamic> data,
  }) {
    return guard(() => _dataSource.updatePortfolio(id: id, data: data));
  }

  @override
  Future<Either<Failure, void>> deletePortfolio({required int id}) {
    return guard(() => _dataSource.deletePortfolio(id: id));
  }

  @override
  Future<Either<Failure, UploadedFileEntity>> uploadFile({
    required String path,
  }) {
    return guard(() => _dataSource.uploadFile(path: path));
  }

  @override
  Future<Either<Failure, PortfolioImageEntity>> addPortfolioImage({
    required int portfolioId,
    required int imageId,
  }) {
    return guard(
      () => _dataSource.addPortfolioImage(
        portfolioId: portfolioId,
        imageId: imageId,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> removePortfolioImage({
    required int portfolioId,
    required int imageId,
  }) {
    return guard(
      () => _dataSource.removePortfolioImage(
        portfolioId: portfolioId,
        imageId: imageId,
      ),
    );
  }

  @override
  Future<Either<Failure, List<PortfolioItemEntity>>> getPublicPortfolio({
    required int influencerId,
  }) {
    return guard(() => _dataSource.getPublicPortfolio(influencerId: influencerId));
  }
}
