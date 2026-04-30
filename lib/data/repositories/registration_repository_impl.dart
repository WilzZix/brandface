import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/registration/registration_data_source.dart';

import 'package:brandface/domain/entities/registration/registration_entity.dart';
import 'package:brandface/domain/usecase/registration/params/brand_registration_params.dart';
import 'package:brandface/domain/usecase/registration/params/fill_brand_profile_param.dart';
import 'package:brandface/domain/usecase/registration/params/fill_influencer_profile_param.dart';

import 'package:brandface/domain/usecase/registration/params/registration_params.dart';

import 'package:dart_either/src/dart_either.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/registration_repository.dart';

class RegistrationRepositoryImpl implements IRegistrationRepository {
  final RegistrationDataSource _dataSource;

  RegistrationRepositoryImpl({required RegistrationDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, RegistrationEntity>> registration({
    required RegistrationParams params,
  }) async {
    try {
      final registrationData = await _dataSource.registration(params: params);
      return Right(registrationData.toEntity());
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
  Future<Either<Failure, RegistrationEntity>> brandRegistration({
    required BrandRegistrationParams params,
  }) async {
    try {
      final registrationData = await _dataSource.brandRegistration(
        params: params,
      );
      return Right(registrationData.toEntity());
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
  Future<Either<Failure, void>> fillProfileInfo({
    required FillInfluencerProfileParam params,
    required String profileId,
  }) async {
    try {
      final registrationData = await _dataSource.fillProfileInfo(
        params: params,
        profileId: profileId,
      );
      return Right(registrationData);
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
  Future<Either<Failure, void>> fillBrandProfileInfo({
    required FillBrandProfileParam params,
    required String profileId,
  }) async {
    try {
      final result = await _dataSource.fillBrandProfileInfo(
        params: params,
        profileId: profileId,
      );
      return Right(result);
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
  Future<Either<Failure, void>> updateMyProfile({
    required FillInfluencerProfileParam params,
  }) async {
    try {
      await _dataSource.updateMyInfluencerProfile(params: params);
      return const Right(null);
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
  Future<Either<Failure, void>> updateMyProfileSection({
    required String url,
    required Map<String, dynamic> payload,
  }) async {
    try {
      await _dataSource.updateMyProfileSection(url: url, payload: payload);
      return const Right(null);
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
