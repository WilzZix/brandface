import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/registration/registration_data_source.dart';

import 'package:brandface/domain/entities/registration/registration_entity.dart';
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
      return Left(ServerFailure(e.message ?? 'Serverda kutilmagan xatolik'));
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
      return Left(ServerFailure(e.message ?? 'Serverda kutilmagan xatolik'));
    } catch (e) {
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }
}
