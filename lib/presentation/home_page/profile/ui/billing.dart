import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_state.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/components/ui_components/title_description_widget.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BillingCubit, BillingState>(
      listenWhen: (previous, current) => previous.failure != current.failure,
      listener: (context, state) {
        final failure = state.failure;
        if (failure == null) {
          return;
        }

        final messenger = ScaffoldMessenger.of(context);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(failure.message)));
      },
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
          child: Text(text, style: Typographies.labelMedium),
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
              _priceRow(t.billing.contact_unlock, _formatUsd(plan?.contactPriceUsd)),
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
                    title: state.isMutating ? t.billing.processing : t.billing.boost_profile,
                    onTap: state.isMutating
                        ? null
                        : () => _showBoostPackages(context, dashboard),
                  ),
                ),
              if (subscription != null) ...[
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: state.isMutating
                      ? null
                      : () => context.read<BillingCubit>().cancelSubscription(),
                  child: Center(
                    child: Text(
                      t.billing.cancel_subscription,
                      style: Typographies.labelLarge.copyWith(
                        color: AppColors.red,
                      ),
                    ),
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
    final cards = dashboard.cards;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        if (index == cards.length) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: state.isMutating ? null : () => _showAddCardSheet(context),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.icAdd),
                    const SizedBox(width: 8),
                    Text(t.billing.add_new_card, style: Typographies.labelLarge),
                  ],
                ),
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
                        t.billing.card_ending_in(cardType: _cardLabel(card.cardType), lastFour: card.lastFour),
                        style: Typographies.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        t.billing.card_expiry(month: card.expiryMonth.toString().padLeft(2, '0'), year: card.expiryYear),
                        style: Typographies.titleSmall.copyWith(
                          color: AppColors.mutedBlack,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(AppAssets.icVisa),
                ],
              ),
              const SizedBox(height: 12),
              Divider(color: AppColors.borderColor),
              const SizedBox(height: 12),
              Row(
                children: [
                  GestureDetector(
                    onTap: state.isMutating
                        ? null
                        : () =>
                              context.read<BillingCubit>().deleteCard(card.id),
                    child: Text(
                      t.billing.delete_card,
                      style: Typographies.titleSmall.copyWith(
                        color: AppColors.red,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: state.isMutating || card.isDefault
                        ? null
                        : () => context.read<BillingCubit>().setDefaultCard(
                            card.id,
                          ),
                    child: Text(
                      card.isDefault ? t.billing.default_card : t.billing.set_default_card,
                      style: Typographies.titleSmall.copyWith(
                        color: card.isDefault
                            ? AppColors.primaryDark
                            : AppColors.black,
                      ),
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
      itemCount: cards.length + 1,
    );
  }

  Widget _buildBillingHistorySection(BillingDashboardEntity dashboard) {
    final transactions = dashboard.transactions;

    if (transactions.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [
          SizedBox(height: 140),
          Center(child: Text('No billing history yet.')),
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
      child: Text(
        t.billing.pay_as_you_go,
        style: Typographies.titleSmall,
      ),
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
    final normalized = (plan.features ?? '')
        .replaceAll('\n', ',')
        .replaceAll(';', ',')
        .replaceAll('|', ',');
    final parsed = normalized
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();

    if (parsed.isNotEmpty) {
      return parsed;
    }

    return [
      'Max offers / month: ${plan.maxOffersPerMonth}',
      'Max finds / month: ${plan.maxFindsPerMonth}',
      'AI matches count: ${plan.aiMatchesCount}',
      'Max shortlist: ${plan.maxShortlist}',
      if (plan.hasFullContactAccess) 'Full contact access',
      if (plan.hasAdvancedAnalytics) 'Advanced analytics',
      if (plan.hasPrioritySupport) 'Priority support',
    ];
  }

  Future<void> _showAddCardSheet(BuildContext context) async {
    final result = await showModalBottomSheet<AddBillingCardParams>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const _AddCardBottomSheet(),
    );

    if (!context.mounted || result == null) {
      return;
    }

    await context.read<BillingCubit>().addCard(result);
  }

  Future<void> _showBoostPackages(
    BuildContext context,
    BillingDashboardEntity dashboard,
  ) async {
    final defaultCard = dashboard.defaultCard;
    if (defaultCard == null) {
      final messenger = ScaffoldMessenger.of(context);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(t.billing.add_payment_card_first)),
        );
      return;
    }

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
                      '${_formatUsd(item.priceUsd)} • ${item.days} days',
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

    await context.read<BillingCubit>().boostProfile(
      BoostProfileParams(
        packageId: package.id,
        paymentMethod: defaultCard.cardType,
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
      return 'Card';
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
              child: AppButtons.primary(title: t.common.try_again, onTap: onRetry),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddCardBottomSheet extends StatefulWidget {
  const _AddCardBottomSheet();

  @override
  State<_AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<_AddCardBottomSheet> {
  final TextEditingController _lastFourController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _gatewayTokenController = TextEditingController();
  String _cardType = 'visa';
  bool _isDefault = true;

  @override
  void dispose() {
    _lastFourController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _gatewayTokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 96,
                decoration: BoxDecoration(
                  color: AppColors.mutedBlack,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(t.billing.add_payment_card, style: Typographies.titleMedium),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _cardType,
              items: const [
                DropdownMenuItem(value: 'visa', child: Text('Visa')),
                DropdownMenuItem(
                  value: 'mastercard',
                  child: Text('Mastercard'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _cardType = value ?? 'visa';
                });
              },
              decoration: InputDecoration(labelText: t.billing.card_type),
            ),
            const SizedBox(height: 12),
            _inputField(
              controller: _lastFourController,
              label: t.billing.last_four_digits,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _inputField(
                    controller: _monthController,
                    label: t.billing.expiry_month,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _inputField(
                    controller: _yearController,
                    label: t.billing.expiry_year,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _inputField(
              controller: _gatewayTokenController,
              label: t.billing.gateway_token,
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t.billing.set_as_default),
              value: _isDefault,
              onChanged: (value) {
                setState(() {
                  _isDefault = value;
                });
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: AppButtons.primary(title: t.billing.save_card, onTap: _submit),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _submit() {
    final month = int.tryParse(_monthController.text.trim());
    final year = int.tryParse(_yearController.text.trim());
    final lastFour = _lastFourController.text.trim();
    final gatewayToken = _gatewayTokenController.text.trim();

    if (month == null ||
        year == null ||
        lastFour.length != 4 ||
        gatewayToken.isEmpty) {
      final messenger = ScaffoldMessenger.of(context);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(t.billing.fill_valid_card_details)),
        );
      return;
    }

    Navigator.of(context).pop(
      AddBillingCardParams(
        cardType: _cardType,
        lastFour: lastFour,
        expiryMonth: month,
        expiryYear: year,
        isDefault: _isDefault,
        gatewayToken: gatewayToken,
      ),
    );
  }
}
