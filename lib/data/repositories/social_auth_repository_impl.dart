import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

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
  }) async {
    try {
      final model = await dataSource.socialLogin(
        provider: provider,
        accessToken: accessToken,
        idToken: idToken,
      );
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          e.message ?? 'Serverda kutilmagan xatolik',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, SocialAuthEntity>> linkedInCodeExchange({
    required String code,
    required String redirectUri,
  }) async {
    try {
      final model = await dataSource.linkedInCodeExchange(
        code: code,
        redirectUri: redirectUri,
      );
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          e.message ?? 'Serverda kutilmagan xatolik',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }
}
