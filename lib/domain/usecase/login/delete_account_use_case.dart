import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:dart_either/src/dart_either.dart';

class DeleteAccountUseCase {
  final ILoginRepository _repository;

  DeleteAccountUseCase(this._repository);

  Future<Either<Failure, void>> call() async {
    return await _repository.deleteAccount();
  }
}
