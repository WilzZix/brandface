import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/domain/usecase/profile/get_influencer_profile_use_case.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_state.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/extansions/snackbar_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum _TopProfileTab { top, vip, history }

class TopProfilePage extends StatefulWidget {
  const TopProfilePage({super.key});

  static const String tag = '/top-profile';

  @override
  State<TopProfilePage> createState() => _TopProfilePageState();
}

class _TopProfilePageState extends State<TopProfilePage> {
  _TopProfileTab _selectedTab = _TopProfileTab.top;
  bool _isProfileLoading = true;
  bool _isTopActive = false;
  DateTime? _topExpiresAt;
  int? _selectedBoostPackageId;
  int? _selectedVipPlanId;
  BillingCardEntity? _selectedCard;

  @override
  void initState() {
    super.initState();
    _loadProfileStatus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BillingCubit, BillingState>(
      listenWhen: (previous, current) =>
          previous.failure != current.failure ||
          (previous.isMutating && !current.isMutating),
      listener: (context, state) {
        final failure = state.failure;
        if (failure != null) {
          context.showAppSnackBar(
            failure.message,
            type: AppSnackBarType.error,
          );
          return;
        }

        if (!state.isMutating) {
          _loadProfileStatus();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBg,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.lightBg,

          titleSpacing: 4,
          title: Text(_appBarTitle, style: Typographies.titleLarge),
        ),
        body: BlocBuilder<BillingCubit, BillingState>(
          builder: (context, state) {
            final dashboard = state.dashboard;

            if ((state.status == BillingStatus.loading || _isProfileLoading) &&
                dashboard == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == BillingStatus.failure && dashboard == null) {
              return _TopProfileErrorState(
                onRetry: () async {
                  await context.read<BillingCubit>().loadBilling(force: true);
                  await _loadProfileStatus();
                },
              );
            }

            final safeDashboard = dashboard ?? const BillingDashboardEntity();
            _primeDefaults(safeDashboard);

            return RefreshIndicator(
              color: AppColors.black,
              onRefresh: () async {
                await context.read<BillingCubit>().loadBilling(force: true);
                await _loadProfileStatus();
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  MediaQuery.of(context).padding.bottom + 20,
                ),
                children: [
                  _buildTabSelector(),
                  const SizedBox(height: 16),
                  if (state.status == BillingStatus.loading)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: LinearProgressIndicator(minHeight: 2),
                    ),
                  _buildCurrentTab(
                    context,
                    dashboard: safeDashboard,
                    state: state,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String get _appBarTitle => _selectedTab == _TopProfileTab.history
      ? 'Billing'
      : 'Make the profile TOP';

  Future<void> _loadProfileStatus() async {
    if (mounted) {
      setState(() {
        _isProfileLoading = true;
      });
    }

    final result = await sl<GetInfluencerProfileUseCase>().call(params: null);

    if (!mounted) {
      return;
    }

    result.fold(
      ifLeft: (_) {
        setState(() {
          _isProfileLoading = false;
        });
      },
      ifRight: (profile) {
        setState(() {
          _isProfileLoading = false;
          _isTopActive = profile.isTop;
          _topExpiresAt = profile.topExpiresAt;
        });
      },
    );
  }

  void _primeDefaults(BillingDashboardEntity dashboard) {
    _selectedCard ??= dashboard.defaultCard;
    _selectedBoostPackageId ??= dashboard.boostPackages.isNotEmpty
        ? dashboard.boostPackages.first.id
        : null;
    _selectedVipPlanId ??= dashboard.plans.isNotEmpty
        ? dashboard.plans.first.id
        : null;
  }

  Widget _buildTabSelector() {
    return Row(
      children: [
        _TopTabChip(
          title: 'TOP',
          isSelected: _selectedTab == _TopProfileTab.top,
          onTap: () => setState(() => _selectedTab = _TopProfileTab.top),
        ),
        const SizedBox(width: 8),
        _TopTabChip(
          title: 'VIP',
          isSelected: _selectedTab == _TopProfileTab.vip,
          onTap: () => setState(() => _selectedTab = _TopProfileTab.vip),
        ),
        const SizedBox(width: 8),
        _TopTabChip(
          title: 'Billing history',
          isSelected: _selectedTab == _TopProfileTab.history,
          onTap: () => setState(() => _selectedTab = _TopProfileTab.history),
        ),
      ],
    );
  }

  Widget _buildCurrentTab(
    BuildContext context, {
    required BillingDashboardEntity dashboard,
    required BillingState state,
  }) {
    switch (_selectedTab) {
      case _TopProfileTab.top:
        return _buildTopTab(context, dashboard: dashboard, state: state);
      case _TopProfileTab.vip:
        return _buildVipTab(context, dashboard: dashboard, state: state);
      case _TopProfileTab.history:
        return _buildHistoryTab(dashboard);
    }
  }

  Widget _buildTopTab(
    BuildContext context, {
    required BillingDashboardEntity dashboard,
    required BillingState state,
  }) {
    return AppContainer(
      child: _isTopActive
          ? _ActiveStatusCard(
              title: 'TOP is active',
              expirationDate: _formatExpirationDate(_topExpiresAt),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatusPill(
                  title: 'TOP is not activated',
                  color: AppColors.red,
                ),
                const SizedBox(height: 20),
                ...dashboard.boostPackages.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _SelectableRow(
                      title: _formatBoostPackage(item),
                      isSelected: _selectedBoostPackageId == item.id,
                      onTap: () {
                        setState(() {
                          _selectedBoostPackageId = item.id;
                        });
                      },
                    ),
                  ),
                ),
                Divider(height: 32, color: AppColors.borderColor),
                _BottomActionRow(
                  selectorTitle: _selectedCard == null
                      ? 'Select payment method'
                      : _cardDisplayLabel(_selectedCard!),
                  onSelectorTap: () => _pickPaymentMethod(context, dashboard),
                  buttonTitle: state.isMutating ? 'Processing...' : 'Activate',
                  onButtonTap: state.isMutating
                      ? null
                      : () => _activateTop(context, dashboard),
                ),
              ],
            ),
    );
  }

  Widget _buildVipTab(
    BuildContext context, {
    required BillingDashboardEntity dashboard,
    required BillingState state,
  }) {
    final subscription = dashboard.subscription;
    final isVipActive = subscription?.isActive == true;

    return AppContainer(
      child: isVipActive
          ? _ActiveStatusCard(
              title: 'VIP is active',
              expirationDate: _formatExpirationDate(subscription?.expiresAt),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatusPill(
                  title: 'VIP is not activated',
                  color: AppColors.red,
                ),
                const SizedBox(height: 20),
                ...dashboard.plans
                    .take(2)
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _SelectableRow(
                          title: _formatPlan(item),
                          isSelected: _selectedVipPlanId == item.id,
                          onTap: () {
                            setState(() {
                              _selectedVipPlanId = item.id;
                            });
                          },
                        ),
                      ),
                    ),
                Divider(height: 32, color: AppColors.borderColor),
                _BottomActionRow(
                  selectorTitle: _selectedCard == null
                      ? 'Select payment method'
                      : _cardDisplayLabel(_selectedCard!),
                  onSelectorTap: () => _pickPaymentMethod(context, dashboard),
                  buttonTitle: state.isMutating ? 'Processing...' : 'Activate',
                  onButtonTap: state.isMutating
                      ? null
                      : () => _activateVip(context, dashboard),
                ),
              ],
            ),
    );
  }

  Widget _buildHistoryTab(BillingDashboardEntity dashboard) {
    final transactions = dashboard.transactions;

    if (transactions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 120),
        child: Center(child: Text('No billing history yet.')),
      );
    }

    return Column(
      children: transactions
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoice #${item.id}',
                      style: Typographies.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description?.trim().isNotEmpty == true
                          ? item.description!
                          : item.planName ?? 'Billing transaction',
                      style: Typographies.bodySmall.copyWith(
                        color: AppColors.mutedBlack,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HistoryField(
                          title: 'Issue date',
                          value: _formatShortDate(item.createdAt),
                        ),
                        _HistoryField(
                          title: 'Amount',
                          value: _formatAmount(item.amount, item.currency),
                        ),
                        _HistoryField(
                          title: 'Receipt',
                          value: 'Download',
                          valueColor: AppColors.primaryDark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Future<void> _pickPaymentMethod(
    BuildContext context,
    BillingDashboardEntity dashboard,
  ) async {
    if (dashboard.cards.isEmpty) {
      context.showAppSnackBar('Add a payment card first.');
      return;
    }

    final selected = await showModalBottomSheet<BillingCardEntity>(
      context: context,
      useSafeArea: true,
      backgroundColor: AppColors.lightBg,
      builder: (bottomSheetContext) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: dashboard.cards
                .map(
                  (card) => ListTile(
                    title: Text(_cardDisplayLabel(card)),
                    subtitle: Text(
                      'Expiry ${card.expiryMonth.toString().padLeft(2, '0')}/${card.expiryYear}',
                    ),
                    trailing: card.isDefault
                        ? Text(
                            'Default',
                            style: Typographies.bodySmall.copyWith(
                              color: AppColors.primaryDark,
                            ),
                          )
                        : null,
                    onTap: () => Navigator.of(bottomSheetContext).pop(card),
                  ),
                )
                .toList(),
          ),
        );
      },
    );

    if (!mounted || selected == null) {
      return;
    }

    setState(() {
      _selectedCard = selected;
    });
  }

  Future<void> _activateTop(
    BuildContext context,
    BillingDashboardEntity dashboard,
  ) async {
    if (_selectedBoostPackageId == null) {
      _showMessage(context, 'Select a TOP package first.');
      return;
    }

    final card = _selectedCard ?? dashboard.defaultCard;
    if (card == null) {
      _showMessage(context, 'Select a payment method first.');
      return;
    }

    await context.read<BillingCubit>().boostProfile(
      BoostProfileParams(
        packageId: _selectedBoostPackageId!,
        paymentMethod: card.cardType,
      ),
    );
  }

  Future<void> _activateVip(
    BuildContext context,
    BillingDashboardEntity dashboard,
  ) async {
    if (_selectedVipPlanId == null) {
      _showMessage(context, 'Select a VIP plan first.');
      return;
    }

    final card = _selectedCard ?? dashboard.defaultCard;
    if (card == null) {
      _showMessage(context, 'Select a payment method first.');
      return;
    }

    await context.read<BillingCubit>().subscribeToPlan(
      SubscribeBillingPlanParams(
        planId: _selectedVipPlanId!,
        paymentMethod: card.cardType,
        cardId: card.id,
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    context.showAppSnackBar(message);
  }

  static String _formatBoostPackage(BillingBoostPackageEntity item) {
    final price = item.priceUzs?.trim();
    final fallback = item.priceUsd?.trim();
    final amount = (price != null && price.isNotEmpty)
        ? '$price UZS'
        : (fallback != null && fallback.isNotEmpty
              ? '$fallback USD'
              : item.label);
    return '${item.days} days / $amount';
  }

  static String _formatPlan(BillingPlanEntity item) {
    final price = item.priceMonthlyUsd?.trim();
    if (price == null || price.isEmpty) {
      return item.name;
    }

    return '${_capitalize(item.name)} / $price USD';
  }

  static String _cardDisplayLabel(BillingCardEntity card) {
    return '${_capitalize(card.cardType)} • ${card.name}';
  }

  static String _formatExpirationDate(DateTime? value) {
    if (value == null) {
      return 'Unknown';
    }

    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final year = value.year.toString();
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');

    return '$hour:$minute $day.$month.$year';
  }

  static String _formatShortDate(DateTime? value) {
    if (value == null) {
      return 'Unknown';
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

    return '${value.day} ${monthNames[value.month - 1]} ${value.year}';
  }

  static String _formatAmount(String? amount, String? currency) {
    final safeAmount = amount?.trim();
    final safeCurrency = currency?.trim();
    if (safeAmount == null || safeAmount.isEmpty) {
      return 'Unknown';
    }
    if (safeCurrency == null || safeCurrency.isEmpty) {
      return safeAmount;
    }
    return '$safeAmount $safeCurrency';
  }

  static String _capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }

    return value[0].toUpperCase() + value.substring(1);
  }
}

class _TopTabChip extends StatelessWidget {
  const _TopTabChip({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            border: isSelected
                ? null
                : Border.all(color: AppColors.borderColor),
          ),
          child: Text(title, style: Typographies.labelMedium),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: Typographies.labelLarge.copyWith(color: AppColors.white),
      ),
    );
  }
}

class _SelectableRow extends StatelessWidget {
  const _SelectableRow({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Typographies.titleLarge.copyWith(
                fontSize: 18,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 32,
            height: 32,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryDark
                    : AppColors.borderColor,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActionRow extends StatelessWidget {
  const _BottomActionRow({
    required this.selectorTitle,
    required this.onSelectorTap,
    required this.buttonTitle,
    required this.onButtonTap,
  });

  final String selectorTitle;
  final VoidCallback onSelectorTap;
  final String buttonTitle;
  final VoidCallback? onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onSelectorTap,
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.lightBg2,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      selectorTitle,
                      style: Typographies.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(AppAssets.icArrowDown),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 120,
          height: 56,
          child: AppButtons.primary(title: buttonTitle, onTap: onButtonTap),
        ),
      ],
    );
  }
}

class _ActiveStatusCard extends StatelessWidget {
  const _ActiveStatusCard({required this.title, required this.expirationDate});

  final String title;
  final String expirationDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatusPill(title: title, color: AppColors.primaryDark),
        const SizedBox(height: 12),
        Text(
          'Expiration date',
          style: Typographies.bodySmall.copyWith(color: AppColors.grey),
        ),
        const SizedBox(height: 4),
        Text(expirationDate, style: Typographies.bodyMedium),
      ],
    );
  }
}

class _HistoryField extends StatelessWidget {
  const _HistoryField({
    required this.title,
    required this.value,
    this.valueColor,
  });

  final String title;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Typographies.bodySmall.copyWith(color: AppColors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Typographies.bodySmall.copyWith(
            color: valueColor ?? AppColors.black,
          ),
        ),
      ],
    );
  }
}

class _TopProfileErrorState extends StatelessWidget {
  const _TopProfileErrorState({required this.onRetry});

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
              'TOP profile data could not be loaded.',
              style: Typographies.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Pull to refresh or try again.',
              style: Typographies.bodyMedium.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 170,
              child: AppButtons.primary(title: 'Try again', onTap: onRetry),
            ),
          ],
        ),
      ),
    );
  }
}
