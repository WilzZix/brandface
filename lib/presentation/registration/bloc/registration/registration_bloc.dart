import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/registration/registration_entity.dart';
import 'package:brandface/domain/usecase/registration/params/registration_params.dart';
import 'package:brandface/domain/usecase/registration/registration_usecase.dart';
import 'package:brandface/utils/services/profile_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_event.dart';

part 'registration_state.dart';

part 'registration_bloc.freezed.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationUsecase _registrationUsecase;
  final ProfileService _profileService;

  RegistrationBloc({
    required RegistrationUsecase registrationUsecase,
    required ProfileService profileService,
  }) : _profileService = profileService,
       _registrationUsecase = registrationUsecase,
       super(const RegistrationState.initial()) {
    on<_Registration>(_registration);
  }

  Future<void> _registration(
    _Registration event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationState.userRegistering());
    final result = await _registrationUsecase.call(params: event.params);
    result.fold(
      ifLeft: (failure) {
        emit(RegistrationState.userRegisterFailure(msg: failure));
      },
      ifRight: (registerEntity) {
        _profileService.setProfileId(registerEntity.profileId);
        emit(RegistrationState.userRegistered(registerEntity: registerEntity));
      },
    );
  }
}
