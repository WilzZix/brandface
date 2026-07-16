import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_state.dart';
import 'package:brandface/presentation/home_page/profile/bloc/my_cards/cards_cubit.dart';
import 'package:brandface/presentation/home_page/profile/ui/card_otp_page.dart';
import 'package:brandface/presentation/home_page/profile/ui/components/payment_redirect_listener.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/components/card_brand_logo.dart';
import 'package:brandface/uikit/components/default_card_badge.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/components/ui_components/title_description_widget.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/extansions/card_mask_x.dart';
import 'package:brandface/utils/extansions/plan_features_x.dart';
import 'package:brandface/utils/extansions/snackbar_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Billing extends StatefulWidget {
  const Billing({super.key, this.initialTab = 0});

  static const String tag = '/billing';

  final int initialTab;

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  late int _selectedIndex;

  /// Guards against double-tap pushing two _AddCardPage instances.
  bool _isOpeningAddCard = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return PaymentRedirectListener(
      child: MultiBlocListener(
        listeners: [
          BlocListener<BillingCubit, BillingState>(
            listenWhen: (p, c) => p.failure != c.failure && c.failure != null,
            listener: (context, state) => context.showAppSnackBar(
              state.failure!.message,
              type: AppSnackBarType.error,
            ),
          ),
          BlocListener<CardsCubit, CardsState>(
            listenWhen: (p, c) => p.failure != c.failure && c.failure != null,
            listener: (context, state) => context.showAppSnackBar(
              state.failure!.message,
              type: AppSnackBarType.error,
            ),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
        appBar: AppBar(title: Text(t.profile.billing), centerTitle: false),
        body: BlocBuilder<BillingCubit, BillingState>(
          builder: (context, state) {
            final dashboard = state.dashboard;

            if (state.status == BillingStatus.loading && dashboard == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == BillingStatus.failure && dashboard == null) {
              return _BillingErrorState(
                onRetry: () =>
                    context.read<BillingCubit>().loadBilling(force: true),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildTabSelector(),
                ),
                const SizedBox(height: 30),
                if (state.status == BillingStatus.loading)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
                Expanded(
                  child: RefreshIndicator(
                    color: AppColors.black,
                    onRefresh: () =>
                        context.read<BillingCubit>().loadBilling(force: true),
                    child: _buildCurrentContent(
                      context,
                      state: state,
                      dashboard: dashboard ?? const BillingDashboardEntity(),
                    ),
                  ),
                ),
              ],
            );
          },
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentContent(
    BuildContext context, {
    required BillingState state,
    required BillingDashboardEntity dashboard,
  }) {
    switch (_selectedIndex) {
      case 0:
        return _buildPlanSection(context, dashboard: dashboard, state: state);
      case 1:
        return _buildMyCardsSection(
          context,
          dashboard: dashboard,
          state: state,
        );
      case 2:
        return _buildBillingHistorySection(dashboard);
      default:
        return _buildPlanSection(context, dashboard: dashboard, state: state);
    }
  }

  Widget _buildTabSelector() {
    return Row(
      children: [
        _tabItem(t.billing.plan_tab, 0),
        const SizedBox(width: 8),
        _tabItem(t.billing.my_cards_tab, 1),
        const SizedBox(width: 8),
        _tabItem(t.billing.history_tab, 2),
      ],
    );
  }

  Widget _tabItem(String text, int index) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: isSelected
                ? null
                : Border.all(color: AppColors.borderColor),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: Typographies.labelMedium,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlanSection(
    BuildContext context, {
    required BillingDashboardEntity dashboard,
    required BillingState state,
  }) {
    final subscription = dashboard.subscription;
    final plan =
        subscription?.plan ??
        (dashboard.plans.isNotEmpty ? dashboard.plans.first : null);
    final boostPackage = dashboard.boostPackages.isNotEmpty
        ? dashboard.boostPackages.first
        : null;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Text(t.billing.current_plan, style: Typographies.titleSmall),
        const SizedBox(height: 12),
        AppContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _statusBadge(plan?.name ?? t.billing.no_plan),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              _priceHeader(
                _formatUsd(plan?.priceMonthlyUsd),
                _buildMonthlySubtitle(plan),
                _formatDate(subscription?.startedAt),
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 20),
              ..._buildFeatureItems(plan),
              if (_buildFeatureItems(plan).isEmpty) ...[
                _checkItem(t.billing.no_feature_details),
              ],
              const SizedBox(height: 20),
              _payAsYouGoBanner(),
              const SizedBox(height: 16),
              _priceRow(
                t.billing.contact_unlock,
                _formatUsd(plan?.contactPriceUsd),
              ),
              _priceRow(
                t.billing.profile_offer_boost,
                boostPackage == null
                    ? _formatUsd(plan?.boostPriceUsd)
                    : '${_formatUsd(boostPackage.priceUsd)} / ${t.billing.days(days: boostPackage.days)}',
              ),
              const SizedBox(height: 20),
              if (boostPackage != null)
                SizedBox(
                  width: double.infinity,
                  child: AppButtons.primary(
                    title: state.isMutating
                        ? t.billing.processing
                        : t.billing.boost_profile,
                    onTap: state.isMutating
                        ? null
                        : () => _showBoostPackages(context, dashboard),
                  ),
                ),
              if (subscription != null) ...[
                const SizedBox(height: 12),
                Center(
                  child: AppTextButton(
                    title: t.billing.cancel_subscription,
                    color: AppColors.red,
                    onTap: state.isMutating
                        ? null
                        : () =>
                              context.read<BillingCubit>().cancelSubscription(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMyCardsSection(
    BuildContext context, {
    required BillingDashboardEntity dashboard,
    required BillingState state,
  }) {
    return BlocBuilder<CardsCubit, CardsState>(
      builder: (context, cardsState) {
        if (cardsState.status == CardsStatus.loading && !cardsState.hasCards) {
          return const Center(child: CircularProgressIndicator());
        }
        return _cardsList(context, cardsState);
      },
    );
  }

  Widget _cardsList(BuildContext context, CardsState state) {
    final cards = state.cards;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        if (index == cards.length) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: AppTextButton(
                title: t.billing.add_new_card,
                leading: SvgPicture.asset(AppAssets.icAdd),
                onTap: state.isMutating
                    ? null
                    : () => _openAddCardPage(context),
              ),
            ),
          );
        }

        final card = cards[index];
        return AppContainer(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_cardLabel(card.cardType)} • ${card.maskedNumber}',
                        style: Typographies.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        t.billing.card_expiry(
                          month: card.expiryMonth.toString().padLeft(2, '0'),
                          year: card.expiryYear,
                        ),
                        style: Typographies.titleSmall.copyWith(
                          color: AppColors.mutedBlack,
                        ),
                      ),
                    ],
                  ),
                  CardBrandLogo(brand: card.cardType, height: 26),
                ],
              ),
              const SizedBox(height: 12),
              Divider(color: AppColors.borderColor),
              const SizedBox(height: 12),
              Row(
                children: [
                  AppTextButton(
                    title: t.billing.delete_card,
                    color: AppColors.red,
                    textStyle: Typographies.titleSmall,
                    onTap: state.isMutating
                        ? null
                        : () => context.read<CardsCubit>().deleteCard(card.id),
                  ),
                  const SizedBox(width: 8),
                  if (card.isDefault)
                    const DefaultCardBadge()
                  else
                    AppTextButton(
                      title: t.billing.set_default_card,
                      color: AppColors.black,
                      textStyle: Typographies.titleSmall,
                      onTap: state.isMutating
                          ? null
                          : () => context
                                .read<CardsCubit>()
                                .setDefaultCard(card.id),
                    ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 8),
      itemCount: cards.length + 1,
    );
  }

  Widget _buildBillingHistorySection(BillingDashboardEntity dashboard) {
    final transactions = dashboard.transactions;

    if (transactions.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 140),
          Center(child: Text(t.billing.no_billing_history)),
        ],
      );
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        final item = transactions[index];
        return AppContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.planName ?? t.billing.transaction_label(id: item.id),
                style: Typographies.titleMedium,
              ),
              const SizedBox(height: 12),
              Divider(color: AppColors.borderColor),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleDescriptionWidget(
                    title: t.billing.issue_date,
                    descriptionItem: Text(
                      _formatDate(item.createdAt),
                      style: Typographies.bodyMedium,
                    ),
                  ),
                  TitleDescriptionWidget(
                    title: t.billing.amount,
                    descriptionItem: Text(
                      _formatAmount(item.amount, item.currency),
                      style: Typographies.bodyMedium,
                    ),
                  ),
                  TitleDescriptionWidget(
                    title: t.offer.status,
                    descriptionItem: Text(
                      item.status ?? t.common.unknown,
                      style: Typographies.bodyMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 8),
      itemCount: transactions.length,
    );
  }

  Widget _statusBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        _capitalize(text),
        style: Typographies.bodySmall.copyWith(color: AppColors.white),
      ),
    );
  }

  Widget _priceHeader(String price, String sub, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(price, style: Typographies.titleLarge),
            Text(sub, style: Typographies.bodySmall),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(t.billing.start_date, style: Typographies.bodySmall),
            Text(date, style: Typographies.titleMedium),
          ],
        ),
      ],
    );
  }

  Widget _checkItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: AppColors.primaryDark,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: Typographies.bodyMedium)),
        ],
      ),
    );
  }

  Widget _payAsYouGoBanner() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(200),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(t.billing.pay_as_you_go, style: Typographies.titleSmall),
    );
  }

  Widget _priceRow(String label, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(label, style: Typographies.bodyMedium),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              price,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFeatureItems(BillingPlanEntity? plan) {
    if (plan == null) {
      return const [];
    }

    final features = _extractFeatures(plan);
    return features.map(_checkItem).toList();
  }

  List<String> _extractFeatures(BillingPlanEntity plan) {
    final parsed = plan.featureList;

    if (parsed.isNotEmpty) {
      return parsed;
    }

    return [
      t.billing_ui.max_offers_per_month(count: plan.maxOffersPerMonth),
      t.billing_ui.max_finds_per_month(count: plan.maxFindsPerMonth),
      t.billing_ui.ai_matches_count(count: plan.aiMatchesCount),
      t.billing_ui.max_shortlist(count: plan.maxShortlist),
      if (plan.hasFullContactAccess) t.billing_ui.full_contact_access,
      if (plan.hasAdvancedAnalytics) t.billing_ui.advanced_analytics,
      if (plan.hasPrioritySupport) t.billing_ui.priority_support,
    ];
  }

  Future<void> _openAddCardPage(BuildContext context) async {
    // Re-entry guard: prevents a fast double-tap from pushing the page twice.
    if (_isOpeningAddCard) return;
    _isOpeningAddCard = true;
    final cardsCubit = context.read<CardsCubit>();
    try {
      await Navigator.of(context).push(
        MaterialPageRoute(
          // Named so RouteLoggerObserver prints "/billing/add-card"
          // instead of MaterialPageRoute<AddBillingCardParams>.
          settings: const RouteSettings(name: '/billing/add-card'),
          // Reuse the list's CardsCubit so the OTP flow and the reloaded list
          // land on the same instance.
          builder: (_) => BlocProvider.value(
            value: cardsCubit,
            child: const _AddCardPage(),
          ),
        ),
      );
    } finally {
      if (mounted) _isOpeningAddCard = false;
    }
  }

  Future<void> _showBoostPackages(
    BuildContext context,
    BillingDashboardEntity dashboard,
  ) async {
    final defaultCard = context.read<CardsCubit>().state.defaultCard;

    final package = await showModalBottomSheet<BillingBoostPackageEntity>(
      context: context,
      useSafeArea: true,
      builder: (bottomSheetContext) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: dashboard.boostPackages
                .map(
                  (item) => ListTile(
                    title: Text(item.label),
                    subtitle: Text(
                      '${_formatUsd(item.priceUsd)} • ${t.billing.days(days: item.days)}',
                    ),
                    onTap: () => Navigator.of(bottomSheetContext).pop(item),
                  ),
                )
                .toList(),
          ),
        );
      },
    );

    if (!context.mounted || package == null) {
      return;
    }

    // With a saved card Paylov charges immediately; otherwise a checkout link
    // is returned and opened in the WebView (handled via paymentRedirect).
    await context.read<BillingCubit>().boostProfile(
      BoostProfileParams(
        packageId: package.id,
        paymentMethod: 'paylov',
        cardId: defaultCard?.id,
        returnUrl: kPaylovReturnUrl,
      ),
    );
  }

  static String _formatUsd(String? value) {
    final text = value?.trim();
    if (text == null || text.isEmpty) {
      return '\$0';
    }

    return '\$$text';
  }

  static String _buildMonthlySubtitle(BillingPlanEntity? plan) {
    if (plan == null) {
      return t.billing.no_active_subscription;
    }

    // Paylov charges in UZS, so surface the UZS price when the plan has one.
    final uzs = plan.priceMonthlyUzs?.trim();
    if (uzs != null && uzs.isNotEmpty) {
      return '$uzs UZS ${t.billing.per_month}';
    }

    return '${_formatUsd(plan.priceMonthlyUsd)} ${t.billing.per_month}';
  }

  static String _formatAmount(String? amount, String? currency) {
    final safeAmount = amount?.trim();
    final safeCurrency = currency?.trim();
    if (safeAmount == null || safeAmount.isEmpty) {
      return t.common.unknown;
    }

    if (safeCurrency == null || safeCurrency.isEmpty) {
      return safeAmount;
    }

    return '$safeAmount $safeCurrency';
  }

  static String _formatDate(DateTime? value) {
    if (value == null) {
      return t.common.unknown;
    }

    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${monthNames[value.month - 1]} ${value.day.toString().padLeft(2, '0')} ${value.year}';
  }

  static String _capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }

    return value[0].toUpperCase() + value.substring(1);
  }

  static String _cardLabel(String type) {
    final normalized = type.trim().toLowerCase();
    if (normalized.isEmpty) {
      return t.billing_ui.card;
    }

    return _capitalize(normalized);
  }
}

class _BillingErrorState extends StatelessWidget {
  const _BillingErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.billing.error_load,
              style: Typographies.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              t.common.pull_refresh_or_retry,
              style: Typographies.bodyMedium.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 170,
              child: AppButtons.primary(
                title: t.common.try_again,
                onTap: onRetry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddCardPage extends StatefulWidget {
  const _AddCardPage();

  @override
  State<_AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<_AddCardPage> {
  final TextEditingController _holderController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _ccvController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  // Uzbekistan local card BIN prefixes — CVV is NOT required.
  // Add new prefixes here when confirmed.
  static const _uzcardPrefixes = <String>[
    '8600', // Uzcard (national)
    '5614', // Uzcard co-badge Mastercard
    '5440',
    '5286',
    '5106',
  ];
  static const _humoPrefixes = <String>[
    '9860', // Humo (national)
    '9869',
  ];

  bool _isLocalCard(String raw) {
    final digits = raw.replaceAll(' ', '');
    if (digits.length < 4) return false;
    final prefix4 = digits.substring(0, 4);
    return _uzcardPrefixes.contains(prefix4) || _humoPrefixes.contains(prefix4);
  }

  String _detectBrand(String raw) {
    final digits = raw.replaceAll(' ', '');
    if (digits.isEmpty) return 'unknown';
    if (digits.length >= 4) {
      final prefix4 = digits.substring(0, 4);
      if (_uzcardPrefixes.contains(prefix4)) return 'uzcard';
      if (_humoPrefixes.contains(prefix4)) return 'humo';
    }
    if (digits.startsWith('4')) return 'visa';
    if (digits.startsWith('5')) return 'mastercard';
    return 'unknown';
  }

  @override
  void dispose() {
    _holderController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _ccvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      // Resize the body for the keyboard so the in-body action row stays
      // pinned just above it.
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.lightBg,
        elevation: 0,
        centerTitle: false,
        leadingWidth: 64,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: AppColors.mutedBlack, size: 34),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        titleSpacing: 0,
        title: Text(t.billing_ui.add_new_payment_method,
            style: Typographies.titleLarge),
      ),
      // Tap outside any input to dismiss the keyboard.
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            top: false,
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _cardField(
                            controller: _holderController,
                            label: t.billing_ui.card_holder,
                            hintText: t.billing_ui.write_card_holder_name,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if ((value ?? '').trim().isEmpty) {
                                return t.billing_ui.required;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          _cardField(
                            controller: _cardNumberController,
                            label: t.billing_ui.card_number,
                            hintText: t.billing_ui.write_card_number,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              _CardNumberInputFormatter(),
                            ],
                            validator: (value) {
                              final digits = _digitsOnlyText(value ?? '');
                              if (digits.isEmpty) {
                                return t.billing_ui.required;
                              }
                              if (digits.length != 16) {
                                return t.billing_ui.enter_valid_16_digit_card;
                              }
                              return null;
                            },
                            trailing: ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _cardNumberController,
                              builder: (context, value, _) {
                                final brand = _detectBrand(value.text);
                                if (brand == 'unknown') {
                                  return const SizedBox.shrink();
                                }
                                return CardBrandLogo(brand: brand, height: 22);
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Uzcard / Humo and known Uzbek co-badge cards skip CCV.
                          ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _cardNumberController,
                            builder: (context, value, _) {
                              final isLocal = _isLocalCard(value.text);
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _cardField(
                                      controller: _expiryController,
                                      label: t.billing_ui.expire_date,
                                      hintText: t.billing_ui.mm_yy,
                                      keyboardType: TextInputType.number,
                                      textInputAction: isLocal
                                          ? TextInputAction.done
                                          : TextInputAction.next,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        _ExpiryDateInputFormatter(),
                                      ],
                                      validator: (value) {
                                        final digits = _digitsOnlyText(
                                          value ?? '',
                                        );
                                        if (digits.isEmpty) {
                                          return t.billing_ui.required;
                                        }
                                        if (digits.length != 4) {
                                          return t.billing_ui.mm_yy;
                                        }
                                        final month = int.tryParse(
                                          digits.substring(0, 2),
                                        );
                                        if (month == null ||
                                            month < 1 ||
                                            month > 12) {
                                          return t.billing_ui.invalid_month;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  if (!isLocal) ...[
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _cardField(
                                        controller: _ccvController,
                                        label: t.billing_ui.ccv,
                                        hintText: t.billing_ui.ccv,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        validator: (value) {
                                          final digits = _digitsOnlyText(
                                            value ?? '',
                                          );
                                          if (digits.isEmpty) {
                                            return t.billing_ui.required;
                                          }
                                          if (digits.length < 3) {
                                            return t.billing_ui.invalid;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Bottom actions sit just above the keyboard: the body is
                  // resized to avoid the bottom inset, so the row hugs the
                  // keyboard top. SafeArea adds the home-indicator gap when the
                  // keyboard is hidden.
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: Center(
                              child: AppTextButton(
                                title: t.common.cancel,
                                color: AppColors.black,
                                onTap: () => Navigator.of(context).maybePop(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: AppButtons.primary(
                              title: t.common.confirm,
                              onTap: _submit,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  Widget _cardField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    Widget? trailing,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: Typographies.titleSmall.copyWith(color: AppColors.black),
            ),
            if (trailing != null) ...[const Spacer(), trailing],
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters,
          validator: validator,
          style: Typographies.bodyLarge.copyWith(color: AppColors.black),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Typographies.bodyLarge.copyWith(
              color: AppColors.mutedBlack,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 18,
            ),
            filled: true,
            fillColor: AppColors.lightBg,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999),
              borderSide: BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999),
              borderSide: BorderSide(color: AppColors.black),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999),
              borderSide: BorderSide(color: AppColors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(999),
              borderSide: BorderSide(color: AppColors.red),
            ),
            errorStyle: Typographies.bodySmall.copyWith(color: AppColors.red),
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      if (_autovalidateMode == AutovalidateMode.disabled) {
        setState(() {
          _autovalidateMode = AutovalidateMode.onUserInteraction;
        });
      }
      return;
    }

    final cardNumber = _cardNumberController.text;
    final expiry = _digitsOnlyText(_expiryController.text);
    final month = int.parse(expiry.substring(0, 2));
    final year = int.parse(expiry.substring(2, 4));
    final params = InitBillingCardParams(
      cardNumber: cardNumber,
      expiryMonth: month,
      expiryYear: year,
      cardName: _holderController.text.trim(),
    );

    final cubit = context.read<CardsCubit>();
    // Make the very first card the default one.
    final isDefault = cubit.state.cards.isEmpty;

    final sent = await cubit.startAddCard(params);
    if (!mounted) return;
    if (!sent) {
      context.showAppSnackBar(
        cubit.state.addFailure?.message ?? t.billing_ui.could_not_send_sms_code,
        type: AppSnackBarType.error,
      );
      return;
    }

    final added = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        settings: const RouteSettings(name: '/billing/add-card/otp'),
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: CardOtpPage(
            args: CardOtpArgs(params: params, isDefault: isDefault),
          ),
        ),
      ),
    );

    if (added == true && mounted) {
      Navigator.of(context).pop(); // back to My Cards
    }
  }
}

class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = _digitsOnlyText(newValue.text);
    // Uzbekistan cards are exactly 16 digits — limit input accordingly.
    final limited = digits.length > 16 ? digits.substring(0, 16) : digits;
    final buffer = StringBuffer();

    for (var i = 0; i < limited.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(limited[i]);
    }

    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = _digitsOnlyText(newValue.text);
    final limited = digits.length > 4 ? digits.substring(0, 4) : digits;
    final text = limited.length > 2
        ? '${limited.substring(0, 2)}/${limited.substring(2)}'
        : limited;

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

String _digitsOnlyText(String value) {
  final buffer = StringBuffer();
  for (final codeUnit in value.codeUnits) {
    if (codeUnit >= 48 && codeUnit <= 57) {
      buffer.writeCharCode(codeUnit);
    }
  }

  return buffer.toString();
}
