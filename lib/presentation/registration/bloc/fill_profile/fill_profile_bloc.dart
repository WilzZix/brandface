import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/registration/fill_profile_info_usecase.dart';
import 'package:brandface/domain/usecase/registration/params/fill_influencer_profile_param.dart';
import 'package:brandface/domain/usecase/registration/update_my_profile_section_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../domain/usecase/registration/params/fill_profile_request_params.dart';

part 'fill_profile_event.dart';

part 'fill_profile_state.dart';

part 'fill_profile_bloc.freezed.dart';

class FillProfileBloc extends Bloc<FillProfileEvent, FillProfileState> {
  final FillProfileInfoUsecase _fillProfileInfoUsecase;
  final UpdateMyProfileSectionUseCase _updateSectionUseCase;

  void setEditMode(bool isEditMode) {
    // Caller decides which event to dispatch; flag retained for compatibility.
  }

  FillProfileBloc({
    required FillProfileInfoUsecase fillProfileInfoUsecase,
    required UpdateMyProfileSectionUseCase updateSectionUseCase,
  }) : _fillProfileInfoUsecase = fillProfileInfoUsecase,
       _updateSectionUseCase = updateSectionUseCase,
       super(const FillProfileState.initial()) {
    on<_FillProfile>(_fillProfile);
    on<_UpdateSection>(_updateSection);
  }

  Future<void> _fillProfile(
    _FillProfile event,
    Emitter<FillProfileState> emit,
  ) async {
    emit(FillProfileState.loading());

    final result = await _fillProfileInfoUsecase.call(
      params: FillProfileParams(
        profileId: event.profile,
        profileData: event.params,
      ),
    );

    result.fold(
      ifLeft: (failure) {
        emit(FillProfileState.fillingFailure(failure: failure));
      },
      ifRight: (_) {
        emit(FillProfileState.filled());
      },
    );
  }

  Future<void> _updateSection(
    _UpdateSection event,
    Emitter<FillProfileState> emit,
  ) async {
    emit(FillProfileState.loading());

    final result = await _updateSectionUseCase.call(
      params: UpdateMyProfileSectionParam(
        section: event.section,
        payload: event.payload,
      ),
    );

    result.fold(
      ifLeft: (failure) =>
          emit(FillProfileState.fillingFailure(failure: failure)),
      ifRight: (_) => emit(FillProfileState.filled()),
    );
  }
}
