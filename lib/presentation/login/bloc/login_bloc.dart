import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/otp_entity.dart';
import 'package:brandface/domain/usecase/login/verify_otp_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/verify_otp_entity.dart';
import '../../../domain/usecase/login/get_me_use_case.dart';
import '../../../domain/usecase/login/params/verify_otp_params.dart';
import '../../../domain/usecase/login/send_otp_usecase.dart';
import '../../../utils/services/app_auth_local_service.dart';
import '../../../utils/services/profile_service.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SendOtpUseCase _loginUseCase;
  final VerifyOtpUsecase _verifyOtpUsecase;
  final IAuthLocalService _localService;
  final ProfileService _profileService;
  final GetMeUseCase _getMeUseCase;

  LoginBloc({
    required SendOtpUseCase loginUseCase,
    required VerifyOtpUsecase verifyOtpUsecase,
    required IAuthLocalService localService,
    required GetMeUseCase getMeUseCase,
    required ProfileService profileService,
  }) : _profileService = profileService,
       _getMeUseCase = getMeUseCase,
       _localService = localService,
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
      ifLeft: (failure) =>
          emit(LoginState.otpReceivingFailure(msg: failure.message)),
      ifRight: (otpEntity) =>
          emit(LoginState.otpReceived(otpEntity: otpEntity)),
    );
  }

  Future<void> _verifyOtp(_VerifyOtp event, Emitter<LoginState> emit) async {
    emit(const LoginState.verifyingOtp());

    final rawNumber = event.params.phone.replaceAll(RegExp(r'\D'), '');
    final fullPhoneNumber = '+998$rawNumber';

    // 1. OTP-ni tekshirish
    final result = await _verifyOtpUsecase.call(
      params: VerifyOtpParams(phone: fullPhoneNumber, code: event.params.code),
    );

    await result.fold(
      ifLeft: (failure) async =>
          emit(LoginState.verifyingOtpFailure(msg: failure.message)),
      ifRight: (otpEntity) async {
        // 2. Tokenlarni saqlash (Keyingi requestlar uchun shart)
        await _localService.saveTokens(
          accessToken: otpEntity.access ?? '',
          refreshToken: otpEntity.refresh ?? '',
        );

        // 3. 'Me' so'rovini yuborish (Clean Architecture orqali)
        final meResult = await _getMeUseCase.call(params: null);

        await meResult.fold(
          ifLeft: (failure) async {
            // Agar token saqlansa-yu, lekin 'me' o'xshamasa, xato beramiz
            emit(LoginState.verifyingOtpFailure(msg: failure.message));
          },
          ifRight: (userEntity) async {
            // 4. Foydalanuvchi ID-sini saqlash
            await _profileService.setProfileId(userEntity.id);

            // 5. HAMMA NARSALARI TAYYOR BO'LGANDAGINA VERIFIED EMIT QILAMIZ
            emit(LoginState.otpVerified(otpEntity: otpEntity));
          },
        );
      },
    );
  }
}
