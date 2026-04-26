import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/ambassador_entity.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

class GetAmbassadorsUseCase
    implements UseCase<List<AmbassadorEntity>, String?> {
  final IProfileRepository repository;

  GetAmbassadorsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<AmbassadorEntity>>> call({
    required String? params,
  }) {
    return repository.getAmbassadors(ordering: params);
  }
}
