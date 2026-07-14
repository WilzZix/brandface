import 'package:brandface/domain/entities/otp_entity.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:dart_either/dart_either.dart';

import '../../../core/error/failures.dart';

abstract interface class UseCase<T, P> {
  Future<Either<Failure, T>> call({required P params});
}

class SendOtpUseCase implements UseCase<OtpEntity, String> {
  final ILoginRepository repository;

  SendOtpUseCase(this.repository);

  @override
  Future<Either<Failure, OtpEntity>> call({required String params}) async {
    return await repository.sendOtp(phone: params);
  }
}
