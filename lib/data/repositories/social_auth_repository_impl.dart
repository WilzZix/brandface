import 'package:dart_either/dart_either.dart';

import '../../core/error/exception_mapper.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/social_auth_entity.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/repository/social_auth_repository.dart';
import '../data_source/network_data_source/social_auth/social_auth_data_source.dart';

final class SocialAuthRepositoryImpl implements ISocialAuthRepository {
  final SocialAuthDataSource dataSource;

  SocialAuthRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, SocialAuthEntity>> socialLogin({
    required SocialProvider provider,
    required String accessToken,
    String? idToken,
  }) {
    return guard(() async {
      final model = await dataSource.socialLogin(
        provider: provider,
        accessToken: accessToken,
        idToken: idToken,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, SocialAuthEntity>> linkedInCodeExchange({
    required String code,
    required String redirectUri,
  }) {
    return guard(() async {
      final model = await dataSource.linkedInCodeExchange(
        code: code,
        redirectUri: redirectUri,
      );
      return model.toEntity();
    });
  }
}
