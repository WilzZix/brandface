import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/presentation/home_page/brand/ui/add_payment_method_page.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_state.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/extansions/snackbar_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BrandMyCardsPage extends StatelessWidget {
  const BrandMyCardsPage({super.key});

  static const String tag = '/brand-my-cards';

  @override
  Widget build(BuildContext context) {
    return BlocListener<BillingCubit, BillingState>(
      listenWhen: (p, c) => p.failure != c.failure && c.failure != null,
      listener: (context, state) {
        context.showAppSnackBar(
          state.failure!.message,
          type: AppSnackBarType.error,
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBg,
        appBar: AppBar(
          backgroundColor: AppColors.lightBg,
          scrolledUnderElevation: 0,
          title: Text('My cards', style: Typographies.titleMedium),
          centerTitle: false,
          actions: [
            GestureDetector(
              onTap: () => context.pushNamed(AddPaymentMethodPage.tag),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SvgPicture.asset(AppAssets.icAdd,
                    width: 22, height: 22, colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn)),
              ),
            ),
          ],
        ),
        body: BlocBuilder<BillingCubit, BillingState>(
          builder: (context, state) {
            if (state.status == BillingStatus.loading && state.dashboard == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final cards = state.dashboard?.cards ?? [];
            if (cards.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.credit_card_off_outlined,
                        size: 56, color: AppColors.grey),
                    const SizedBox(height: 16),
                    Text('No cards added yet',
                        style: Typographies.bodyMedium
                            .copyWith(color: AppColors.mutedBlack)),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => context.pushNamed(AddPaymentMethodPage.tag),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text('Add new card',
                            style: Typographies.labelLarge),
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              color: AppColors.black,
              onRefresh: () =>
                  context.read<BillingCubit>().loadBilling(force: true),
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                itemCount: cards.length,
                separatorBuilder: (ctx, i) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _CardTile(
                    card: cards[index],
                    isMutating: state.isMutating,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card tile
// ─────────────────────────────────────────────────────────────────────────────

class _CardTile extends StatelessWidget {
  const _CardTile({required this.card, required this.isMutating});
  final BillingCardEntity card;
  final bool isMutating;

  String _cardLabel(String type) {
    final n = type.trim().toLowerCase();
    if (n.isEmpty) return 'Card';
    return n[0].toUpperCase() + n.substring(1);
  }

  Widget _cardLogo(String type) {
    final n = type.trim().toLowerCase();
    if (n.contains('visa')) {
      return SvgPicture.asset(AppAssets.icVisa, height: 20);
    }
    if (n.contains('master')) {
      return _MastercardLogo();
    }
    return Icon(Icons.credit_card_rounded,
        size: 28, color: AppColors.mutedBlack);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_cardLabel(card.cardType)} ending in ${card.lastFour}',
                      style: Typographies.titleSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Expiry ${card.expiryMonth.toString().padLeft(2, '0')}/${card.expiryYear}',
                      style: Typographies.bodySmall
                          .copyWith(color: AppColors.mutedBlack),
                    ),
                  ],
                ),
              ),
              _cardLogo(card.cardType),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: isMutating
                    ? null
                    : () => context.read<BillingCubit>().deleteCard(card.id),
                child: Text(
                  'Delete',
                  style: Typographies.labelMedium
                      .copyWith(color: AppColors.red),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () => context.pushNamed(
                  AddPaymentMethodPage.tag,
                  extra: card,
                ),
                child: Text(
                  'Edit',
                  style: Typographies.labelMedium
                      .copyWith(color: AppColors.mutedBlack),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MastercardLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 26,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 26,
              height: 26,
              decoration: const BoxDecoration(
                color: Color(0xFFEB001B),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: const Color(0xFFF79E1B).withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
