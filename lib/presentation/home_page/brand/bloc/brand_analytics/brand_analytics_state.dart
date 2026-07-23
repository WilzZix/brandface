import 'package:brandface/domain/entities/brand_analytics_entity.dart';
import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';

/// Date window applied to the Offer Performance block.
enum AnalyticsPeriod {
  last7Days('last_7_days'),
  last30Days('last_30_days'),
  allTime('all_time');

  const AnalyticsPeriod(this.apiValue);

  /// Sent as the `period` query parameter.
  final String apiValue;
}

abstract class BrandAnalyticsState {}

class BrandAnalyticsInitial extends BrandAnalyticsState {}

class BrandAnalyticsLoading extends BrandAnalyticsState {}

class BrandAnalyticsLoaded extends BrandAnalyticsState {
  final BrandAnalyticsEntity data;

  /// Active offers the brand can filter the performance block by. Empty when
  /// the offer list could not be fetched — the picker then stays disabled.
  final List<OfferSummaryEntity> offers;

  /// `null` means "all offers".
  final int? selectedOfferId;

  final AnalyticsPeriod period;

  /// True while a re-fetch triggered by the offer/period pickers is in flight,
  /// so the block can dim instead of collapsing back to a spinner.
  final bool isRefreshing;

  BrandAnalyticsLoaded(
    this.data, {
    this.offers = const [],
    this.selectedOfferId,
    this.period = AnalyticsPeriod.last7Days,
    this.isRefreshing = false,
  });

  BrandAnalyticsLoaded copyWith({
    BrandAnalyticsEntity? data,
    List<OfferSummaryEntity>? offers,
    int? selectedOfferId,
    bool clearSelectedOffer = false,
    AnalyticsPeriod? period,
    bool? isRefreshing,
  }) {
    return BrandAnalyticsLoaded(
      data ?? this.data,
      offers: offers ?? this.offers,
      selectedOfferId:
          clearSelectedOffer ? null : (selectedOfferId ?? this.selectedOfferId),
      period: period ?? this.period,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

class BrandAnalyticsFailure extends BrandAnalyticsState {
  final String message;
  BrandAnalyticsFailure(this.message);
}
