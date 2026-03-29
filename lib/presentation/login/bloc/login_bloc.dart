import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/otp_entity.dart';
import 'package:brandface/domain/usecase/params/verify_otp_params.dart';
import 'package:brandface/domain/usecase/verify_otp_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/usecase/send_otp_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SendOtpUseCase _loginUseCase;
  final VerifyOtpUsecase _verifyOtpUsecase;

  LoginBloc({required SendOtpUseCase loginUseCase, required VerifyOtpUsecase verifyOtpUsecase})
    : _verifyOtpUsecase = verifyOtpUsecase,
      _loginUseCase = loginUseCase,
      super(const LoginState.initial()) {
    on<_SendOtp>(_sendOtp);
    on<_VerifyOtp>(_verifyOtp);
  }

  Future<void> _sendOtp(_SendOtp event, Emitter<LoginState> emit) async {
    emit(LoginState.otpReceiving());
    final rawNumber = event.phone.replaceAll(RegExp(r'\D'), '');
    final fullPhoneNumber = '+998$rawNumber';
    final result = await _loginUseCase.call(params: fullPhoneNumber);
    result.fold(
      ifLeft: (failure) => emit(LoginState.otpReceivingFailure(msg: failure.message)),
      ifRight: (otpEntity) => emit(LoginState.otpReceived(otpEntity: otpEntity)),
    );
  }

  Future<void> _verifyOtp(_VerifyOtp event, Emitter<LoginState> emit) async {
    emit(LoginState.verifyingOtp());
    final result = await _verifyOtpUsecase.call(
      params: VerifyOtpParams(phone: event.phone, code: event.otp),
    );
    //TODO state params need add
    result.fold(
      ifLeft: (failure) => emit(LoginState.verifyingOtpFailure()),
      ifRight: (otpEntity) => emit(LoginState.otpVerified()),
    );
  }
}
