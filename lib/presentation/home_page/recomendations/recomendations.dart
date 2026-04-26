import 'package:brandface/presentation/home_page/offers/bloc/offers_feed_cubit.dart';
import 'package:brandface/presentation/home_page/offers/offer_detail_page.dart';
import 'package:brandface/presentation/home_page/offers/widgets/offers_feed_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Recommendation extends StatelessWidget {
  const Recommendation({super.key});

  static const String tag = '/recommendation-page';

  @override
  Widget build(BuildContext context) {
    return OffersFeedView(
      title: 'Recommendations for you',
      emptyTitle: 'No recommendations yet.',
      emptySubtitle:
          'We will show matching offers here as soon as they are available.',
      onRefresh: () =>
          context.read<OffersFeedCubit>().loadRecommendedOffers(force: true),
      onRetry: () =>
          context.read<OffersFeedCubit>().loadRecommendedOffers(force: true),
      onTapOffer: (offer) =>
          context.pushNamed(OfferDetailPage.tag, extra: offer.id),
    );
  }
}
