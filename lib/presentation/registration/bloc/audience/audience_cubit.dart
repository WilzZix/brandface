import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/social_media_account_stats_entity.dart';
import 'package:brandface/domain/usecase/profile/get_social_media_account_stats_use_case.dart';
import 'package:brandface/domain/usecase/profile/params/social_medi_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'audience_state.dart';

part 'audience_cubit.freezed.dart';

class AudienceCubit extends Cubit<AudienceState> {
  AudienceCubit({
    required GetSocialMediaAccountStatsUseCase accountStatsUseCase,
  }) : _accountStatsUseCase = accountStatsUseCase,
       super(const AudienceState.initial());
  final GetSocialMediaAccountStatsUseCase _accountStatsUseCase;

  Future<void> getSocialMediaAccountStats({
    required String platform,
    required String username,
  }) async {
    emit(AudienceState.loading());
    final result = await _accountStatsUseCase.call(
      params: SocialMediaParams(platform: platform, username: username),
    );

    result.fold(
      ifLeft: (failure) {
        emit(AudienceState.failure(failure: failure));
      },
      ifRight: (data) {
        emit(AudienceState.loaded(data: data));
      },
    );
  }
}
