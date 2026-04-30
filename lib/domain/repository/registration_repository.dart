import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/registration/registration_entity.dart';
import 'package:brandface/domain/usecase/registration/params/brand_registration_params.dart';
import 'package:brandface/domain/usecase/registration/params/fill_brand_profile_param.dart';
import 'package:brandface/domain/usecase/registration/params/fill_influencer_profile_param.dart';
import 'package:brandface/domain/usecase/registration/params/registration_params.dart';
import 'package:dart_either/dart_either.dart';

abstract class IRegistrationRepository {
  Future<Either<Failure, RegistrationEntity>> registration({
    required RegistrationParams params,
  });

  Future<Either<Failure, RegistrationEntity>> brandRegistration({
    required BrandRegistrationParams params,
  });

  Future<Either<Failure, void>> fillProfileInfo({
    required FillInfluencerProfileParam params,
    required String profileId,
  });

  Future<Either<Failure, void>> fillBrandProfileInfo({
    required FillBrandProfileParam params,
    required String profileId,
  });

  Future<Either<Failure, void>> updateMyProfile({
    required FillInfluencerProfileParam params,
  });

  Future<Either<Failure, void>> updateMyProfileSection({
    required String url,
    required Map<String, dynamic> payload,
  });
}
