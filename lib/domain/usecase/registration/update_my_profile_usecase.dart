import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/usecase/registration/params/fill_influencer_profile_param.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../repository/registration_repository.dart';
import '../login/send_otp_usecase.dart';

final class UpdateMyProfileUsecase
    implements UseCase<void, FillInfluencerProfileParam> {
  final IRegistrationRepository repository;

  UpdateMyProfileUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call({
    required FillInfluencerProfileParam params,
  }) async {
    return await repository.updateMyProfile(params: params);
  }
}
