import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/language_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../../repository/profile_repository.dart';

class GetLanguagesUseCase implements UseCase<List<LanguageEntity>, void> {
  final IProfileRepository repository;

  GetLanguagesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<LanguageEntity>>> call({
    required void params,
  }) async {
    return repository.getLanguages();
  }
}
