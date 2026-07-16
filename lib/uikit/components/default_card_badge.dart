import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

/// Non-interactive "Asosiy" pill shown on the card that is currently the
/// default payment method. It replaces the "set as main" action for that card
/// (there's nothing to set — it's already the main one).
class DefaultCardBadge extends StatelessWidget {
  const DefaultCardBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        t.billing.default_card,
        style: Typographies.labelMedium.copyWith(color: AppColors.primaryDark),
      ),
    );
  }
}
