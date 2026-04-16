import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/verify_otp_entity.dart';
import 'package:brandface/domain/usecase/login/params/verify_otp_params.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../repository/login_repository.dart';

class VerifyOtpUsecase implements UseCase<VerifyOtpEntity, VerifyOtpParams> {
  final ILoginRepository repository;

  VerifyOtpUsecase({required this.repository});

  @override
  Future<Either<Failure, VerifyOtpEntity>> call({
    required VerifyOtpParams params,
  }) async {
    return await repository.verifyOtp(params: params);
  }
}
