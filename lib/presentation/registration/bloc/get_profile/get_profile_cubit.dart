import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/profile_entity.dart';
import 'package:brandface/domain/usecase/profile/get_influencer_profile_use_case.dart';
import 'package:brandface/domain/usecase/profile/get_profile_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_profile_state.dart';

part 'get_profile_cubit.freezed.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit({
    required GetProfileUseCase getProfileUseCase,
    required GetInfluencerProfileUseCase getInfluencerProfileUseCase,
  })  : _getProfileUseCase = getProfileUseCase,
        _getInfluencerProfileUseCase = getInfluencerProfileUseCase,
        super(const GetProfileState.initial());

  final GetProfileUseCase _getProfileUseCase;
  final GetInfluencerProfileUseCase _getInfluencerProfileUseCase;

  Future<void> getProfile({required String profileId}) async {
    emit(GetProfileState.profileLoading());
    final result = await _getProfileUseCase.call(params: profileId);
    result.fold(
      ifLeft: (fl) => emit(GetProfileState.profileLoadFailure(fl: fl)),
      ifRight: (data) => emit(GetProfileState.profileLoaded(profile: data)),
    );
  }

  Future<void> getMyProfile() async {
    emit(GetProfileState.profileLoading());
    final result = await _getInfluencerProfileUseCase.call(params: null);
    result.fold(
      ifLeft: (fl) => emit(GetProfileState.profileLoadFailure(fl: fl)),
      ifRight: (data) =>
          emit(GetProfileState.profileLoaded(profile: data.toProfileEntity())),
    );
  }
}
