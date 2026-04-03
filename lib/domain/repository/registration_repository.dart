import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/registration/registration_entity.dart';
import 'package:brandface/domain/usecase/registration/params/fill_influencer_profile_param.dart';
import 'package:brandface/domain/usecase/registration/params/registration_params.dart';
import 'package:dart_either/dart_either.dart';

abstract class IRegistrationRepository {
  Future<Either<Failures, RegistrationEntity>> registration({
    required RegistrationParams params,
  });

  Future<Either<Failures, void>> fillProfileInfo({
    required FillInfluencerProfileParam params,
    required String profileId,
  });
}
