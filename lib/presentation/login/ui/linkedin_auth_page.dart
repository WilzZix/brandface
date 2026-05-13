import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../uikit/tokens/colors.dart';
import '../../../utils/services/social_auth/social_auth_config.dart';

class LinkedInAuthResult {
  final String? code;
  final String? error;
  final bool cancelled;

  const LinkedInAuthResult._({this.code, this.error, this.cancelled = false});

  factory LinkedInAuthResult.success(String code) =>
      LinkedInAuthResult._(code: code);

  factory LinkedInAuthResult.failure(String error) =>
      LinkedInAuthResult._(error: error);

  factory LinkedInAuthResult.cancelled() =>
      const LinkedInAuthResult._(cancelled: true);
}

class LinkedInAuthPage extends StatefulWidget {
  const LinkedInAuthPage({super.key});

  static const String tag = '/linkedin_auth_page';

  @override
  State<LinkedInAuthPage> createState() => _LinkedInAuthPageState();
}

class _LinkedInAuthPageState extends State<LinkedInAuthPage> {
  late final WebViewController _controller;
  bool _completed = false;

  String _buildAuthUrl() {
    final state = DateTime.now().millisecondsSinceEpoch.toString();
    final scope = SocialAuthConfig.linkedInScopes.join('%20');
    return 'https://www.linkedin.com/oauth/v2/authorization'
        '?response_type=code'
        '&client_id=${SocialAuthConfig.linkedInClientId}'
        '&redirect_uri=${Uri.encodeComponent(SocialAuthConfig.linkedInRedirectUri)}'
        '&state=$state'
        '&scope=$scope';
  }

  void _handleNavigation(String url) {
    if (_completed) return;
    if (!url.startsWith(SocialAuthConfig.linkedInRedirectUri)) return;

    final uri = Uri.parse(url);
    final code = uri.queryParameters['code'];
    final error = uri.queryParameters['error'];

    _completed = true;
    if (code != null && code.isNotEmpty) {
      context.pop(LinkedInAuthResult.success(code));
    } else {
      context.pop(LinkedInAuthResult.failure(error ?? 'linkedin_auth_error'));
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url.startsWith(SocialAuthConfig.linkedInRedirectUri)) {
              _handleNavigation(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onUrlChange: (change) {
            final url = change.url;
            if (url != null) _handleNavigation(url);
          },
        ),
      )
      ..loadRequest(Uri.parse(_buildAuthUrl()));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (!_completed) {
          _completed = true;
          context.pop(LinkedInAuthResult.cancelled());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightBg,
          title: Text(t.login.linkedin_title),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              if (_completed) return;
              _completed = true;
              context.pop(LinkedInAuthResult.cancelled());
            },
          ),
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
