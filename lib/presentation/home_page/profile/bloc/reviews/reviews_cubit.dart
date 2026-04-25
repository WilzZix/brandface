import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/profile/get_influencer_profile_use_case.dart';
import 'package:brandface/domain/usecase/profile/get_influencer_reviews_use_case.dart';
import 'package:brandface/presentation/home_page/profile/bloc/reviews/reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final GetInfluencerProfileUseCase _getInfluencerProfileUseCase;
  final GetInfluencerReviewsUseCase _getInfluencerReviewsUseCase;

  ReviewsCubit({
    required GetInfluencerProfileUseCase getInfluencerProfileUseCase,
    required GetInfluencerReviewsUseCase getInfluencerReviewsUseCase,
  }) : _getInfluencerProfileUseCase = getInfluencerProfileUseCase,
       _getInfluencerReviewsUseCase = getInfluencerReviewsUseCase,
       super(const ReviewsState());

  Future<void> loadReviews({bool force = false}) async {
    if (!force && state.status == ReviewsStatus.loading) {
      return;
    }

    emit(state.copyWith(status: ReviewsStatus.loading, clearFailure: true));

    final profileResult = await _getInfluencerProfileUseCase.call(params: null);

    await profileResult.fold(
      ifLeft: (failure) async =>
          emit(state.copyWith(status: ReviewsStatus.failure, failure: failure)),
      ifRight: (profile) async {
        final reviewsResult = await _getInfluencerReviewsUseCase.call(
          params: profile.id,
        );

        reviewsResult.fold(
          ifLeft: (failure) => emit(
            state.copyWith(
              status: ReviewsStatus.failure,
              failure: failure,
              averageRating: profile.averageRating ?? 0,
              totalReviews: profile.totalReviews,
            ),
          ),
          ifRight: (reviews) => emit(
            state.copyWith(
              status: ReviewsStatus.success,
              reviews: reviews,
              averageRating: profile.averageRating ?? 0,
              totalReviews: profile.totalReviews,
              clearFailure: true,
            ),
          ),
        );
      },
    );
  }
}
