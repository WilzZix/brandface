import 'package:brandface/core/error/exception_mapper.dart';
import 'package:brandface/data/data_source/network_data_source/login/login_data_source.dart';
import 'package:brandface/domain/entities/get_me_entity.dart';
import 'package:brandface/domain/entities/otp_entity.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:brandface/domain/usecase/login/params/verify_otp_params.dart';
import 'package:dart_either/dart_either.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/verify_otp_entity.dart';

final class LoginRepositoryImpl implements ILoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, OtpEntity>> sendOtp({required String phone}) {
    return guard(() async {
      final otpModel = await remoteDataSource.sendOtp(phone: phone);
      return otpModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, VerifyOtpEntity>> verifyOtp({
    required VerifyOtpParams params,
  }) {
    return guard(() async {
      final verifyOtpData = await remoteDataSource.verifyOtp(params: params);
      return verifyOtpData.toEntity();
    });
  }

  @override
  Future<Either<Failure, UserEntity>> getMe() {
    return guard(() async {
      final getMe = await remoteDataSource.getMe();
      return getMe.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> deleteAccount() {
    return guard(() => remoteDataSource.deleteAccount());
  }
}
