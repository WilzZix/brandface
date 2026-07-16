import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/presentation/home_page/brand/ui/add_payment_method_page.dart';
import 'package:brandface/presentation/home_page/profile/bloc/my_cards/cards_cubit.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/components/card_brand_logo.dart';
import 'package:brandface/uikit/components/default_card_badge.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/extansions/card_mask_x.dart';
import 'package:brandface/utils/extansions/snackbar_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BrandMyCardsPage extends StatelessWidget {
  const BrandMyCardsPage({super.key});

  static const String tag = '/brand-my-cards';

  Future<void> _openAddCard(BuildContext context) async {
    final cubit = context.read<CardsCubit>();
    await context.pushNamed(AddPaymentMethodPage.tag);
    // The add flow owns its own CardsCubit instance, so refresh ours on return.
    await cubit.loadCards(force: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardsCubit, CardsState>(
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
          title: Text(t.billing.my_cards_tab, style: Typographies.titleMedium),
          centerTitle: false,
          actions: [
            GestureDetector(
              onTap: () => _openAddCard(context),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SvgPicture.asset(
                  AppAssets.icAdd,
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<CardsCubit, CardsState>(
          builder: (context, state) {
            if (state.status == CardsStatus.loading && !state.hasCards) {
              return const Center(child: CircularProgressIndicator());
            }
            final cards = state.cards;
            if (cards.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.credit_card_off_outlined,
                      size: 56,
                      color: AppColors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      t.billing_ui.no_cards_added_yet,
                      style: Typographies.bodyMedium.copyWith(
                        color: AppColors.mutedBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _openAddCard(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          t.billing.add_new_card,
                          style: Typographies.labelLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              color: AppColors.black,
              onRefresh: () =>
                  context.read<CardsCubit>().loadCards(force: true),
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
    if (n.isEmpty) return t.billing_ui.card;
    return n[0].toUpperCase() + n.substring(1);
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
                      '${_cardLabel(card.cardType)} • ${card.maskedNumber}',
                      style: Typographies.titleSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      t.billing.card_expiry(
                        month: card.expiryMonth.toString().padLeft(2, '0'),
                        year: card.expiryYear,
                      ),
                      style: Typographies.bodySmall.copyWith(
                        color: AppColors.mutedBlack,
                      ),
                    ),
                  ],
                ),
              ),
              CardBrandLogo(brand: card.cardType, height: 24),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              AppTextButton(
                title: t.billing.delete_card,
                color: AppColors.red,
                textStyle: Typographies.labelMedium,
                onTap: isMutating
                    ? null
                    : () => context.read<CardsCubit>().deleteCard(card.id),
              ),
              const SizedBox(width: 8),
              if (card.isDefault)
                const DefaultCardBadge()
              else
                AppTextButton(
                  title: t.billing.set_default_card,
                  color: AppColors.mutedBlack,
                  textStyle: Typographies.labelMedium,
                  onTap: isMutating
                      ? null
                      : () =>
                            context.read<CardsCubit>().setDefaultCard(card.id),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
