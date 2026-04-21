import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/influencer_profile_information_entity.dart';
import 'package:brandface/domain/usecase/profile/get_influencer_profile_use_case.dart';
import 'package:brandface/utils/services/profile_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_information_state.dart';

part 'profile_information_cubit.freezed.dart';

class ProfileInformationCubit extends Cubit<ProfileInformationState> {
  ProfileInformationCubit({
    required GetInfluencerProfileUseCase influencerProfileUseCase,
    required ProfileService profileService,
  }) : _profileService = profileService,
       _influencerProfileUseCase = influencerProfileUseCase,
       super(const ProfileInformationState.initial());
  final GetInfluencerProfileUseCase _influencerProfileUseCase;
  final ProfileService _profileService;

  Future<void> getInfluencerProfileInformation() async {
    emit(ProfileInformationState.loading());
    final result = await _influencerProfileUseCase.call(params: null);

    result.fold(
      ifLeft: (failure) =>
          emit(ProfileInformationState.failure(failure: failure)),
      ifRight: (data) => emit(ProfileInformationState.infoLoaded(data: data)),
    );
  }
}
