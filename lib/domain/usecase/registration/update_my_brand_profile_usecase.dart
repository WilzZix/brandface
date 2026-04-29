import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/usecase/registration/params/fill_brand_profile_param.dart';
import 'package:dart_either/dart_either.dart';

import '../../repository/registration_repository.dart';
import '../login/send_otp_usecase.dart';

class UpdateMyBrandProfileUsecase
    implements UseCase<void, FillBrandProfileParam> {
  final IRegistrationRepository repository;

  UpdateMyBrandProfileUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call({
    required FillBrandProfileParam params,
  }) async {
    return await repository.updateMyBrandProfile(params: params);
  }
}
