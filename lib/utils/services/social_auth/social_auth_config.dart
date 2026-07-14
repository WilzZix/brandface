/// Social auth client configuration.
///
/// TODO: Provide real values from the LinkedIn developer console / Telegram
/// BotFather before shipping. The redirect URI must also be whitelisted on
/// the LinkedIn app and on the backend.
abstract final class SocialAuthConfig {
  const SocialAuthConfig._();

  static const String linkedInClientId = '<LINKEDIN_CLIENT_ID>';
  static const String linkedInRedirectUri =
      'https://api.influerax.com/api/accounts/v1/auth/linkedin-code/callback';
  static const List<String> linkedInScopes = ['openid', 'profile', 'email'];

  static const String telegramBotUsername = 'influeraxbot';

  // Domain registered with @BotFather via /setdomain.
  static const String telegramAuthOrigin = 'https://www.influerax.com';

  /// Google Web Client ID — backend `id_token.aud` shu qiymat bilan
  /// tekshiradi. Google Cloud Console → Credentials → OAuth 2.0 Client IDs
  /// → "Web application" turidagi clientni oling.
  /// Format: `<digits>-<hash>.apps.googleusercontent.com`.
  static const String googleServerClientId =
      '275276598948-2ootbe54lk7ed101k4iju2cc55009hel.apps.googleusercontent.com';

  /// Google iOS Client ID — Google Cloud Console → Credentials → OAuth 2.0
  /// Client IDs → "iOS" turidagi clientni oling. Info.plist'da `GIDClientID`
  /// va `CFBundleURLTypes.CFBundleURLSchemes` ham shu IDga mos bo'lishi shart.
  static const String googleIosClientId =
      '275276598948-4vvbt7hpsht5oj3umqcrm4h8gn2npo1h.apps.googleusercontent.com';
}
