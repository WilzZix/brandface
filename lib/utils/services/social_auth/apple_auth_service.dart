import 'package:flutter/widgets.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../domain/entities/social_provider.dart';
import 'social_auth_service.dart';

class AppleAuthService implements SocialAuthService {
  const AppleAuthService();

  @override
  SocialProvider get provider => SocialProvider.apple;

  @override
  Future<SocialSignInResult> signIn(BuildContext context) async {
    try {
      final available = await SignInWithApple.isAvailable();
      if (!available) {
        throw const SocialAuthFailedException(
          SocialProvider.apple,
          'Sign in with Apple is not available on this device.',
        );
      }

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: const [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final idToken = credential.identityToken;
      if (idToken == null || idToken.isEmpty) {
        throw const SocialAuthFailedException(
          SocialProvider.apple,
          'Apple did not return an identity token.',
        );
      }

      // Backend swaggerga ko'ra: Apple uchun id_token majburiy, access_token
      // optional (bo'sh qoldirish mumkin).
      return SocialSignInResult(
        provider: SocialProvider.apple,
        accessToken: '',
        idToken: idToken,
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw const SocialAuthCancelled(SocialProvider.apple);
      }
      throw SocialAuthFailedException(SocialProvider.apple, e.message);
    } on SocialAuthCancelled {
      rethrow;
    } on SocialAuthFailedException {
      rethrow;
    } catch (e) {
      throw SocialAuthFailedException(SocialProvider.apple, e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    // Apple Sign-In hech qanday session token saqlamaydi — sign out no-op.
  }
}
