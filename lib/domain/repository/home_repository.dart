import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/home/home_dashboard_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract interface class IHomeRepository {
  Future<Either<Failure, HomeDashboardEntity>> getInfluencerHomeDashboard();
}
