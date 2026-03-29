import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/otp_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/usecase/send_otp_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SendOtpUseCase _loginUseCase;

  LoginBloc({required SendOtpUseCase loginUseCase}) : _loginUseCase = loginUseCase, super(const LoginState.initial()) {
    on<_SendOtp>(_sendOtp);
    on<_VerifyOtp>(_verifyOtp);
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

  Future<void> _verifyOtp(_VerifyOtp event, Emitter<LoginState> emit) async {
    emit(LoginState.verifyingOtp());
  }
}
