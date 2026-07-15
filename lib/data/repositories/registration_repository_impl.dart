import 'package:brandface/core/error/exception_mapper.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/registration/registration_data_source.dart';

import 'package:brandface/domain/entities/registration/registration_entity.dart';
import 'package:brandface/domain/usecase/registration/params/brand_registration_params.dart';
import 'package:brandface/domain/usecase/registration/params/fill_brand_profile_param.dart';
import 'package:brandface/domain/usecase/registration/params/fill_influencer_profile_param.dart';

import 'package:brandface/domain/usecase/registration/params/registration_params.dart';

import 'package:dart_either/dart_either.dart';

import '../../domain/repository/registration_repository.dart';

final class RegistrationRepositoryImpl implements IRegistrationRepository {
  final RegistrationDataSource _dataSource;

  RegistrationRepositoryImpl({required RegistrationDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, RegistrationEntity>> registration({
    required RegistrationParams params,
  }) {
    return guard(() async {
      final registrationData = await _dataSource.registration(params: params);
      return registrationData.toEntity();
    });
  }

  @override
  Future<Either<Failure, RegistrationEntity>> brandRegistration({
    required BrandRegistrationParams params,
  }) {
    return guard(() async {
      final registrationData = await _dataSource.brandRegistration(
        params: params,
      );
      return registrationData.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> fillProfileInfo({
    required FillInfluencerProfileParam params,
    required String profileId,
  }) {
    return guard(
      () => _dataSource.fillProfileInfo(params: params, profileId: profileId),
    );
  }

  @override
  Future<Either<Failure, void>> fillBrandProfileInfo({
    required FillBrandProfileParam params,
    required String profileId,
  }) {
    return guard(
      () => _dataSource.fillBrandProfileInfo(
        params: params,
        profileId: profileId,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> updateMyProfile({
    required FillInfluencerProfileParam params,
  }) {
    return guard(() => _dataSource.updateMyInfluencerProfile(params: params));
  }

  @override
  Future<Either<Failure, void>> updateMyProfileSection({
    required String url,
    required Map<String, dynamic> payload,
  }) {
    return guard(
      () => _dataSource.updateMyProfileSection(url: url, payload: payload),
    );
  }
}
