import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/data_source/network_data_source/login/login_data_source.dart';
import 'package:brandface/data/data_source/network_data_source/profile/profile_data_source.dart';
import 'package:brandface/data/data_source/network_data_source/registration/registration_data_source.dart';
import 'package:brandface/data/repositories/profile_repository_impl.dart';
import 'package:brandface/data/repositories/registration_repository_impl.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:brandface/domain/repository/registration_repository.dart';
import 'package:brandface/domain/usecase/catalog/category/region_use_case.dart';
import 'package:brandface/domain/usecase/catalog/category/service_type_use_case.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:brandface/domain/usecase/profile/get_profile_use_case.dart';
import 'package:brandface/domain/usecase/registration/registration_usecase.dart';
import 'package:brandface/presentation/login/bloc/login_bloc.dart';
import 'package:brandface/presentation/registration/bloc/catalog/category/category_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/region/region_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/service_type/service_type_cubit.dart';
import 'package:brandface/presentation/registration/bloc/get_profile/get_profile_cubit.dart';
import 'package:brandface/presentation/registration/bloc/registration/registration_bloc.dart';
import 'package:brandface/presentation/splash_screen/bloc/init_app_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/login_repository_impl.dart';
import '../../domain/usecase/catalog/category/category_use_case.dart';
import '../../domain/usecase/login/verify_otp_usecase.dart';
import '../../domain/usecase/registration/brand_registration_usecase.dart';
import '../../domain/usecase/registration/fill_brand_profile_usecase.dart';
import '../../domain/usecase/registration/fill_profile_info_usecase.dart';
import '../../presentation/registration/bloc/brand_registration/brand_registration_bloc.dart';
import '../../presentation/registration/bloc/fill_brand_profile/fill_brand_profile_bloc.dart';
import '../../presentation/registration/bloc/fill_profile/fill_profile_bloc.dart';
import '../../utils/services/app_auth_local_service.dart';

final sl = GetIt.instance;

class AppDi {
  Future<void> init() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
    sl.registerLazySingleton<IAuthLocalService>(() => AuthLocalService(sl()));
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => DioClient(sl(), sharedPrefService: sl()));

    ///Datasource
    sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<RegistrationDataSource>(
      () => RegistrationDataSourceImpl(dioClient: sl()),
    );
    sl.registerLazySingleton<ProfileDataSource>(
      () => ProfileDataSourceImpl(sl()),
    );

    ///Use case
    sl.registerLazySingleton(() => SendOtpUseCase(sl()));
    sl.registerLazySingleton(() => VerifyOtpUsecase(repository: sl()));
    sl.registerLazySingleton(() => RegistrationUsecase(sl()));
    sl.registerLazySingleton(() => BrandRegistrationUsecase(sl()));
    sl.registerLazySingleton(() => FillProfileInfoUsecase(sl()));
    sl.registerLazySingleton(() => FillBrandProfileUsecase(sl()));
    sl.registerLazySingleton(() => CategoryUseCase(repository: sl()));
    sl.registerLazySingleton(() => ServiceTypeUseCase(repository: sl()));
    sl.registerLazySingleton(() => RegionUseCase(repository: sl()));
    sl.registerLazySingleton(() => GetProfileUseCase(repository: sl()));

    ///Repository
    sl.registerLazySingleton<ILoginRepository>(
      () => LoginRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<IRegistrationRepository>(
      () => RegistrationRepositoryImpl(dataSource: sl()),
    );
    sl.registerLazySingleton<IProfileRepository>(
      () => ProfileRepositoryImpl(dataSource: sl()),
    );

    ///Bloc
    sl.registerFactory(() => InitAppCubit(sharedPrefService: sl()));
    sl.registerFactory(
      () => LoginBloc(
        loginUseCase: sl(),
        verifyOtpUsecase: sl(),
        localService: sl(),
      ),
    );
    sl.registerFactory(() => RegistrationBloc(registrationUsecase: sl()));
    sl.registerFactory(
      () => BrandRegistrationBloc(brandRegistrationUsecase: sl()),
    );
    sl.registerFactory(() => FillProfileBloc(fillProfileInfoUsecase: sl()));
    sl.registerFactory(
      () => FillBrandProfileBloc(fillBrandProfileUsecase: sl()),
    );
    sl.registerFactory(() => CategoryCubit(categoryUseCase: sl()));
    sl.registerFactory(() => ServiceTypeCubit(serviceTypeUseCase: sl()));
    sl.registerFactory(() => RegionCubit(regionUseCase: sl()));
    sl.registerFactory(() => GetProfileCubit(getProfileUseCase: sl()));
  }
}
