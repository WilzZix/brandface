import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/get_me_entity.dart';
import 'package:brandface/domain/entities/otp_entity.dart';
import 'package:brandface/domain/entities/social_auth_entity.dart';
import 'package:brandface/domain/entities/social_provider.dart';
import 'package:brandface/domain/entities/verify_otp_entity.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:brandface/domain/repository/social_auth_repository.dart';
import 'package:brandface/domain/usecase/login/get_me_use_case.dart';
import 'package:brandface/domain/usecase/login/params/verify_otp_params.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:brandface/domain/usecase/login/social_auth_usecase.dart';
import 'package:brandface/domain/usecase/login/verify_otp_usecase.dart';
import 'package:brandface/presentation/login/bloc/login_bloc.dart';
import 'package:brandface/utils/services/app_auth_local_service.dart';
import 'package:brandface/utils/services/profile_service.dart';
import 'package:brandface/utils/services/social_auth/social_auth_service.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeLoginRepository implements ILoginRepository {
  Either<Failure, OtpEntity>? sendOtpResult;
  Either<Failure, VerifyOtpEntity>? verifyOtpResult;
  Either<Failure, UserEntity>? getMeResult;

  String? lastSentPhone;
  VerifyOtpParams? lastVerifyParams;

  @override
  Future<Either<Failure, OtpEntity>> sendOtp({required String phone}) async {
    lastSentPhone = phone;
    return sendOtpResult ??
        Right(OtpEntity(detail: 'sent', code: '123456'));
  }

  @override
  Future<Either<Failure, VerifyOtpEntity>> verifyOtp({
    required VerifyOtpParams params,
  }) async {
    lastVerifyParams = params;
    return verifyOtpResult ??
        Right(
          VerifyOtpEntity(
            access: 'a',
            refresh: 'r',
            isNewUser: false,
            role: 'influencer',
          ),
        );
  }

  @override
  Future<Either<Failure, UserEntity>> getMe() async {
    return getMeResult ??
        const Right(
          UserEntity(id: 1, username: 'u', role: 'influencer'),
        );
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async => const Right(null);
}

class _FakeSocialAuthRepository implements ISocialAuthRepository {
  @override
  Future<Either<Failure, SocialAuthEntity>> socialLogin({
    required SocialProvider provider,
    required String accessToken,
    String? idToken,
  }) async =>
      const Left(ServerFailure('not used in these tests', statusCode: 500));

  @override
  Future<Either<Failure, SocialAuthEntity>> linkedInCodeExchange({
    required String code,
    required String redirectUri,
  }) async =>
      const Left(ServerFailure('not used in these tests', statusCode: 500));
}

class _FakeAuthLocalService implements IAuthLocalService {
  String? access;
  String? refresh;
  bool onboardingSeen = false;

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    access = accessToken;
    refresh = refreshToken;
  }

  @override
  String? getAccessToken() => access;

  @override
  String? getRefreshToken() => refresh;

  @override
  Future<void> clearCache() async {
    access = null;
    refresh = null;
  }

  @override
  bool isLoggedIn() => (access ?? '').isNotEmpty;

  @override
  bool hasSeenOnboarding() => onboardingSeen;

  @override
  Future<void> markOnboardingSeen() async {
    onboardingSeen = true;
  }
}

LoginBloc _buildBloc({
  required _FakeLoginRepository repo,
  required _FakeAuthLocalService auth,
  required ProfileService profile,
}) {
  final socialRepo = _FakeSocialAuthRepository();
  return LoginBloc(
    loginUseCase: SendOtpUseCase(repo),
    verifyOtpUsecase: VerifyOtpUsecase(repository: repo),
    localService: auth,
    getMeUseCase: GetMeUseCase(iLoginRepository: repo),
    profileService: profile,
    socialAuthUseCase: SocialAuthUseCase(repository: socialRepo),
    linkedInExchangeUseCase: LinkedInExchangeUseCase(repository: socialRepo),
    socialAuthServices: const <SocialProvider, SocialAuthService>{},
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _FakeLoginRepository repo;
  late _FakeAuthLocalService auth;
  late ProfileService profile;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    repo = _FakeLoginRepository();
    auth = _FakeAuthLocalService();
    profile = ProfileService(prefs);
  });

  group('LoginBloc - sendOtp', () {
    test('emits [otpReceiving, otpReceived] on success', () async {
      repo.sendOtpResult = Right(
        OtpEntity(detail: 'sent', code: '654321'),
      );
      final bloc = _buildBloc(repo: repo, auth: auth, profile: profile);

      final future = expectLater(
        bloc.stream,
        emitsInOrder([
          isA<LoginState>().having(
            (s) => s.maybeWhen(otpReceiving: () => true, orElse: () => false),
            'otpReceiving',
            true,
          ),
          isA<LoginState>().having(
            (s) => s.maybeWhen(
              otpReceived: (e) => e.code,
              orElse: () => null,
            ),
            'otpReceived.code',
            '654321',
          ),
        ]),
      );

      bloc.add(const LoginEvent.sendOtp(phone: '94 123 45 67'));
      await future;
      expect(repo.lastSentPhone, '+998941234567');
      await bloc.close();
    });

    test('emits [otpReceiving, otpReceivingFailure] on failure', () async {
      repo.sendOtpResult = const Left(ServerFailure('boom', statusCode: 500));
      final bloc = _buildBloc(repo: repo, auth: auth, profile: profile);

      final future = expectLater(
        bloc.stream,
        emitsInOrder([
          isA<LoginState>().having(
            (s) => s.maybeWhen(otpReceiving: () => true, orElse: () => false),
            'otpReceiving',
            true,
          ),
          isA<LoginState>().having(
            (s) => s.maybeWhen(
              otpReceivingFailure: (msg) => msg,
              orElse: () => null,
            ),
            'failure msg',
            'boom',
          ),
        ]),
      );

      bloc.add(const LoginEvent.sendOtp(phone: '941234567'));
      await future;
      await bloc.close();
    });
  });

  group('LoginBloc - verifyOtp success per role', () {
    Future<void> verifySucceedsForRole(String role) async {
      repo.verifyOtpResult = Right(
        VerifyOtpEntity(
          access: 'access-$role',
          refresh: 'refresh-$role',
          isNewUser: false,
          role: role,
        ),
      );
      repo.getMeResult = Right(
        UserEntity(id: 42, username: 'user-$role', role: role),
      );

      final bloc = _buildBloc(repo: repo, auth: auth, profile: profile);

      final future = expectLater(
        bloc.stream,
        emitsInOrder([
          isA<LoginState>().having(
            (s) => s.maybeWhen(verifyingOtp: () => true, orElse: () => false),
            'verifyingOtp',
            true,
          ),
          isA<LoginState>().having(
            (s) => s.maybeWhen(
              otpVerified: (e) => e.role,
              orElse: () => null,
            ),
            'otpVerified.role',
            role,
          ),
        ]),
      );

      bloc.add(
        LoginEvent.verifyOtp(
          params: VerifyOtpParams(phone: '941234567', code: '123456'),
        ),
      );
      await future;

      expect(auth.access, 'access-$role');
      expect(auth.refresh, 'refresh-$role');
      expect(profile.getRole(), role);
      expect(profile.getProfileId(), 42);
      expect(repo.lastVerifyParams?.phone, '+998941234567');
      expect(repo.lastVerifyParams?.code, '123456');

      await bloc.close();
    }

    test('influencer', () => verifySucceedsForRole('influencer'));
    test('ambassador', () => verifySucceedsForRole('ambassador'));
    test('brandface', () => verifySucceedsForRole('brandface'));
    test('brand', () => verifySucceedsForRole('brand'));
  });

  group('LoginBloc - verifyOtp failures', () {
    test('verifyOtp call returns Left → verifyingOtpFailure', () async {
      repo.verifyOtpResult = const Left(
        ServerFailure('invalid_code', statusCode: 400),
      );
      final bloc = _buildBloc(repo: repo, auth: auth, profile: profile);

      final future = expectLater(
        bloc.stream,
        emitsInOrder([
          isA<LoginState>().having(
            (s) => s.maybeWhen(verifyingOtp: () => true, orElse: () => false),
            'verifyingOtp',
            true,
          ),
          isA<LoginState>().having(
            (s) => s.maybeWhen(
              verifyingOtpFailure: (msg) => msg,
              orElse: () => null,
            ),
            'failure msg',
            'invalid_code',
          ),
        ]),
      );

      bloc.add(
        LoginEvent.verifyOtp(
          params: VerifyOtpParams(phone: '941234567', code: '000000'),
        ),
      );
      await future;
      // Tokens should NOT be saved on verify failure.
      expect(auth.access, isNull);
      expect(profile.getRole(), isNull);
      await bloc.close();
    });

    test('getMe returns Left after verify success → verifyingOtpFailure', () async {
      repo.verifyOtpResult = Right(
        VerifyOtpEntity(
          access: 'a',
          refresh: 'r',
          isNewUser: false,
          role: 'brand',
        ),
      );
      repo.getMeResult = const Left(
        ServerFailure('me_failed', statusCode: 401),
      );

      final bloc = _buildBloc(repo: repo, auth: auth, profile: profile);

      final future = expectLater(
        bloc.stream,
        emitsInOrder([
          isA<LoginState>().having(
            (s) => s.maybeWhen(verifyingOtp: () => true, orElse: () => false),
            'verifyingOtp',
            true,
          ),
          isA<LoginState>().having(
            (s) => s.maybeWhen(
              verifyingOtpFailure: (msg) => msg,
              orElse: () => null,
            ),
            'failure msg',
            'me_failed',
          ),
        ]),
      );

      bloc.add(
        LoginEvent.verifyOtp(
          params: VerifyOtpParams(phone: '941234567', code: '123456'),
        ),
      );
      await future;
      // Tokens were saved before getMe; role was not.
      expect(auth.access, 'a');
      expect(profile.getRole(), isNull);
      await bloc.close();
    });
  });

  group('LoginBloc - reset', () {
    test('reset emits initial', () async {
      final bloc = _buildBloc(repo: repo, auth: auth, profile: profile);

      // Trigger a non-initial state first.
      repo.sendOtpResult = Right(OtpEntity(detail: '', code: ''));
      bloc.add(const LoginEvent.sendOtp(phone: '941234567'));
      await bloc.stream.firstWhere(
        (s) => s.maybeWhen(otpReceived: (_) => true, orElse: () => false),
      );

      final future = expectLater(
        bloc.stream,
        emitsInOrder([
          isA<LoginState>().having(
            (s) => s.maybeWhen(initial: () => true, orElse: () => false),
            'initial',
            true,
          ),
        ]),
      );

      bloc.add(const LoginEvent.reset());
      await future;
      await bloc.close();
    });
  });
}
