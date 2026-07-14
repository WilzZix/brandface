import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/usecase/registration/params/fill_profile_request_params.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../repository/registration_repository.dart';
import '../login/send_otp_usecase.dart';

final class FillProfileInfoUsecase implements UseCase<void, FillProfileParams> {
  final IRegistrationRepository repository;

  FillProfileInfoUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call({
    required FillProfileParams params,
  }) async {
    return await repository.fillProfileInfo(
      profileId: params.profileId,
      params: params.profileData,
    );
  }
}
