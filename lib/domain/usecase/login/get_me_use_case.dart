import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/get_me_entity.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/src/dart_either.dart';

class GetMeUseCase implements UseCase<UserEntity, void> {
  final ILoginRepository _iLoginRepository;

  GetMeUseCase({required ILoginRepository iLoginRepository})
    : _iLoginRepository = iLoginRepository;

  @override
  Future<Either<Failure, UserEntity>> call({required void params}) async {
    return _iLoginRepository.getMe();
  }
}
