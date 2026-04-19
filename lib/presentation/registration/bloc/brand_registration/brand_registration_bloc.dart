import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/registration/registration_entity.dart';
import 'package:brandface/domain/usecase/registration/brand_registration_usecase.dart';
import 'package:brandface/domain/usecase/registration/params/brand_registration_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';

part 'brand_registration_event.dart';

part 'brand_registration_state.dart';

part 'brand_registration_bloc.freezed.dart';

class BrandRegistrationBloc
    extends Bloc<BrandRegistrationEvent, BrandRegistrationState> {
  final BrandRegistrationUsecase _brandRegistrationUsecase;

  BrandRegistrationBloc({
    required BrandRegistrationUsecase brandRegistrationUsecase,
  }) : _brandRegistrationUsecase = brandRegistrationUsecase,
       super(const BrandRegistrationState.initial()) {
    on<_Register>(_register);
  }

  Future<void> _register(
    _Register event,
    Emitter<BrandRegistrationState> emit,
  ) async {
    emit(BrandRegistrationState.loading());
    final result = await _brandRegistrationUsecase.call(params: event.params);
    result.fold(
      ifLeft: (failure) {
        emit(BrandRegistrationState.failure(failure: failure));
      },
      ifRight: (entity) {
        emit(BrandRegistrationState.registered(entity: entity));
      },
    );
  }
}
