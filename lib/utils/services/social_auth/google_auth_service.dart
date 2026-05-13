import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../domain/entities/social_provider.dart';
import 'social_auth_service.dart';

class GoogleAuthService implements SocialAuthService {
  GoogleAuthService({GoogleSignIn? client})
      : _client = client ??
            GoogleSignIn(
              scopes: const ['email', 'profile', 'openid'],
              // TODO: Set the Web client ID from Google Cloud Console here
              // so that the issued id_token.aud matches the backend audience.
              // serverClientId: '<WEB_CLIENT_ID>.apps.googleusercontent.com',
            );

  final GoogleSignIn _client;

  @override
  SocialProvider get provider => SocialProvider.google;

  @override
  Future<SocialSignInResult> signIn(BuildContext context) async {
    try {
      final account = await _client.signIn();
      if (account == null) {
        throw const SocialAuthCancelled(SocialProvider.google);
      }
      final auth = await account.authentication;
      final idToken = auth.idToken;
      final accessToken = auth.accessToken;

      if ((idToken == null || idToken.isEmpty) &&
          (accessToken == null || accessToken.isEmpty)) {
        throw const SocialAuthFailedException(
          SocialProvider.google,
          'Google did not return a token',
        );
      }

      return SocialSignInResult(
        provider: SocialProvider.google,
        accessToken: accessToken ?? '',
        idToken: idToken,
      );
    } on SocialAuthCancelled {
      rethrow;
    } on SocialAuthFailedException {
      rethrow;
    } catch (e) {
      throw SocialAuthFailedException(SocialProvider.google, e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.signOut();
    } catch (_) {
      // Ignored — sign out errors should not block the user.
    }
  }
}
