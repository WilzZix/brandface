import '../../../entities/social_provider.dart';

class SocialAuthParams {
  final SocialProvider provider;
  final String accessToken;
  final String? idToken;

  const SocialAuthParams({
    required this.provider,
    required this.accessToken,
    this.idToken,
  });
}

class LinkedInExchangeParams {
  final String code;
  final String redirectUri;

  const LinkedInExchangeParams({
    required this.code,
    required this.redirectUri,
  });
}
