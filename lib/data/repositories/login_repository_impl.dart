import 'package:brandface/data/data_source/network_data_source/login/login_data_source.dart';
import 'package:brandface/domain/entities/otp_entity.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:brandface/domain/usecase/login/params/verify_otp_params.dart';
import 'package:dart_either/dart_either.dart';

import 'package:dio/dio.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/verify_otp_entity.dart';

class LoginRepositoryImpl implements ILoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, OtpEntity>> sendOtp({required String phone}) async {
    try {
      final otpModel = await remoteDataSource.sendOtp(phone: phone);
      return Right(otpModel.toEntity());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          e.message ?? 'Serverda kutilmagan xatolik',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, VerifyOtpEntity>> verifyOtp({
    required VerifyOtpParams params,
  }) async {
    try {
      final verifyOtpData = await remoteDataSource.verifyOtp(params: params);
      return Right(verifyOtpData.toEntity());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          e.message ?? 'Serverda kutilmagan xatolik',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }
}
