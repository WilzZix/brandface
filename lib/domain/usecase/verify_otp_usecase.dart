import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/verify_otp_entity.dart';
import 'package:brandface/domain/usecase/send_otp_usecase.dart';
import 'package:dart_either/src/dart_either.dart';

import '../repository/login_repository.dart';

class VerifyOtpUsecase implements UseCase<VerifyOtpEntity, String> {
  final ILoginRepository repository;

  VerifyOtpUsecase({required this.repository});

  @override
  Future<Either<Failures, VerifyOtpEntity>> call(String params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
