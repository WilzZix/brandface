import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/registration/fill_brand_profile_usecase.dart';
import 'package:brandface/domain/usecase/registration/params/fill_brand_profile_param.dart';
import 'package:brandface/domain/usecase/registration/update_my_brand_profile_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';

part 'fill_brand_profile_event.dart';

part 'fill_brand_profile_state.dart';

part 'fill_brand_profile_bloc.freezed.dart';

class FillBrandProfileBloc
    extends Bloc<FillBrandProfileEvent, FillBrandProfileState> {
  final FillBrandProfileUsecase _fillBrandProfileUsecase;
  final UpdateMyBrandProfileUsecase _updateMyBrandProfileUsecase;

  FillBrandProfileBloc({
    required FillBrandProfileUsecase fillBrandProfileUsecase,
    required UpdateMyBrandProfileUsecase updateMyBrandProfileUsecase,
  }) : _fillBrandProfileUsecase = fillBrandProfileUsecase,
       _updateMyBrandProfileUsecase = updateMyBrandProfileUsecase,
       super(const FillBrandProfileState.initial()) {
    on<_FillBrandProfile>(_fillBrandProfile);
  }

  Future<void> _fillBrandProfile(
    _FillBrandProfile event,
    Emitter<FillBrandProfileState> emit,
  ) async {
    emit(FillBrandProfileState.loading());
    final result = await _fillBrandProfileUsecase.call(
      params: FillBrandProfileRequestParams(
        profileId: event.profileId,
        profileData: event.params,
      ),
    );
    result.fold(
      ifLeft: (failure) {
        emit(FillBrandProfileState.failure(failure: failure));
      },
      ifRight: (_) {
        emit(FillBrandProfileState.filled());
      },
    );
  }

  Future<void> updateMyBrandProfile(FillBrandProfileParam params) async {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(FillBrandProfileState.loading());
    final result = await _updateMyBrandProfileUsecase.call(params: params);
    result.fold(
      ifLeft: (failure) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(FillBrandProfileState.failure(failure: failure));
      },
      ifRight: (_) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(FillBrandProfileState.filled());
      },
    );
  }
}
