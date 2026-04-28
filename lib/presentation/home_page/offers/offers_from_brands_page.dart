import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/category_entity.dart';
import 'package:brandface/presentation/home_page/offers/bloc/offers_feed_cubit.dart';
import 'package:brandface/presentation/home_page/offers/bloc/offers_feed_state.dart';
import 'package:brandface/presentation/registration/bloc/catalog/category/category_cubit.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'offer_detail_page.dart';

class OffersFromBrandsPage extends StatefulWidget {
  const OffersFromBrandsPage({super.key});

  static const String tag = '/offers-from-brands';

  @override
  State<OffersFromBrandsPage> createState() => _OffersFromBrandsPageState();
}

class _OffersFromBrandsPageState extends State<OffersFromBrandsPage> {
  int? _selectedNicheId;
  String? _selectedNicheLabel;

  @override
  Widget build(BuildContext context) {
    final nicheLabel = _selectedNicheLabel ?? t.common.niche_type;
    return BlocListener<OffersFeedCubit, OffersFeedState>(
      listenWhen: (previous, current) =>
          previous.failure != current.failure &&
          current.failure != null &&
          current.offers.isNotEmpty,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.failure!.message)));
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: Text(t.offer.page_title),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _openNicheSelector(context),
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 24,
                          top: 16,
                          bottom: 16,
                          right: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lightBg2,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                nicheLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Typographies.labelLarge.copyWith(
                                  color: _selectedNicheId == null
                                      ? AppColors.grey
                                      : AppColors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SvgPicture.asset(AppAssets.icArrowDown),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  _ActionButton(assetPath: AppAssets.icSort),
                  const SizedBox(width: 6),
                  _ActionButton(assetPath: AppAssets.icFilter),
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<OffersFeedCubit, OffersFeedState>(
          builder: (context, state) {
            if (state.status == OffersFeedStatus.loading &&
                state.offers.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == OffersFeedStatus.failure &&
                state.offers.isEmpty) {
              return _OffersErrorState(
                failure: state.failure,
                onRetry: () =>
                    context.read<OffersFeedCubit>().loadAvailableOffers(
                      force: true,
                      categoryId: _selectedNicheId,
                    ),
              );
            }

            return RefreshIndicator(
              color: AppColors.black,
              onRefresh: () =>
                  context.read<OffersFeedCubit>().loadAvailableOffers(
                    force: true,
                    categoryId: _selectedNicheId,
                  ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    if (state.status == OffersFeedStatus.loading)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: LinearProgressIndicator(minHeight: 2),
                      ),
                    if (state.offers.isEmpty)
                      _OffersEmptyState(selectedNicheLabel: nicheLabel)
                    else
                      ...List<Widget>.generate(state.offers.length, (index) {
                        final offer = state.offers[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index == state.offers.length - 1 ? 0 : 16,
                          ),
                          child: _OfferCard(
                            offer: offer,
                            onTap: () => context.pushNamed(
                              OfferDetailPage.tag,
                              extra: offer.id,
                            ),
                          ),
                        );
                      }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _openNicheSelector(BuildContext context) async {
    final categoryCubit = context.read<CategoryCubit>();
    final offersFeedCubit = context.read<OffersFeedCubit>();
    var categoryState = categoryCubit.state;

    if (!categoryState.maybeWhen(
      categoryLoaded: (_) => true,
      orElse: () => false,
    )) {
      await categoryCubit.getCategory();
      if (!mounted) {
        return;
      }
      categoryState = categoryCubit.state;
    }

    await categoryState.maybeWhen(
      categoryLoadFailure: (failure) async {
        final messenger = ScaffoldMessenger.of(context);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(failure.message)));
      },
      categoryLoaded: (data) async {
        final selectedNiche = await showModalBottomSheet<CategoryItemEntity?>(
          context: context,
          builder: (bottomSheetContext) {
            return SafeArea(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text(t.offer.all_niches),
                    trailing: _selectedNicheId == null
                        ? Icon(Icons.check, color: AppColors.primaryDark)
                        : null,
                    onTap: () => Navigator.of(bottomSheetContext).pop(null),
                  ),
                  ...data.map(
                    (item) => ListTile(
                      title: Text(item.name),
                      trailing: _selectedNicheId == item.id
                          ? Icon(Icons.check, color: AppColors.primaryDark)
                          : null,
                      onTap: () => Navigator.of(bottomSheetContext).pop(item),
                    ),
                  ),
                ],
              ),
            );
          },
        );

        if (!mounted) {
          return;
        }

        setState(() {
          _selectedNicheId = selectedNiche?.id;
          _selectedNicheLabel = selectedNiche?.name;
        });

        await offersFeedCubit.loadAvailableOffers(
          force: true,
          categoryId: _selectedNicheId,
        );
      },
      orElse: () async {},
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(999),
      ),
      child: SvgPicture.asset(assetPath),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.offer, required this.onTap});

  final OfferSummaryEntity offer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.lightBg3,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(offer.title, style: Typographies.titleMedium),
            const SizedBox(height: 12),
            Text(
              _buildSubtitle(offer),
              style: Typographies.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Divider(color: AppColors.borderColor),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.common.deadline,
                      style: Typographies.titleSmall.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(offer.deadline),
                      style: Typographies.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.registration.categories,
                        style: Typographies.titleSmall.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 24,
                        child: ListView.separated(
                          itemCount: offer.categories.isEmpty
                              ? 1
                              : offer.categories.take(3).length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final category = offer.categories.isEmpty
                                ? 'General'
                                : offer.categories[index];

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.lightBg2,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                category,
                                style: Typographies.labelMedium,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: SvgPicture.asset(AppAssets.icChevronRight),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _buildSubtitle(OfferSummaryEntity offer) {
    final parts = <String>[
      if (offer.brandName.trim().isNotEmpty) offer.brandName.trim(),
      if (_buildRewardText(offer).isNotEmpty) _buildRewardText(offer),
    ];

    if (parts.isEmpty) {
      return t.offer.open_collaboration;
    }

    return parts.join(' • ');
  }

  static String _buildRewardText(OfferSummaryEntity offer) {
    final amount = offer.rewardAmount?.trim();
    final currency = offer.rewardCurrency?.trim();

    if (amount != null && amount.isNotEmpty) {
      final normalizedAmount = amount.endsWith('.00')
          ? amount.substring(0, amount.length - 3)
          : amount;
      return currency == null || currency.isEmpty
          ? normalizedAmount
          : '$normalizedAmount $currency';
    }

    return offer.reward?.trim() ?? '';
  }

  static String _formatDate(DateTime? value) {
    if (value == null) {
      return t.offer.no_deadline;
    }

    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final year = value.year.toString();

    return '$day.$month.$year';
  }
}

class _OffersEmptyState extends StatelessWidget {
  const _OffersEmptyState({required this.selectedNicheLabel});

  final String selectedNicheLabel;

  @override
  Widget build(BuildContext context) {
    final isDefault = selectedNicheLabel == t.common.niche_type;
    final subtitle = isDefault
        ? t.common.pull_refresh_check_soon
        : t.offer.no_offers_for_niche(niche: selectedNicheLabel);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.offer.no_offers_available,
              style: Typographies.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Typographies.bodyMedium.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _OffersErrorState extends StatelessWidget {
  const _OffersErrorState({required this.failure, required this.onRetry});

  final Failure? failure;
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
              failure?.message ?? t.offer.offers_error_load,
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
