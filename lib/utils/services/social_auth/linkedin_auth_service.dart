import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/social_provider.dart';
import '../../../presentation/login/ui/linkedin_auth_page.dart';
import 'social_auth_config.dart';
import 'social_auth_service.dart';

class LinkedInAuthService implements SocialAuthService {
  const LinkedInAuthService();

  @override
  SocialProvider get provider => SocialProvider.linkedin;

  @override
  Future<SocialSignInResult> signIn(BuildContext context) async {
    final result = await context.push<LinkedInAuthResult>(
      LinkedInAuthPage.tag,
    );

    if (result == null || result.cancelled) {
      throw const SocialAuthCancelled(SocialProvider.linkedin);
    }
    if (result.error != null) {
      throw SocialAuthFailedException(SocialProvider.linkedin, result.error!);
    }
    final code = result.code;
    if (code == null || code.isEmpty) {
      throw const SocialAuthFailedException(
        SocialProvider.linkedin,
        'Authorization code missing',
      );
    }

    return SocialSignInResult(
      provider: SocialProvider.linkedin,
      accessToken: '',
      code: code,
      redirectUri: SocialAuthConfig.linkedInRedirectUri,
    );
  }

  @override
  Future<void> signOut() async {}
}
