import 'package:brandface/data/data_source/network_data_source/login/login_data_source.dart';
import 'package:brandface/domain/entities/get_me_entity.dart';
import 'package:brandface/domain/entities/otp_entity.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:brandface/domain/usecase/login/params/verify_otp_params.dart';
import 'package:dart_either/dart_either.dart';

import 'package:dio/dio.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/verify_otp_entity.dart';

String _extractErrorMessage(DioException e) {
  final data = e.response?.data;
  if (data is Map) {
    for (final key in const ['message', 'detail', 'error', 'msg']) {
      final value = data[key];
      if (value is String && value.trim().isNotEmpty) {
        return value;
      }
    }
    final errors = data['errors'];
    if (errors is Map && errors.isNotEmpty) {
      final first = errors.values.first;
      if (first is String && first.trim().isNotEmpty) return first;
      if (first is List && first.isNotEmpty) {
        final entry = first.first;
        if (entry is String && entry.trim().isNotEmpty) return entry;
      }
    }
  }
  switch (e.response?.statusCode) {
    case 400:
      return 'Invalid request. Please check the code and try again.';
    case 401:
      return 'Session expired. Please log in again.';
    case 404:
      return 'Not found.';
    case 408:
    case 504:
      return 'Request timed out. Please try again.';
    case 500:
    case 502:
    case 503:
      return 'Server is unavailable. Please try again later.';
  }
  return 'Network error. Please check your connection.';
}

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
          _extractErrorMessage(e),
        ),
      );
    } catch (_) {
      return Left(const ServerFailure('Something went wrong. Please try again.'));
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
          _extractErrorMessage(e),
        ),
      );
    } catch (_) {
      return Left(const ServerFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getMe() async {
    try {
      final getMe = await remoteDataSource.getMe();
      return Right(getMe.toEntity());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          _extractErrorMessage(e),
        ),
      );
    } catch (_) {
      return Left(const ServerFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();
      return const Right(null);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          _extractErrorMessage(e),
        ),
      );
    } catch (_) {
      return Left(const ServerFailure('Something went wrong. Please try again.'));
    }
  }
}
