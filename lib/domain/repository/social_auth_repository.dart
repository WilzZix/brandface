import 'package:dart_either/dart_either.dart';

import '../../core/error/failures.dart';
import '../entities/social_auth_entity.dart';
import '../entities/social_provider.dart';

abstract interface class ISocialAuthRepository {
  Future<Either<Failure, SocialAuthEntity>> socialLogin({
    required SocialProvider provider,
    required String accessToken,
    String? idToken,
  });

  Future<Either<Failure, SocialAuthEntity>> linkedInCodeExchange({
    required String code,
    required String redirectUri,
  });
}
