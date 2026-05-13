import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../uikit/tokens/colors.dart';
import '../../../utils/services/social_auth/social_auth_config.dart';

class TelegramAuthResult {
  final String? rawPayload;
  final String? error;
  final bool cancelled;

  const TelegramAuthResult._({
    this.rawPayload,
    this.error,
    this.cancelled = false,
  });

  factory TelegramAuthResult.success(String rawJson) =>
      TelegramAuthResult._(rawPayload: rawJson);

  factory TelegramAuthResult.failure(String error) =>
      TelegramAuthResult._(error: error);

  factory TelegramAuthResult.cancelled() =>
      const TelegramAuthResult._(cancelled: true);
}

class TelegramAuthPage extends StatefulWidget {
  const TelegramAuthPage({super.key});

  static const String tag = '/telegram_auth_page';

  @override
  State<TelegramAuthPage> createState() => _TelegramAuthPageState();
}

class _TelegramAuthPageState extends State<TelegramAuthPage> {
  late final WebViewController _controller;
  bool _completed = false;

  String _buildHtml() {
    // Telegram Login Widget. Bot domain must match SocialAuthConfig.telegramAuthOrigin
    // and be registered with @BotFather via /setdomain.
    return '''
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
      body { display:flex; align-items:center; justify-content:center;
             height:100vh; margin:0; background:#f8f9fb; font-family:sans-serif; }
    </style>
  </head>
  <body>
    <div>
      <script async src="https://telegram.org/js/telegram-widget.js?22"
        data-telegram-login="${SocialAuthConfig.telegramBotUsername}"
        data-size="large"
        data-onauth="onTelegramAuth(user)"
        data-request-access="write"></script>
      <script>
        function onTelegramAuth(user) {
          BFTelegram.postMessage(JSON.stringify(user));
        }
      </script>
    </div>
  </body>
</html>
''';
  }

  void _handleAuth(String rawJson) {
    if (_completed) return;
    try {
      jsonDecode(rawJson);
    } catch (_) {
      _completed = true;
      context.pop(TelegramAuthResult.failure('telegram_invalid_payload'));
      return;
    }
    _completed = true;
    context.pop(TelegramAuthResult.success(rawJson));
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'BFTelegram',
        onMessageReceived: (message) => _handleAuth(message.message),
      )
      ..loadHtmlString(
        _buildHtml(),
        baseUrl: SocialAuthConfig.telegramAuthOrigin,
      );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (!_completed) {
          _completed = true;
          context.pop(TelegramAuthResult.cancelled());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightBg,
          title: Text(t.login.telegram_title),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              if (_completed) return;
              _completed = true;
              context.pop(TelegramAuthResult.cancelled());
            },
          ),
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
