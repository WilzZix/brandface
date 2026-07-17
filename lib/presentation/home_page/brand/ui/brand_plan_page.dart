import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/utils/services/profile_service.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_state.dart';
import 'package:brandface/presentation/home_page/profile/bloc/my_cards/cards_cubit.dart';
import 'package:brandface/presentation/home_page/profile/ui/components/payment_redirect_listener.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/utils/extansions/plan_features_x.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/extansions/snackbar_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandPlanPage extends StatelessWidget {
  const BrandPlanPage({super.key});

  static const String tag = '/brand-plan';

  @override
  Widget build(BuildContext context) {
    return PaymentRedirectListener(
      child: BlocListener<BillingCubit, BillingState>(
      listenWhen: (prev, curr) => prev.failure != curr.failure,
      listener: (context, state) {
        if (state.failure != null) {
          context.showAppSnackBar(
            state.failure!.message,
            type: AppSnackBarType.error,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBg,
        appBar: AppBar(
          backgroundColor: AppColors.lightBg,
          scrolledUnderElevation: 0,
          title: Text(t.billing.plan_tab, style: Typographies.titleMedium),
          centerTitle: false,
        ),
        body: BlocBuilder<BillingCubit, BillingState>(
          builder: (context, state) {
            if (state.status == BillingStatus.loading &&
                state.dashboard == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == BillingStatus.failure &&
                state.dashboard == null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.failure?.message ?? t.billing_ui.error_loading_plan,
                        style: Typographies.bodyMedium),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<BillingCubit>().loadBilling(force: true),
                      child: Text(t.common.try_again),
                    ),
                  ],
                ),
              );
            }

            final dashboard =
                state.dashboard ?? const BillingDashboardEntity();
            return RefreshIndicator(
              color: AppColors.black,
              onRefresh: () async {
                await context.read<BillingCubit>().loadBilling(force: true);
                if (context.mounted) {
                  await context.read<CardsCubit>().loadCards(force: true);
                }
              },
              child: BlocBuilder<CardsCubit, CardsState>(
                builder: (context, cardsState) => _PlanContent(
                  dashboard: dashboard,
                  cards: cardsState.cards,
                  isMutating: state.isMutating,
                ),
              ),
            );
          },
        ),
      ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Main content — picks the right section based on subscription state
// ─────────────────────────────────────────────────────────────────────────────

class _PlanContent extends StatefulWidget {
  const _PlanContent({
    required this.dashboard,
    required this.cards,
    required this.isMutating,
  });
  final BillingDashboardEntity dashboard;
  final List<BillingCardEntity> cards;
  final bool isMutating;

  @override
  State<_PlanContent> createState() => _PlanContentState();
}

class _PlanContentState extends State<_PlanContent> {
  final _couponController = TextEditingController();
  String _selectedPaymentMethod = 'payme';

  /// When the free (Minimal) user taps "Pro'ga o'tish" the card switches to the
  /// Pro plan in activate mode (coupon + payment + Activate) — no subscription
  /// exists yet. Resetting it returns to the Minimal view.
  bool _showProUpgrade = false;

  BillingCardEntity? get _defaultCard {
    for (final card in widget.cards) {
      if (card.isDefault) return card;
    }
    return widget.cards.isEmpty ? null : widget.cards.first;
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  BillingSubscriptionEntity? get _sub => widget.dashboard.subscription;

  static double _priceOf(BillingPlanEntity p) =>
      double.tryParse(p.priceMonthlyUsd ?? '') ?? 0;

  /// Plans for the current user's role only, cheapest first. The API tags each
  /// plan with an `audience` ('brand' / 'influencer').
  List<BillingPlanEntity> get _rolePlans {
    final role = sl<ProfileService>().getRole();
    final audience = role == 'brand' ? 'brand' : 'influencer';
    return widget.dashboard.plans
        .where((p) => p.audience == null || p.audience == audience)
        .toList()
      ..sort((a, b) => _priceOf(a).compareTo(_priceOf(b)));
  }

  BillingPlanEntity? get _plan {
    if (_sub?.plan != null) return _sub!.plan;
    final plans = _rolePlans;
    return plans.isNotEmpty ? plans.first : null;
  }

  // ── State helpers ─────────────────────────────────────────────────────────
  bool _isPremiumPlan(BillingPlanEntity? p) =>
      p != null &&
      p.priceMonthlyUsd != null &&
      (double.tryParse(p.priceMonthlyUsd!) ?? 0) != 0;

  bool get _isPremiumActive =>
      _sub != null && _sub!.isActive && _isPremiumPlan(_plan);

  bool get _isPremiumInactive =>
      _sub != null && !_sub!.isActive && _isPremiumPlan(_plan);

  /// The paid plan for this role (Pro), if any.
  BillingPlanEntity? get _proPlan {
    for (final p in _rolePlans) {
      if (_isPremiumPlan(p)) return p;
    }
    return null;
  }

  /// The plan shown in the card: the Pro plan while previewing an upgrade,
  /// otherwise the current plan.
  BillingPlanEntity? get _displayPlan => _showProUpgrade ? _proPlan : _plan;

  /// Show the activate flow (coupon + payment method + Activate) — either for a
  /// deactivated Pro subscription or while previewing a Pro upgrade.
  bool get _showActivateFlow => _isPremiumInactive || _showProUpgrade;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      children: [
        Text(t.billing.current_plan, style: Typographies.titleSmall),
        const SizedBox(height: 12),
        _buildPlanCard(context),
      ],
    );
  }

  Widget _buildPlanCard(BuildContext context) {
    final plan = _displayPlan;
    // Offer the upgrade CTA only on the plain Minimal view when a Pro plan
    // exists to upgrade to.
    final showUpgradeCta = !_isPremiumActive &&
        !_showActivateFlow &&
        _proPlan != null;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Status badge: Premium while active or previewing an upgrade;
          //    Deactivated for a real inactive sub; else Minimal ──────────
          _StatusBadge(
            isPremiumActive: _isPremiumActive || _showProUpgrade,
            isPremiumInactive: _isPremiumInactive && !_showProUpgrade,
            planName: plan?.name ?? t.billing_ui.minimal,
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // ── Price row ───────────────────────────────────────────────
          _PriceRow(
            plan: plan,
            subscription: _sub,
            isPremiumActive: _isPremiumActive,
            onDeactivate: widget.isMutating
                ? null
                : () => _confirmDeactivate(context),
          ),

          // ── Active: card + auto-renewal ─────────────────────────────
          if (_isPremiumActive) ...[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            _CardRow(card: _defaultCard),
          ],

          // ── Activate flow: coupon + payment + activate (deactivated sub
          //    or Pro upgrade preview) ────────────────────────────────────
          if (_showActivateFlow) ...[
            const SizedBox(height: 16),
            _CouponRow(controller: _couponController),
            const SizedBox(height: 12),
            _ActivateRow(
              paymentMethod: _selectedPaymentMethod,
              cards: widget.cards,
              isMutating: widget.isMutating,
              onMethodChanged: (v) =>
                  setState(() => _selectedPaymentMethod = v),
              onActivate: () => _activate(context),
            ),
            if (_showProUpgrade) ...[
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: () => setState(() => _showProUpgrade = false),
                  child: Text(
                    t.common.cancel,
                    style: Typographies.labelLarge.copyWith(
                      color: AppColors.mutedBlack,
                    ),
                  ),
                ),
              ),
            ],
          ],

          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 20),

          // ── Features list (from API) ────────────────────────────────
          if (_featuresList(plan).isEmpty)
            _FeatureRow(text: t.billing.no_feature_details)
          else
            ..._featuresList(plan).map((f) => _FeatureRow(text: f)),

          const SizedBox(height: 4),

          // ── Pay-as-you-go add-ons ────────────────────────────────────
          _PayAsYouGo(plan: plan, dashboard: widget.dashboard),

          // ── Upgrade CTA (Minimal → Pro) ─────────────────────────────
          if (showUpgradeCta) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () => setState(() => _showProUpgrade = true),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      t.billing_ui.upgrade_to_pro,
                      style: Typographies.labelLarge.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Actions ───────────────────────────────────────────────────────────────

  Future<void> _confirmDeactivate(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.billing_ui.deactivate_plan_question),
        content: Text(
          t.billing_ui.deactivate_plan_message,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(t.common.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(t.billing_ui.deactivate,
                style: TextStyle(color: AppColors.red)),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      context.read<BillingCubit>().cancelSubscription();
    }
  }

  Future<void> _activate(BuildContext context) async {
    // Pick the paid plan for this role (Pro). Uses a loop-based getter rather
    // than firstWhere+orElse: `_rolePlans` is a List<BillingPlanModel> at
    // runtime, so an orElse returning a bare BillingPlanEntity would throw a
    // "not a subtype" type error.
    final premiumPlan = _proPlan;
    if (premiumPlan == null) return;

    // The selector encodes a saved card as `card_<id>`. The backend expects
    // payment_method 'paylov' + card_id (immediate charge) — NOT the internal
    // `card_<id>` token (which 400s: "card_12 is not a valid choice"). Any
    // non-card selection falls back to a Paylov checkout link (no card_id).
    final sel = _selectedPaymentMethod;
    final isSavedCard = sel.startsWith('card_');
    final cardId = isSavedCard
        ? int.tryParse(sel.substring('card_'.length))
        : null;

    context.read<BillingCubit>().subscribeToPlan(
          SubscribeBillingPlanParams(
            planId: premiumPlan.id,
            paymentMethod: 'paylov',
            cardId: cardId,
            // No saved card → backend returns a checkout link; return_url lets
            // PaymentRedirectListener intercept the WebView completion.
            returnUrl: kPaylovReturnUrl,
          ),
        );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  // Features come straight from the plan (API); no hardcoded fallback list.
  List<String> _featuresList(BillingPlanEntity? plan) =>
      plan?.featureList ?? const [];
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.isPremiumActive,
    required this.isPremiumInactive,
    required this.planName,
  });
  final bool isPremiumActive;
  final bool isPremiumInactive;
  final String planName;

  @override
  Widget build(BuildContext context) {
    late String label;
    late Color bg;
    late Color fg;

    if (isPremiumActive) {
      label = t.billing_ui.premium;
      bg = AppColors.primary;
      fg = AppColors.black;
    } else if (isPremiumInactive) {
      label = t.billing_ui.deactivated;
      bg = AppColors.red;
      fg = AppColors.white;
    } else {
      label = t.billing_ui.minimal;
      bg = AppColors.mutedBlack;
      fg = AppColors.white;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Typographies.labelMedium.copyWith(color: fg),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.plan,
    required this.subscription,
    required this.isPremiumActive,
    required this.onDeactivate,
  });
  final BillingPlanEntity? plan;
  final BillingSubscriptionEntity? subscription;
  final bool isPremiumActive;
  final VoidCallback? onDeactivate;

  String _formatPrice() {
    final p = plan?.priceMonthlyUsd?.trim();
    if (p == null || p.isEmpty || p == '0' || p == '0.00') return '\$0';
    return '\$$p${t.billing.per_month}';
  }

  String _uzs() {
    // UZS sub-label comes from the plan (Paylov charges in UZS); empty when the
    // plan has no/zero UZS price so we don't show a fake amount.
    final uzs = plan?.priceMonthlyUzs?.trim();
    if (uzs == null || uzs.isEmpty || uzs == '0' || uzs == '0.00') return '';
    return '$uzs UZS${t.billing.per_month}';
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '—';
    const m = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec',
    ];
    return '${m[dt.month - 1]} ${dt.day.toString().padLeft(2, '0')} ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final dateLabel =
        isPremiumActive ? t.billing_ui.renewal_date : t.billing.start_date;
    final date = isPremiumActive
        ? subscription?.expiresAt
        : subscription?.startedAt;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_formatPrice(), style: Typographies.titleLarge),
              if (_uzs().isNotEmpty)
                Text(_uzs(),
                    style: Typographies.bodySmall
                        .copyWith(color: AppColors.mutedBlack)),
              if (isPremiumActive) ...[
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: onDeactivate,
                  child: Text(
                    t.billing_ui.deactivate,
                    style: Typographies.bodySmall.copyWith(color: AppColors.red),
                  ),
                ),
              ],
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(dateLabel,
                style: Typographies.bodySmall
                    .copyWith(color: AppColors.mutedBlack)),
            Text(_formatDate(date), style: Typographies.titleSmall),
          ],
        ),
      ],
    );
  }
}

class _CardRow extends StatefulWidget {
  const _CardRow({required this.card});
  final BillingCardEntity? card;

  @override
  State<_CardRow> createState() => _CardRowState();
}

class _CardRowState extends State<_CardRow> {
  bool _autoRenewal = true;

  @override
  Widget build(BuildContext context) {
    final card = widget.card;
    return Row(
      children: [
        // Card info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppAssets.icVisa, height: 18),
                  const SizedBox(width: 8),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                card != null
                    ? '${_cardLabel(card.cardType)} • ${card.name}'
                    : t.billing_ui.no_card_added,
                style: Typographies.bodyMedium,
              ),
              if (card != null)
                Text(
                  t.billing.card_expiry(
                    month: card.expiryMonth.toString().padLeft(2, '0'),
                    year: card.expiryYear,
                  ),
                  style: Typographies.bodySmall
                      .copyWith(color: AppColors.mutedBlack),
                ),
            ],
          ),
        ),

        // Auto-renewal toggle
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: _autoRenewal,
              onChanged: (v) => setState(() => _autoRenewal = v),
              activeThumbColor: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(width: 4),
            Text(t.billing_ui.auto_renewal, style: Typographies.bodySmall),
          ],
        ),
      ],
    );
  }

  String _cardLabel(String type) {
    final n = type.trim().toLowerCase();
    if (n.isEmpty) return t.billing_ui.card;
    return n[0].toUpperCase() + n.substring(1);
  }
}

class _CouponRow extends StatelessWidget {
  const _CouponRow({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            style: Typographies.bodyMedium,
            decoration: InputDecoration(
              hintText: t.billing_ui.coupon_code,
              hintStyle:
                  Typographies.bodyMedium.copyWith(color: AppColors.grey),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.check_rounded, color: AppColors.black, size: 22),
        ),
      ],
    );
  }
}

class _ActivateRow extends StatelessWidget {
  const _ActivateRow({
    required this.paymentMethod,
    required this.cards,
    required this.isMutating,
    required this.onMethodChanged,
    required this.onActivate,
  });
  final String paymentMethod;
  final List<BillingCardEntity> cards;
  final bool isMutating;
  final ValueChanged<String> onMethodChanged;
  final VoidCallback onActivate;

  List<_PayMethod> _buildMethods() {
    final list = <_PayMethod>[
      const _PayMethod('payme', 'Payme', _PayMethodType.payme),
      const _PayMethod('click', 'Click', _PayMethodType.click),
      const _PayMethod('uzcard', 'UzCard', _PayMethodType.uzcard),
    ];
    for (final card in cards) {
      final label = '${_cardLabel(card.cardType)} • ${card.name}';
      final type = card.cardType.trim().toLowerCase().contains('visa')
          ? _PayMethodType.visa
          : card.cardType.trim().toLowerCase().contains('master')
              ? _PayMethodType.mastercard
              : _PayMethodType.bankCard;
      list.add(_PayMethod('card_${card.id}', label, type));
    }
    return list;
  }

  static String _cardLabel(String type) {
    final n = type.trim().toLowerCase();
    if (n.isEmpty) return t.billing_ui.card;
    return n[0].toUpperCase() + n.substring(1);
  }

  _PayMethod _current(List<_PayMethod> methods) =>
      methods.firstWhere((m) => m.value == paymentMethod,
          orElse: () => methods.first);

  void _openSheet(BuildContext context) {
    final methods = _buildMethods();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _PaymentMethodSheet(
        methods: methods,
        selected: paymentMethod,
        onSelect: (v) {
          onMethodChanged(v);
          Navigator.of(ctx).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final methods = _buildMethods();
    final current = _current(methods);

    return Row(
      children: [
        // Payment method selector
        Expanded(
          child: GestureDetector(
            onTap: () => _openSheet(context),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Row(
                children: [
                  _PayMethodIcon(type: current.type, size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(current.label,
                        style: Typographies.bodyMedium,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded,
                      color: AppColors.mutedBlack, size: 20),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Activate button
        GestureDetector(
          onTap: isMutating ? null : onActivate,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            decoration: BoxDecoration(
              color: isMutating ? AppColors.borderColor : AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: isMutating
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.black,
                    ),
                  )
                : Text(
                    t.billing_ui.activate,
                    style: Typographies.labelLarge
                        .copyWith(color: AppColors.black),
                  ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Payment method bottom sheet
// ─────────────────────────────────────────────────────────────────────────────

class _PaymentMethodSheet extends StatelessWidget {
  const _PaymentMethodSheet({
    required this.methods,
    required this.selected,
    required this.onSelect,
  });
  final List<_PayMethod> methods;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(t.billing_ui.payment_method, style: Typographies.titleMedium),
          ),
          const SizedBox(height: 8),
          ...methods.map((m) {
            final isSelected = m.value == selected;
            return InkWell(
              onTap: () => onSelect(m.value),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    _PayMethodIcon(type: m.type, size: 28),
                    const SizedBox(width: 14),
                    Expanded(
                        child: Text(m.label,
                            style: Typographies.bodyMedium)),
                    if (isSelected)
                      Icon(Icons.check_rounded,
                          color: AppColors.primary, size: 22),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Payment method icon widget
// ─────────────────────────────────────────────────────────────────────────────

enum _PayMethodType { payme, click, uzcard, visa, mastercard, bankCard }

class _PayMethodIcon extends StatelessWidget {
  const _PayMethodIcon({required this.type, required this.size});
  final _PayMethodType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case _PayMethodType.visa:
        return SvgPicture.asset(AppAssets.icVisa, height: size * 0.7);
      case _PayMethodType.mastercard:
        return SizedBox(
          width: size,
          height: size * 0.7,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  width: size * 0.65,
                  height: size * 0.65,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEB001B),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: size * 0.65,
                  height: size * 0.65,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF79E1B).withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        );
      case _PayMethodType.payme:
        return Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF00AAFF),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Payme',
            style: TextStyle(
              fontSize: size * 0.45,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      case _PayMethodType.click:
        return Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF0095DA),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Click',
            style: TextStyle(
              fontSize: size * 0.45,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      case _PayMethodType.uzcard:
        return Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF1A6BB5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'UzCard',
            style: TextStyle(
              fontSize: size * 0.45,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      case _PayMethodType.bankCard:
        return Icon(Icons.credit_card_rounded,
            size: size, color: AppColors.mutedBlack);
    }
  }
}

class _PayMethod {
  final String value;
  final String label;
  final _PayMethodType type;
  const _PayMethod(this.value, this.label, this.type);
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: Typographies.bodyMedium)),
        ],
      ),
    );
  }
}

class _PayAsYouGo extends StatelessWidget {
  const _PayAsYouGo({required this.plan, required this.dashboard});
  final BillingPlanEntity? plan;
  final BillingDashboardEntity dashboard;

  String _fmt(String? v) {
    final s = v?.trim();
    if (s == null || s.isEmpty) return '';
    return '\$$s';
  }

  @override
  Widget build(BuildContext context) {
    final contactPrice = _fmt(plan?.contactPriceUsd);
    final boostPackage = dashboard.boostPackages.isNotEmpty
        ? dashboard.boostPackages.first
        : null;
    final boostLabel = boostPackage != null
        ? '${_fmt(boostPackage.priceUsd)} / ${boostPackage.days} days'
        : _fmt(plan?.boostPriceUsd);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            t.billing.pay_as_you_go,
            style: Typographies.labelSmall.copyWith(color: AppColors.black),
          ),
        ),
        const SizedBox(height: 12),
        if (contactPrice.isNotEmpty)
          _AddOnRow(label: t.billing.contact_unlock, value: contactPrice),
        if (boostLabel.isNotEmpty)
          _AddOnRow(label: t.billing.profile_offer_boost, value: boostLabel),
        _AddOnRow(
          label: t.billing_ui.extra_invites_applies,
          value: t.billing_ui.extra_invites_price,
        ),
      ],
    );
  }
}

class _AddOnRow extends StatelessWidget {
  const _AddOnRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          style: Typographies.bodyMedium.copyWith(color: AppColors.black),
          children: [
            TextSpan(text: '$label '),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
