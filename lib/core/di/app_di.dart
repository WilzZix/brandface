import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/data_source/network_data_source/network_data_source.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:brandface/domain/usecase/login_usecase.dart';
import 'package:brandface/presentation/login/bloc/login_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../data/repositories/login_repository_impl.dart';

final sl = GetIt.instance;

class AppDi {
  Future<void> init() async {
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => DioClient(sl()));
    sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(sl()));
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton<ILoginRepository>(() => LoginRepositoryImpl(remoteDataSource: sl()));
    sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  }
}
