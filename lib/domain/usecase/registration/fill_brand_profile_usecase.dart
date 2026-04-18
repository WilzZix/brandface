import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/usecase/registration/params/fill_brand_profile_param.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../repository/registration_repository.dart';
import '../login/send_otp_usecase.dart';

class FillBrandProfileUsecase
    implements UseCase<void, FillBrandProfileRequestParams> {
  final IRegistrationRepository repository;

  FillBrandProfileUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call({
    required FillBrandProfileRequestParams params,
  }) async {
    return await repository.fillBrandProfileInfo(
      profileId: params.profileId,
      params: params.profileData,
    );
  }
}
