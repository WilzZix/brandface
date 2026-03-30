import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/data_source/network_data_source/login/login_data_source.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:brandface/presentation/login/bloc/login_bloc.dart';
import 'package:brandface/presentation/splash_screen/bloc/init_app_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/login_repository_impl.dart';
import '../../domain/usecase/login/verify_otp_usecase.dart';
import '../../utils/services/shared_pref_service.dart';

final sl = GetIt.instance;

class AppDi {
  Future<void> init() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

    sl.registerLazySingleton<IAuthLocalService>(() => AuthLocalService(sl()));
    sl.registerFactory(() => InitAppCubit(sharedPrefService: sl()));
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => DioClient(sl()));
    sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(sl()));
    sl.registerLazySingleton(() => SendOtpUseCase(sl()));
    sl.registerLazySingleton(() => VerifyOtpUsecase(repository: sl()));
    sl.registerLazySingleton<ILoginRepository>(() => LoginRepositoryImpl(remoteDataSource: sl()));
    sl.registerFactory(() => LoginBloc(loginUseCase: sl(), verifyOtpUsecase: sl(), localService: sl()));
  }
}
