import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/registration/fill_brand_profile_usecase.dart';
import 'package:brandface/domain/usecase/registration/params/fill_brand_profile_param.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';

part 'fill_brand_profile_event.dart';

part 'fill_brand_profile_state.dart';

part 'fill_brand_profile_bloc.freezed.dart';

class FillBrandProfileBloc
    extends Bloc<FillBrandProfileEvent, FillBrandProfileState> {
  final FillBrandProfileUsecase _fillBrandProfileUsecase;

  FillBrandProfileBloc({
    required FillBrandProfileUsecase fillBrandProfileUsecase,
  }) : _fillBrandProfileUsecase = fillBrandProfileUsecase,
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
}
