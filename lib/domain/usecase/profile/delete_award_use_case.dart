import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

class DeleteAwardUseCase implements UseCase<void, int> {
  final IProfileRepository repository;

  DeleteAwardUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call({required int params}) {
    return repository.deleteAward(awardId: params);
  }
}
