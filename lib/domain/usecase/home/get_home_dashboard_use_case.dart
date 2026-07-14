import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/home/home_dashboard_entity.dart';
import 'package:brandface/domain/repository/home_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

final class GetHomeDashboardUseCase
    implements UseCase<HomeDashboardEntity, void> {
  final IHomeRepository repository;

  GetHomeDashboardUseCase({required this.repository});

  @override
  Future<Either<Failure, HomeDashboardEntity>> call({required void params}) {
    return repository.getInfluencerHomeDashboard();
  }
}
