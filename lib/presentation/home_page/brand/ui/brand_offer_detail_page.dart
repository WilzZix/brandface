import 'package:brandface/domain/entities/offer/offer_detail_entity.dart';
import 'package:brandface/presentation/home_page/offers/bloc/offer_detail_cubit.dart';
import 'package:brandface/presentation/home_page/offers/bloc/offer_detail_state.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/components/ui_components/badge.dart';
import 'package:brandface/uikit/components/ui_components/row_title_description.dart';
import 'package:brandface/uikit/components/ui_components/title_description_widget.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandOfferDetailPage extends StatelessWidget {
  const BrandOfferDetailPage({super.key, required this.offerId});

  static const String tag = '/brand-offer-detail';

  final int offerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Collaboration offer details'),
      ),
      body: BlocBuilder<OfferDetailCubit, OfferDetailState>(
        builder: (context, state) {
          if (state.status == OfferDetailStatus.loading && state.offer == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == OfferDetailStatus.failure && state.offer == null) {
            return Center(
              child: Text(
                state.failure?.message ?? 'Failed to load offer.',
                style: Typographies.bodyMedium.copyWith(color: AppColors.grey),
                textAlign: TextAlign.center,
              ),
            );
          }

          final offer = state.offer;
          if (offer == null) return const SizedBox.shrink();

          return _BrandOfferDetailBody(offer: offer);
        },
      ),
      bottomNavigationBar: BlocBuilder<OfferDetailCubit, OfferDetailState>(
        builder: (context, state) {
          if (state.offer == null) return const SizedBox.shrink();
          return _BottomActionBar();
        },
      ),
    );
  }
}

class _BrandOfferDetailBody extends StatelessWidget {
  const _BrandOfferDetailBody({required this.offer});

  final OfferDetailEntity offer;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StatCardsRow(offer: offer),
          const SizedBox(height: 24),
          Text('General info', style: Typographies.titleSmall),
          const SizedBox(height: 8),
          AppContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleDescriptionWidget(
                  title: 'Offer title',
                  descriptionItem: Text(offer.title, style: Typographies.bodyMedium),
                ),
                const SizedBox(height: 16),
                TitleDescriptionWidget(
                  title: 'Niches',
                  descriptionItem: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: offer.categories.isEmpty
                        ? [const AppBadge(title: 'No category')]
                        : offer.categories.map((c) => AppBadge(title: c)).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                TitleDescriptionWidget(
                  title: 'Description',
                  descriptionItem: Text(
                    _valueOrFallback(offer.description),
                    style: Typographies.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),
                TitleDescriptionWidget(
                  title: 'Status',
                  descriptionItem: Text(
                    _capitalize(offer.status),
                    style: Typographies.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Requirements', style: Typographies.titleSmall),
          const SizedBox(height: 8),
          AppContainer(
            child: Column(
              children: [
                RowTitleDescription(
                  title: 'Country',
                  description: _valueOrFallback(offer.requiredRegion),
                ),
                RowTitleDescription(
                  title: 'City',
                  description: _valueOrFallback(offer.requiredCity),
                ),
                RowTitleDescription(
                  title: 'Followers max',
                  description: _intOrFallback(offer.requiredFollowersMax),
                ),
                RowTitleDescription(
                  title: 'Followers min',
                  description: _intOrFallback(offer.requiredFollowersMin),
                ),
                RowTitleDescription(
                  title: 'Languages',
                  description: _listOrFallback(offer.requiredLanguages),
                ),
                RowTitleDescription(
                  title: 'Engagement rate',
                  description: _valueOrFallback(offer.requiredEngagementRate),
                ),
                RowTitleDescription(
                  title: 'Content type',
                  description: _listOrFallback(offer.requiredContentTypes),
                ),
                RowTitleDescription(
                  title: 'Gender',
                  description: _valueOrFallback(
                    offer.requiredGender == null ? null : _capitalize(offer.requiredGender!),
                  ),
                  showDivider: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Collaboration details', style: Typographies.titleSmall),
          const SizedBox(height: 8),
          AppContainer(
            child: Column(
              children: [
                RowTitleDescription(
                  title: 'Duration',
                  description: _valueOrFallback(offer.duration),
                ),
                RowTitleDescription(
                  title: 'Deadline',
                  description: _formatDate(offer.deadline),
                ),
                RowTitleDescription(
                  title: 'Visibility',
                  description: _capitalize(offer.visibility),
                  showDivider: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _valueOrFallback(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return 'Not specified';
    return trimmed;
  }

  String _intOrFallback(int? value) => value?.toString() ?? 'Any';

  String _listOrFallback(List<String> values) =>
      values.isEmpty ? 'Any' : values.join(', ');

  String _capitalize(String value) =>
      value.isEmpty ? value : value[0].toUpperCase() + value.substring(1);

  String _formatDate(DateTime? value) {
    if (value == null) return 'Open';
    final local = value.toLocal();
    final d = local.day.toString().padLeft(2, '0');
    final m = local.month.toString().padLeft(2, '0');
    return '$d.$m.${local.year}';
  }
}

class _StatCardsRow extends StatelessWidget {
  const _StatCardsRow({required this.offer});

  final OfferDetailEntity offer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Views',
            value: _formatCount(offer.viewsCount),
            showArrow: false,
            highlighted: false,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // TODO: navigate to applications list
            },
            child: _StatCard(
              label: 'Applications',
              value: _formatCount(offer.applicationsCount),
              showArrow: true,
              highlighted: true,
            ),
          ),
        ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.showArrow,
    required this.highlighted,
  });

  final String label;
  final String value;
  final bool showArrow;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlighted ? AppColors.lightGreen : AppColors.lightBg3,
        borderRadius: BorderRadius.circular(16),
        border: highlighted
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.4))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                value,
                style: Typographies.titleMedium.copyWith(
                  color: highlighted ? AppColors.primaryDark : AppColors.black,
                ),
              ),
              if (showArrow) ...[
                const SizedBox(width: 4),
                Icon(Icons.chevron_right, color: AppColors.primaryDark, size: 20),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.borderColor, width: 0.5)),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      child: Row(
        children: [
          _ActionButton(
            icon: Icons.delete_outline,
            color: AppColors.red,
            onTap: () {
              // TODO: delete offer
            },
          ),
          const SizedBox(width: 12),
          _ActionButton(
            icon: Icons.content_copy_outlined,
            color: AppColors.mutedBlack,
            onTap: () {
              // TODO: duplicate offer
            },
          ),
          const SizedBox(width: 12),
          _ActionButton(
            icon: Icons.edit_outlined,
            color: AppColors.mutedBlack,
            onTap: () {
              // TODO: edit offer
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // TODO: complete offer
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, color: AppColors.primaryDark, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      'Complete',
                      style: Typographies.labelMedium.copyWith(
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color == AppColors.red
              ? AppColors.red.withValues(alpha: 0.1)
              : AppColors.lightBg3,
          borderRadius: BorderRadius.circular(12),
          border: color == AppColors.red
              ? Border.all(color: AppColors.red.withValues(alpha: 0.3))
              : Border.all(color: AppColors.borderColor),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }
}
