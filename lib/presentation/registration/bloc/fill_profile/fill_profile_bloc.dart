import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/registration/fill_profile_info_usecase.dart';
import 'package:brandface/domain/usecase/registration/params/fill_influencer_profile_param.dart';
import 'package:brandface/domain/usecase/registration/update_my_profile_usecase.dart';
import 'package:dart_either/dart_either.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../domain/usecase/registration/params/fill_profile_request_params.dart';

part 'fill_profile_event.dart';

part 'fill_profile_state.dart';

part 'fill_profile_bloc.freezed.dart';

class FillProfileBloc extends Bloc<FillProfileEvent, FillProfileState> {
  final FillProfileInfoUsecase _fillProfileInfoUsecase;
  final UpdateMyProfileUsecase _updateMyProfileUsecase;

  bool _isEditMode = false;

  void setEditMode(bool isEditMode) {
    _isEditMode = isEditMode;
  }

  FillProfileBloc({
    required FillProfileInfoUsecase fillProfileInfoUsecase,
    required UpdateMyProfileUsecase updateMyProfileUsecase,
  })  : _fillProfileInfoUsecase = fillProfileInfoUsecase,
        _updateMyProfileUsecase = updateMyProfileUsecase,
        super(const FillProfileState.initial()) {
    on<_FillProfile>(_fillProfile);
  }

  Future<void> _fillProfile(
    _FillProfile event,
    Emitter<FillProfileState> emit,
  ) async {
    emit(FillProfileState.loading());

    final Either<Failure, void> result;

    if (_isEditMode) {
      result = await _updateMyProfileUsecase.call(params: event.params);
    } else {
      result = await _fillProfileInfoUsecase.call(
        params: FillProfileParams(
          profileId: event.profile,
          profileData: event.params,
        ),
      );
    }

    result.fold(
      ifLeft: (failure) {
        emit(FillProfileState.fillingFailure(failure: failure));
      },
      ifRight: (_) {
        emit(FillProfileState.filled());
      },
    );
  }
}
