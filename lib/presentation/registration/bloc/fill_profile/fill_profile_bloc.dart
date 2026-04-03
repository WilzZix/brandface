import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/registration/fill_profile_info_usecase.dart';
import 'package:brandface/domain/usecase/registration/params/fill_influencer_profile_param.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/usecase/registration/params/fill_profile_request_params.dart';
import '../../../../domain/usecase/registration/registration_usecase.dart';

part 'fill_profile_event.dart';

part 'fill_profile_state.dart';

part 'fill_profile_bloc.freezed.dart';

class FillProfileBloc extends Bloc<FillProfileEvent, FillProfileState> {
  final FillProfileInfoUsecase _fillProfileInfoUsecase;

  FillProfileBloc({required FillProfileInfoUsecase fillProfileInfoUsecase})
    : _fillProfileInfoUsecase = fillProfileInfoUsecase,

      super(const FillProfileState.initial()) {
    on<_FillProfile>(_fillProfile);
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
        emit(FillProfileState.fillingFailure(msg: failure.message));
      },
      ifRight: (_) {
        emit(FillProfileState.filled());
      },
    );
  }
}
