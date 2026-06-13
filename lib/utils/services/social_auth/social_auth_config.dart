/// Social auth client configuration.
///
/// TODO: Provide real values from the LinkedIn developer console / Telegram
/// BotFather before shipping. The redirect URI must also be whitelisted on
/// the LinkedIn app and on the backend.
class SocialAuthConfig {
  const SocialAuthConfig._();

  static const String linkedInClientId = '<LINKEDIN_CLIENT_ID>';
  static const String linkedInRedirectUri =
      'https://api.influerax.com/api/accounts/v1/auth/linkedin-code/callback';
  static const List<String> linkedInScopes = ['openid', 'profile', 'email'];

  static const String telegramBotUsername = 'influeraxbot';
  // Domain registered with @BotFather via /setdomain.
  static const String telegramAuthOrigin = 'https://www.influerax.com';
}
