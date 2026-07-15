import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Opens a Paylov checkout link in an in-app WebView and closes as soon as the
/// user is redirected to the return URL (Paylov redirects there both on success
/// and on cancel).
///
/// Pops `true`  → the return URL was reached (caller should poll the payment).
/// Pops `false` → the user closed the sheet manually before finishing.
class PaylovWebViewPage extends StatefulWidget {
  const PaylovWebViewPage({
    super.key,
    required this.paymentUrl,
    required this.returnUrl,
  });

  final String paymentUrl;
  final String returnUrl;

  @override
  State<PaylovWebViewPage> createState() => _PaylovWebViewPageState();
}

class _PaylovWebViewPageState extends State<PaylovWebViewPage> {
  late final WebViewController _controller;
  bool _loading = true;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            if (_isReturnUrl(url)) _finish();
          },
          onNavigationRequest: (request) {
            if (_isReturnUrl(request.url)) {
              _finish();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  bool _isReturnUrl(String url) => url.startsWith(widget.returnUrl);

  void _finish() {
    if (_finished) return;
    _finished = true;
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        title: Text(t.billing_ui.payment, style: Typographies.titleMedium),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_loading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
