import 'package:brandface/domain/entities/offer/offer_detail_entity.dart';
import 'package:brandface/presentation/home_page/offers/bloc/offer_detail_cubit.dart';
import 'package:brandface/presentation/home_page/offers/bloc/offer_detail_state.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../uikit/components/buttons/buttons.dart';
import '../../../../uikit/components/ui_components/app_container.dart';
import '../../../../uikit/components/ui_components/badge.dart';
import '../../../../uikit/components/ui_components/row_title_description.dart';
import '../../../../uikit/components/ui_components/title_description_widget.dart';

class OfferDetailPage extends StatelessWidget {
  const OfferDetailPage({super.key, this.offerId});

  static const String tag = '/offers-detail-page';

  final int? offerId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OfferDetailCubit, OfferDetailState>(
      listenWhen: (previous, current) =>
          (previous.failure != current.failure && current.failure != null) ||
          (!previous.isApplied && current.isApplied),
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);
        if (state.failure != null) {
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.failure!.message)));
        } else if (state.isApplied) {
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Application submitted successfully.'),
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: const Text('Offer details'),
        ),
        body: BlocBuilder<OfferDetailCubit, OfferDetailState>(
          builder: (context, state) {
            if (offerId == null) {
              return const _OfferDetailErrorState(
                title: 'Offer could not be opened.',
                subtitle: 'Offer ID was not provided.',
              );
            }

            if (state.status == OfferDetailStatus.loading &&
                state.offer == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == OfferDetailStatus.failure &&
                state.offer == null) {
              return _OfferDetailErrorState(
                title:
                    state.failure?.message ??
                    'Offer details could not be loaded.',
                subtitle: 'Pull back and try opening the offer again.',
              );
            }

            final offer = state.offer;
            if (offer == null) {
              return const _OfferDetailErrorState(
                title: 'Offer not found.',
                subtitle: 'No detail data is available for this offer.',
              );
            }

            return _OfferDetailBody(offer: offer);
          },
        ),
        bottomNavigationBar: BlocBuilder<OfferDetailCubit, OfferDetailState>(
          builder: (context, state) {
            final offer = state.offer;

            if (offer == null) {
              return const SizedBox.shrink();
            }

            final actionTitle = state.isApplied
                ? 'Applied'
                : state.isApplying
                ? 'Submitting...'
                : 'Apply now';

            return Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(
                  top: BorderSide(color: AppColors.lightBg2, width: 0.5),
                ),
              ),
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: SizedBox(
                height: 56,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(999),
                        onTap: () => Navigator.pop(context),
                        child: Center(
                          child: Text(
                            'Back',
                            style: Typographies.labelLarge.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: IgnorePointer(
                        ignoring: state.isApplied || state.isApplying,
                        child: Opacity(
                          opacity: state.isApplied ? 0.6 : 1,
                          child: AppButtons.primary(
                            title: actionTitle,
                            onTap: () async {
                              final coverLetter = await _showApplyBottomSheet(
                                context,
                              );

                              if (!context.mounted || coverLetter == null) {
                                return;
                              }

                              await context.read<OfferDetailCubit>().apply(
                                coverLetter: coverLetter,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Future<String?> _showApplyBottomSheet(BuildContext context) async {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _ApplyOfferBottomSheet(),
  );
}

class _ApplyOfferBottomSheet extends StatefulWidget {
  const _ApplyOfferBottomSheet();

  @override
  State<_ApplyOfferBottomSheet> createState() => _ApplyOfferBottomSheetState();
}

class _ApplyOfferBottomSheetState extends State<_ApplyOfferBottomSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Text('Apply to this offer', style: Typographies.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Add an optional cover letter for your application.',
              style: Typographies.bodyMedium.copyWith(color: AppColors.grey),
            ),
            const SizedBox(height: 16),
            Text('Cover letter', style: Typographies.titleSmall),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              maxLines: 5,
              minLines: 5,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: 'Write a short message here',
                hintStyle: Typographies.bodyMedium.copyWith(
                  color: AppColors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: AppButtons.primary(
                title: 'Submit application',
                onTap: () {
                  Navigator.of(context).pop(_controller.text.trim());
                },
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(''),
              child: Center(
                child: Text(
                  'Continue without cover letter',
                  style: Typographies.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfferDetailBody extends StatelessWidget {
  const _OfferDetailBody({required this.offer});

  final OfferDetailEntity offer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('General info', style: Typographies.titleSmall),
            const SizedBox(height: 8),
            AppContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleDescriptionWidget(
                    title: 'Offer title',
                    descriptionItem: Text(
                      offer.title,
                      style: Typographies.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TitleDescriptionWidget(
                    title: 'Brand',
                    descriptionItem: Text(
                      offer.brandName,
                      style: Typographies.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TitleDescriptionWidget(
                    title: 'Categories',
                    descriptionItem: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: offer.categories.isEmpty
                          ? [const AppBadge(title: 'No category')]
                          : offer.categories
                                .map((item) => AppBadge(title: item))
                                .toList(),
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
                    title: 'Region',
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
                      offer.requiredGender == null
                          ? null
                          : _capitalize(offer.requiredGender!),
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
                    title: 'Reward',
                    description: _rewardText(offer),
                  ),
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
                  ),
                  RowTitleDescription(
                    title: 'Views',
                    description: offer.viewsCount.toString(),
                  ),
                  RowTitleDescription(
                    title: 'Applications',
                    description: offer.applicationsCount.toString(),
                    showDivider: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _listOrFallback(List<String> values) {
    if (values.isEmpty) {
      return 'Any';
    }

    return values.join(', ');
  }

  String _intOrFallback(int? value) {
    if (value == null) {
      return 'Any';
    }

    return value.toString();
  }

  String _valueOrFallback(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return 'Not specified';
    }

    return trimmed;
  }

  String _capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }

    return value[0].toUpperCase() + value.substring(1);
  }

  String _rewardText(OfferDetailEntity offer) {
    final amount = offer.rewardAmount?.trim();
    final currency = offer.rewardCurrency?.trim();
    final reward = offer.reward?.trim();

    if (amount != null && amount.isNotEmpty) {
      return [
        amount,
        if (currency != null && currency.isNotEmpty) currency,
      ].join(' ');
    }

    if (reward != null && reward.isNotEmpty) {
      return reward;
    }

    return 'Not specified';
  }

  String _formatDate(DateTime? value) {
    if (value == null) {
      return 'Open';
    }

    final local = value.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = local.month.toString().padLeft(2, '0');
    final year = local.year.toString();
    return '$day.$month.$year';
  }
}

class _OfferDetailErrorState extends StatelessWidget {
  const _OfferDetailErrorState({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Typographies.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
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
