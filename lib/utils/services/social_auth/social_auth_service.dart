import 'package:flutter/widgets.dart';

import '../../../domain/entities/social_provider.dart';

class SocialSignInResult {
  final SocialProvider provider;
  final String accessToken;
  final String? idToken;
  final String? code;
  final String? redirectUri;

  const SocialSignInResult({
    required this.provider,
    required this.accessToken,
    this.idToken,
    this.code,
    this.redirectUri,
  });

  bool get isLinkedInCode => code != null && redirectUri != null;
}

class SocialAuthCancelled implements Exception {
  final SocialProvider provider;

  const SocialAuthCancelled(this.provider);

  @override
  String toString() => 'SocialAuthCancelled(${provider.apiValue})';
}

class SocialAuthFailedException implements Exception {
  final SocialProvider provider;
  final String message;

  const SocialAuthFailedException(this.provider, this.message);

  @override
  String toString() => 'SocialAuthFailedException(${provider.apiValue}): $message';
}

abstract class SocialAuthService {
  SocialProvider get provider;

  Future<SocialSignInResult> signIn(BuildContext context);

  Future<void> signOut();
}
