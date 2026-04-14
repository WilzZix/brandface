import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/otp_entity.dart';
import 'package:brandface/domain/usecase/login/verify_otp_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/usecase/login/params/verify_otp_params.dart';
import '../../../domain/usecase/login/send_otp_usecase.dart';
import '../../../utils/services/app_auth_local_service.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SendOtpUseCase _loginUseCase;
  final VerifyOtpUsecase _verifyOtpUsecase;
  final IAuthLocalService _localService;

  LoginBloc({
    required SendOtpUseCase loginUseCase,
    required VerifyOtpUsecase verifyOtpUsecase,
    required IAuthLocalService localService,
  }) : _localService = localService,
       _verifyOtpUsecase = verifyOtpUsecase,
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
    final rawNumber = event.params.phone.replaceAll(RegExp(r'\D'), '');
    final fullPhoneNumber = '+998$rawNumber';
    final result = await _verifyOtpUsecase.call(
      params: VerifyOtpParams(phone: fullPhoneNumber, code: event.params.code),
    );
    //TODO state params need add
    result.fold(
      ifLeft: (failure) => emit(LoginState.verifyingOtpFailure(msg: failure.message)),
      ifRight: (otpEntity) {
        _localService.saveTokens(accessToken: otpEntity.access ?? '', refreshToken: otpEntity.refresh ?? '');
        emit(LoginState.otpVerified());
      },
    );
  }
}
