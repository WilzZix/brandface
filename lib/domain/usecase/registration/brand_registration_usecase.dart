import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/registration/registration_entity.dart';
import 'package:brandface/domain/repository/registration_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:brandface/domain/usecase/registration/params/brand_registration_params.dart';
import 'package:dart_either/src/dart_either.dart';

final class BrandRegistrationUsecase
    implements UseCase<RegistrationEntity, BrandRegistrationParams> {
  final IRegistrationRepository repository;

  BrandRegistrationUsecase(this.repository);

  @override
  Future<Either<Failure, RegistrationEntity>> call({
    required BrandRegistrationParams params,
  }) async {
    return await repository.brandRegistration(params: params);
  }
}
