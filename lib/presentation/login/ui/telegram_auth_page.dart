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

  /// Fake URL Telegram widget redirects to after a successful login.
  /// We intercept this navigation in-app — no server endpoint required.
  static const String _callbackUrl =
      'https://www.influerax.com/telegram-callback';

  @override
  State<TelegramAuthPage> createState() => _TelegramAuthPageState();
}

class _TelegramAuthPageState extends State<TelegramAuthPage> {
  late final WebViewController _controller;
  bool _completed = false;

  String _buildHtml() {
    // Telegram Login Widget configured with BOTH data-onauth (JS channel) and
    // data-auth-url (navigation callback). Whichever fires first wins.
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
        data-userpic="true"
        data-request-access="write"
        data-auth-url="${TelegramAuthPage._callbackUrl}"
        data-onauth="onTelegramAuth(user)"></script>
      <script>
        function onTelegramAuth(user) {
          try {
            BFTelegram.postMessage(JSON.stringify(user));
          } catch (e) {}
        }
      </script>
    </div>
  </body>
</html>
''';
  }

  void _resolveSuccess(String rawJson) {
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

  /// Parses any URL that may carry Telegram auth data and resolves the page
  /// if a valid payload is found. Returns true when a payload was extracted.
  bool _tryHandleCallback(String url) {
    if (_completed) return true;
    final uri = Uri.tryParse(url);
    if (uri == null) return false;

    // Telegram OAuth sometimes returns the base64-encoded payload in the
    // URL fragment as `#tgAuthResult=...` (popup mode) or as query params
    // (data-auth-url mode).
    final fragment = uri.fragment;
    if (fragment.contains('tgAuthResult=')) {
      final marker = 'tgAuthResult=';
      final start = fragment.indexOf(marker) + marker.length;
      var encoded = fragment.substring(start);
      final amp = encoded.indexOf('&');
      if (amp != -1) encoded = encoded.substring(0, amp);
      try {
        final padded = encoded.padRight(
          encoded.length + (4 - encoded.length % 4) % 4,
          '=',
        );
        final decoded = utf8.decode(base64Url.decode(padded));
        _resolveSuccess(decoded);
        return true;
      } catch (_) {
        // fall through and try query params
      }
    }

    final params = uri.queryParameters;
    if (params['id'] != null && params['hash'] != null) {
      final payload = <String, dynamic>{
        'id': int.tryParse(params['id']!) ?? params['id'],
        if (params['first_name'] != null) 'first_name': params['first_name'],
        if (params['last_name'] != null) 'last_name': params['last_name'],
        if (params['username'] != null) 'username': params['username'],
        if (params['photo_url'] != null) 'photo_url': params['photo_url'],
        if (params['auth_date'] != null)
          'auth_date':
              int.tryParse(params['auth_date']!) ?? params['auth_date'],
        'hash': params['hash'],
      };
      _resolveSuccess(jsonEncode(payload));
      return true;
    }

    return false;
  }

  NavigationDecision _onNavigation(NavigationRequest req) {
    if (_tryHandleCallback(req.url)) {
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'BFTelegram',
        onMessageReceived: (message) => _resolveSuccess(message.message),
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: _onNavigation,
          onPageStarted: (url) => _tryHandleCallback(url),
          onUrlChange: (change) {
            final url = change.url;
            if (url != null) _tryHandleCallback(url);
          },
        ),
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
