import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../domain/entities/social_provider.dart';
import 'social_auth_service.dart';

class FacebookAuthService implements SocialAuthService {
  FacebookAuthService({FacebookAuth? client})
      : _client = client ?? FacebookAuth.instance;

  final FacebookAuth _client;

  @override
  SocialProvider get provider => SocialProvider.facebook;

  @override
  Future<SocialSignInResult> signIn(BuildContext context) async {
    try {
      final result = await _client.login(
        permissions: const ['email', 'public_profile'],
      );

      switch (result.status) {
        case LoginStatus.success:
          final token = result.accessToken?.tokenString;
          if (token == null || token.isEmpty) {
            throw const SocialAuthFailedException(
              SocialProvider.facebook,
              'Facebook did not return an access token',
            );
          }
          return SocialSignInResult(
            provider: SocialProvider.facebook,
            accessToken: token,
          );
        case LoginStatus.cancelled:
          throw const SocialAuthCancelled(SocialProvider.facebook);
        case LoginStatus.failed:
        case LoginStatus.operationInProgress:
          throw SocialAuthFailedException(
            SocialProvider.facebook,
            result.message ?? 'Facebook login failed',
          );
      }
    } on SocialAuthCancelled {
      rethrow;
    } on SocialAuthFailedException {
      rethrow;
    } catch (e) {
      throw SocialAuthFailedException(SocialProvider.facebook, e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.logOut();
    } catch (_) {}
  }
}
