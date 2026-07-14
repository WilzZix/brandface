import 'package:brandface/domain/entities/get_me_entity.dart';
import 'package:brandface/domain/entities/otp_entity.dart';
import 'package:brandface/domain/usecase/login/params/verify_otp_params.dart';
import 'package:dart_either/dart_either.dart';

import '../../core/error/failures.dart';
import '../entities/verify_otp_entity.dart';

abstract interface class ILoginRepository {
  Future<Either<Failure, OtpEntity>> sendOtp({required String phone});

  Future<Either<Failure, VerifyOtpEntity>> verifyOtp({
    required VerifyOtpParams params,
  });

  Future<Either<Failure, UserEntity>> getMe();

  Future<Either<Failure, void>> deleteAccount();
}
