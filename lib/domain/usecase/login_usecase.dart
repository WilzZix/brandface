import 'package:brandface/domain/entities/login_entity.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:dart_either/dart_either.dart';

import '../../core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failures, Type>> call(Params params);
}

class LoginUseCase implements UseCase<OtpEntity, String> {
  final ILoginRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failures, OtpEntity>> call(String phone) async {
    return await repository.login(phone: phone);
  }
}
