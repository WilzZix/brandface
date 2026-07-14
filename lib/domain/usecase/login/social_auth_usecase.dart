import 'package:dart_either/dart_either.dart';

import '../../../core/error/failures.dart';
import '../../entities/social_auth_entity.dart';
import '../../repository/social_auth_repository.dart';
import 'params/social_auth_params.dart';
import 'send_otp_usecase.dart';

final class SocialAuthUseCase
    implements UseCase<SocialAuthEntity, SocialAuthParams> {
  final ISocialAuthRepository repository;

  SocialAuthUseCase({required this.repository});

  @override
  Future<Either<Failure, SocialAuthEntity>> call({
    required SocialAuthParams params,
  }) {
    return repository.socialLogin(
      provider: params.provider,
      accessToken: params.accessToken,
      idToken: params.idToken,
    );
  }
}

class LinkedInExchangeUseCase
    implements UseCase<SocialAuthEntity, LinkedInExchangeParams> {
  final ISocialAuthRepository repository;

  LinkedInExchangeUseCase({required this.repository});

  @override
  Future<Either<Failure, SocialAuthEntity>> call({
    required LinkedInExchangeParams params,
  }) {
    return repository.linkedInCodeExchange(
      code: params.code,
      redirectUri: params.redirectUri,
    );
  }
}
