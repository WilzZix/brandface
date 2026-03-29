import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/login_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/usecase/login_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc({required LoginUseCase loginUseCase}) : _loginUseCase = loginUseCase, super(const LoginState.initial()) {
    on<_SendOtp>(_sendOtp);
  }

  Future<void> _sendOtp(_SendOtp event, Emitter<LoginState> emit) async {
    emit(LoginState.otpReceiving());
    final rawNumber = event.phone.replaceAll(RegExp(r'\D'), '');
    final fullPhoneNumber = '+998$rawNumber';
    final result = await _loginUseCase.call(fullPhoneNumber);
    result.fold(
      ifLeft: (failure) => emit(LoginState.otpReceivingFailure(msg: failure.message)),
      ifRight: (otpEntity) => emit(LoginState.otpReceived(otpEntity: otpEntity)),
    );
  }
}
