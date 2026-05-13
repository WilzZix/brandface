import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/social_provider.dart';
import '../../../presentation/login/ui/telegram_auth_page.dart';
import 'social_auth_service.dart';

class TelegramAuthService implements SocialAuthService {
  const TelegramAuthService();

  @override
  SocialProvider get provider => SocialProvider.telegram;

  @override
  Future<SocialSignInResult> signIn(BuildContext context) async {
    final result = await context.push<TelegramAuthResult>(
      TelegramAuthPage.tag,
    );

    if (result == null || result.cancelled) {
      throw const SocialAuthCancelled(SocialProvider.telegram);
    }
    if (result.error != null) {
      throw SocialAuthFailedException(SocialProvider.telegram, result.error!);
    }
    final raw = result.rawPayload;
    if (raw == null || raw.isEmpty) {
      throw const SocialAuthFailedException(
        SocialProvider.telegram,
        'Telegram payload missing',
      );
    }

    return SocialSignInResult(
      provider: SocialProvider.telegram,
      accessToken: raw,
    );
  }

  @override
  Future<void> signOut() async {}
}
