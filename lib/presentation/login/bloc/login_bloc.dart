import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/otp_entity.dart';
import 'package:brandface/domain/entities/social_auth_entity.dart';
import 'package:brandface/domain/entities/social_provider.dart';
import 'package:brandface/domain/usecase/login/params/social_auth_params.dart';
import 'package:brandface/domain/usecase/login/social_auth_usecase.dart';
import 'package:brandface/domain/usecase/login/verify_otp_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/verify_otp_entity.dart';
import '../../../domain/usecase/login/get_me_use_case.dart';
import '../../../domain/usecase/login/params/verify_otp_params.dart';
import '../../../domain/usecase/login/send_otp_usecase.dart';
import '../../../utils/services/app_auth_local_service.dart';
import '../../../utils/services/profile_service.dart';
import '../../../utils/services/social_auth/social_auth_service.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SendOtpUseCase _loginUseCase;
  final VerifyOtpUsecase _verifyOtpUsecase;
  final IAuthLocalService _localService;
  final ProfileService _profileService;
  final GetMeUseCase _getMeUseCase;
  final SocialAuthUseCase _socialAuthUseCase;
  final LinkedInExchangeUseCase _linkedInExchangeUseCase;
  final Map<SocialProvider, SocialAuthService> _socialAuthServices;

  LoginBloc({
    required SendOtpUseCase loginUseCase,
    required VerifyOtpUsecase verifyOtpUsecase,
    required IAuthLocalService localService,
    required GetMeUseCase getMeUseCase,
    required ProfileService profileService,
    required SocialAuthUseCase socialAuthUseCase,
    required LinkedInExchangeUseCase linkedInExchangeUseCase,
    required Map<SocialProvider, SocialAuthService> socialAuthServices,
  })  : _profileService = profileService,
        _getMeUseCase = getMeUseCase,
        _localService = localService,
        _verifyOtpUsecase = verifyOtpUsecase,
        _loginUseCase = loginUseCase,
        _socialAuthUseCase = socialAuthUseCase,
        _linkedInExchangeUseCase = linkedInExchangeUseCase,
        _socialAuthServices = socialAuthServices,
        super(const LoginState.initial()) {
    on<_SendOtp>(_sendOtp);
    on<_VerifyOtp>(_verifyOtp);
    on<_SocialLogin>(_socialLogin);
    on<_Reset>((event, emit) => emit(const LoginState.initial()));
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

    final result = await _verifyOtpUsecase.call(
      params: VerifyOtpParams(phone: fullPhoneNumber, code: event.params.code),
    );

    await result.fold(
      ifLeft: (failure) async =>
          emit(LoginState.verifyingOtpFailure(msg: failure.message)),
      ifRight: (otpEntity) async {
        await _localService.saveTokens(
          accessToken: otpEntity.access ?? '',
          refreshToken: otpEntity.refresh ?? '',
        );

        final meResult = await _getMeUseCase.call(params: null);

        await meResult.fold(
          ifLeft: (failure) async {
            emit(LoginState.verifyingOtpFailure(msg: failure.message));
          },
          ifRight: (userEntity) async {
            await _profileService.setProfileId(userEntity.id);
            await _profileService.setRole(userEntity.role);
            emit(LoginState.otpVerified(otpEntity: otpEntity));
          },
        );
      },
    );
  }

  Future<void> _socialLogin(
    _SocialLogin event,
    Emitter<LoginState> emit,
  ) async {
    final provider = event.provider;

    if (!provider.isSupportedByBackend) {
      emit(LoginState.socialAuthSoon(provider: provider));
      return;
    }

    final service = _socialAuthServices[provider];
    if (service == null) {
      emit(LoginState.socialAuthSoon(provider: provider));
      return;
    }

    emit(LoginState.socialAuthInProgress(provider: provider));

    final SocialSignInResult signInResult;
    try {
      signInResult = await service.signIn(event.context);
    } on SocialAuthCancelled {
      emit(LoginState.socialAuthCancelled(provider: provider));
      return;
    } on SocialAuthFailedException catch (e) {
      emit(LoginState.socialAuthFailure(provider: provider, msg: e.message));
      return;
    } catch (e) {
      emit(
        LoginState.socialAuthFailure(provider: provider, msg: e.toString()),
      );
      return;
    }

    final exchangeResult = signInResult.isLinkedInCode
        ? await _linkedInExchangeUseCase.call(
            params: LinkedInExchangeParams(
              code: signInResult.code!,
              redirectUri: signInResult.redirectUri!,
            ),
          )
        : await _socialAuthUseCase.call(
            params: SocialAuthParams(
              provider: provider,
              accessToken: signInResult.accessToken,
              idToken: signInResult.idToken,
            ),
          );

    await exchangeResult.fold(
      ifLeft: (failure) async {
        emit(
          LoginState.socialAuthFailure(
            provider: provider,
            msg: failure.message,
          ),
        );
      },
      ifRight: (entity) async {
        await _localService.saveTokens(
          accessToken: entity.access ?? '',
          refreshToken: entity.refresh ?? '',
        );

        final meResult = await _getMeUseCase.call(params: null);
        await meResult.fold(
          ifLeft: (failure) async {
            emit(
              LoginState.socialAuthFailure(
                provider: provider,
                msg: failure.message,
              ),
            );
          },
          ifRight: (userEntity) async {
            await _profileService.setProfileId(userEntity.id);
            await _profileService.setRole(userEntity.role);
            emit(LoginState.socialAuthSuccess(entity: entity));
          },
        );
      },
    );
  }
}
