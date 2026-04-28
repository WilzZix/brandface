import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/home_page/profile/bloc/reviews/reviews_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/reviews/reviews_state.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/components/ui_components/title_description_widget.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  static const String tag = '/reviews';

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewsCubit, ReviewsState>(
      listenWhen: (previous, current) =>
          previous.failure != current.failure &&
          current.failure != null &&
          current.reviews.isNotEmpty,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.failure!.message)));
      },
      child: Scaffold(
        appBar: AppBar(title: Text(t.reviews.title), centerTitle: false),
        body: BlocBuilder<ReviewsCubit, ReviewsState>(
          builder: (context, state) {
            if (state.status == ReviewsStatus.loading &&
                state.reviews.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == ReviewsStatus.failure &&
                state.reviews.isEmpty) {
              return _ReviewsErrorState(
                message:
                    state.failure?.message ?? t.reviews.error_load,
                onRetry: () =>
                    context.read<ReviewsCubit>().loadReviews(force: true),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(t.reviews.average, style: Typographies.titleLarge),
                  const SizedBox(height: 8),
                  AppContainer(
                    child: Row(
                      children: [
                        SvgPicture.asset(AppAssets.icStar),
                        const SizedBox(width: 8),
                        Text(
                          _formatAverage(state.averageRating),
                          style: Typographies.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(t.reviews.client_reviews, style: Typographies.titleLarge),
                  const SizedBox(height: 8),
                  Expanded(
                    child: RefreshIndicator(
                      color: AppColors.black,
                      onRefresh: () =>
                          context.read<ReviewsCubit>().loadReviews(force: true),
                      child: state.reviews.isEmpty
                          ? ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: const [
                                SizedBox(height: 120),
                                Center(child: Text('No reviews yet.')),
                              ],
                            )
                          : ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final review = state.reviews[index];
                                return AppContainer(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(AppAssets.icStar),
                                          const SizedBox(width: 8),
                                          Text(
                                            review.rating.toString(),
                                            style: Typographies.titleLarge,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        review.text.isEmpty
                                            ? t.reviews.no_review_text
                                            : review.text,
                                        style: Typographies.bodySmall,
                                      ),
                                      const SizedBox(height: 12),
                                      const Divider(),
                                      const SizedBox(height: 12),
                                      TitleDescriptionWidget(
                                        title: review.reviewerName,
                                        descriptionItem: Text(
                                          _formatReviewDate(review.createdAt),
                                          style: Typographies.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 8),
                              itemCount: state.reviews.length,
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  static String _formatAverage(double value) {
    return value.toStringAsFixed(2);
  }

  static String _formatReviewDate(DateTime? value) {
    if (value == null) {
      return t.common.unknown_date;
    }

    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final year = value.year.toString();

    return '$day.$month.$year';
  }
}

class _ReviewsErrorState extends StatelessWidget {
  const _ReviewsErrorState({required this.message, required this.onRetry});

  final String message;
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
              message,
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
