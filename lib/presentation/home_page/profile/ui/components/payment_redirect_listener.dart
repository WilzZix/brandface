import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_state.dart';
import 'package:brandface/presentation/home_page/profile/ui/paylov_webview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Wraps [child] and reacts to a Paylov checkout link produced by the billing
/// flow (the cardless payment path): it opens the payment page in a WebView and
/// polls the transaction once the user returns.
///
/// Every screen that can start a subscription/boost wraps its body with this so
/// the "no saved card → checkout-link WebView" behaviour is identical
/// everywhere, instead of each screen re-implementing (or forgetting) it.
class PaymentRedirectListener extends StatelessWidget {
  const PaymentRedirectListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BillingCubit, BillingState>(
      listenWhen: (p, c) =>
          p.paymentRedirect != c.paymentRedirect && c.paymentRedirect != null,
      listener: (context, state) =>
          _handlePaymentRedirect(context, state.paymentRedirect!),
      child: child,
    );
  }

  /// Opens the Paylov checkout in a WebView, then polls the transaction so the
  /// UI reflects the payment once the webhook lands.
  Future<void> _handlePaymentRedirect(
    BuildContext context,
    PaymentRedirect redirect,
  ) async {
    final billingCubit = context.read<BillingCubit>();
    final reached = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        settings: const RouteSettings(name: '/billing/paylov'),
        builder: (_) => PaylovWebViewPage(
          paymentUrl: redirect.paymentUrl,
          returnUrl: kPaylovReturnUrl,
        ),
      ),
    );
    if (reached == true) {
      await billingCubit.pollPaymentStatus(redirect.transactionId);
    } else {
      await billingCubit.loadBilling(force: true);
    }
  }
}
