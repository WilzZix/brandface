import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';
import 'package:brandface/presentation/home_page/offers/bloc/offers_feed_cubit.dart';
import 'package:brandface/presentation/home_page/offers/bloc/offers_feed_state.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OffersFeedView extends StatelessWidget {
  const OffersFeedView({
    super.key,
    required this.title,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.onRefresh,
    required this.onRetry,
    required this.onTapOffer,
  });

  final String title;
  final String emptyTitle;
  final String emptySubtitle;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetry;
  final ValueChanged<OfferSummaryEntity> onTapOffer;

  @override
  Widget build(BuildContext context) {
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
          title: Text(title),
        ),
        body: BlocBuilder<OffersFeedCubit, OffersFeedState>(
          builder: (context, state) {
            if (state.status == OffersFeedStatus.loading &&
                state.offers.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == OffersFeedStatus.failure &&
                state.offers.isEmpty) {
              return _OffersFeedErrorState(
                failure: state.failure,
                onRetry: onRetry,
              );
            }

            return RefreshIndicator(
              color: AppColors.black,
              onRefresh: onRefresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  if (state.status == OffersFeedStatus.loading)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: LinearProgressIndicator(minHeight: 2),
                    ),
                  if (state.offers.isEmpty)
                    _OffersFeedEmptyState(
                      title: emptyTitle,
                      subtitle: emptySubtitle,
                    )
                  else
                    ..._buildOfferCards(state.offers),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildOfferCards(List<OfferSummaryEntity> offers) {
    return List<Widget>.generate(offers.length, (index) {
      final offer = offers[index];

      return Padding(
        padding: EdgeInsets.only(bottom: index == offers.length - 1 ? 0 : 16),
        child: _OfferSummaryCard(offer: offer, onTap: () => onTapOffer(offer)),
      );
    });
  }
}

class _OfferSummaryCard extends StatelessWidget {
  const _OfferSummaryCard({required this.offer, required this.onTap});

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
              style: Typographies.bodySmall.copyWith(color: AppColors.grey),
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
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            (offer.categories.isEmpty
                                    ? const ['General']
                                    : offer.categories.take(3))
                                .map(
                                  (category) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightBg2,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      category,
                                      style: Typographies.labelMedium,
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
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

    return parts.join(' | ');
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

class _OffersFeedEmptyState extends StatelessWidget {
  const _OffersFeedEmptyState({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
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

class _OffersFeedErrorState extends StatelessWidget {
  const _OffersFeedErrorState({required this.failure, required this.onRetry});

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
