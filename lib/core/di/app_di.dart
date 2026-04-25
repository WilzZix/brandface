import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/data_source/network_data_source/login/login_data_source.dart';
import 'package:brandface/data/data_source/network_data_source/profile/profile_data_source.dart';
import 'package:brandface/data/data_source/network_data_source/registration/registration_data_source.dart';
import 'package:brandface/data/repositories/profile_repository_impl.dart';
import 'package:brandface/data/repositories/registration_repository_impl.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:brandface/domain/repository/registration_repository.dart';
import 'package:brandface/domain/usecase/catalog/category/city_use_case.dart';
import 'package:brandface/domain/usecase/catalog/category/get_languages_use_case.dart';
import 'package:brandface/domain/usecase/catalog/category/region_use_case.dart';
import 'package:brandface/domain/usecase/catalog/category/service_type_use_case.dart';
import 'package:brandface/domain/usecase/catalog/category/sphere_use_case.dart';
import 'package:brandface/domain/usecase/login/delete_account_use_case.dart';
import 'package:brandface/domain/usecase/login/get_me_use_case.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:brandface/domain/usecase/profile/create_award_use_case.dart';
import 'package:brandface/domain/usecase/profile/delete_award_use_case.dart';
import 'package:brandface/domain/usecase/profile/get_influencer_profile_use_case.dart';
import 'package:brandface/domain/usecase/profile/get_profile_use_case.dart';
import 'package:brandface/domain/usecase/profile/get_social_media_account_stats_use_case.dart';
import 'package:brandface/domain/usecase/registration/registration_usecase.dart';
import 'package:brandface/presentation/login/bloc/login_bloc.dart';
import 'package:brandface/presentation/registration/bloc/audience/audience_cubit.dart';
import 'package:brandface/presentation/registration/bloc/award/award_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/category/category_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/language/language_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/city/city_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/region/region_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/service_type/service_type_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/sphere/sphere_cubit.dart';
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
import '../../domain/usecase/registration/update_my_profile_usecase.dart';
import '../../presentation/home_page/profile/bloc/delete_account/delete_account_cubit.dart';
import '../../presentation/home_page/profile/bloc/profile_information/profile_information_cubit.dart';
import '../../presentation/registration/bloc/brand_registration/brand_registration_bloc.dart';
import '../../data/data_source/network_data_source/upload/upload_data_source.dart';
import '../../data/repositories/upload_repository_impl.dart';
import '../../domain/repository/upload_repository.dart';
import '../../domain/usecase/upload/upload_file_usecase.dart';
import '../../presentation/registration/bloc/fill_brand_profile/fill_brand_profile_bloc.dart';
import '../../presentation/registration/bloc/fill_profile/fill_profile_bloc.dart';
import '../../presentation/registration/bloc/upload/upload_cubit.dart';
import '../../utils/services/app_auth_local_service.dart';
import '../../utils/services/app_catalog_service.dart';
import '../../utils/services/profile_service.dart';

final sl = GetIt.instance;

class AppDi {
  Future<void> init() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
    sl.registerLazySingleton<IAuthLocalService>(() => AuthLocalService(sl()));
    sl.registerLazySingleton<IAppCatalogService>(() => AppCatalogService(sl()));
    sl.registerLazySingleton(() => ProfileService(sl()));
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
    sl.registerLazySingleton<UploadDataSource>(
      () => UploadDataSourceImpl(dioClient: sl()),
    );

    ///Use case
    sl.registerLazySingleton(() => SendOtpUseCase(sl()));
    sl.registerLazySingleton(() => VerifyOtpUsecase(repository: sl()));
    sl.registerLazySingleton(() => RegistrationUsecase(sl()));
    sl.registerLazySingleton(() => BrandRegistrationUsecase(sl()));
    sl.registerLazySingleton(() => FillProfileInfoUsecase(sl()));
    sl.registerLazySingleton(() => UpdateMyProfileUsecase(sl()));
    sl.registerLazySingleton(() => FillBrandProfileUsecase(sl()));
    sl.registerLazySingleton(() => CategoryUseCase(repository: sl()));
    sl.registerLazySingleton(() => ServiceTypeUseCase(repository: sl()));
    sl.registerLazySingleton(() => RegionUseCase(repository: sl()));
    sl.registerLazySingleton(() => CityUseCase(repository: sl()));
    sl.registerLazySingleton(() => SphereUseCase(repository: sl()));
    sl.registerLazySingleton(() => GetProfileUseCase(repository: sl()));
    sl.registerLazySingleton(
      () => GetInfluencerProfileUseCase(repository: sl()),
    );
    sl.registerLazySingleton(() => GetMeUseCase(iLoginRepository: sl()));
    sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
    sl.registerLazySingleton(() => GetLanguagesUseCase(repository: sl()));
    sl.registerLazySingleton(
      () => GetSocialMediaAccountStatsUseCase(repository: sl()),
    );
    sl.registerLazySingleton(() => CreateAwardUseCase(repository: sl()));
    sl.registerLazySingleton(() => DeleteAwardUseCase(repository: sl()));

    ///Repository
    sl.registerLazySingleton<ILoginRepository>(
      () => LoginRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<IRegistrationRepository>(
      () => RegistrationRepositoryImpl(dataSource: sl()),
    );
    sl.registerLazySingleton<IProfileRepository>(
      () => ProfileRepositoryImpl(
        dataSource: sl(),
        profileService: sl(),
        catalogLocalService: sl(),
      ),
    );
    sl.registerLazySingleton<IUploadRepository>(
      () => UploadRepositoryImpl(dataSource: sl()),
    );
    sl.registerLazySingleton(() => UploadFileUseCase(sl()));

    ///Bloc
    sl.registerFactory(() => InitAppCubit(sharedPrefService: sl(), profileService: sl()));
    sl.registerFactory(
      () => LoginBloc(
        loginUseCase: sl(),
        verifyOtpUsecase: sl(),
        localService: sl(),
        getMeUseCase: sl(),
        profileService: sl(),
      ),
    );
    sl.registerFactory(
      () => RegistrationBloc(registrationUsecase: sl(), profileService: sl()),
    );
    sl.registerFactory(
      () => BrandRegistrationBloc(brandRegistrationUsecase: sl()),
    );
    sl.registerFactory(() => FillProfileBloc(
          fillProfileInfoUsecase: sl(),
          updateMyProfileUsecase: sl(),
        ));
    sl.registerFactory(
      () => FillBrandProfileBloc(fillBrandProfileUsecase: sl()),
    );
    sl.registerFactory(() => CategoryCubit(categoryUseCase: sl()));
    sl.registerFactory(() => ServiceTypeCubit(serviceTypeUseCase: sl()));
    sl.registerFactory(() => RegionCubit(regionUseCase: sl()));
    sl.registerFactory(() => CityCubit(cityUseCase: sl()));
    sl.registerFactory(() => SphereCubit(sphereUseCase: sl()));
    sl.registerFactory(() => GetProfileCubit(
          getProfileUseCase: sl(),
          getInfluencerProfileUseCase: sl(),
        ));
    sl.registerFactory(() => LanguageCubit(getLanguagesUseCase: sl()));
    sl.registerFactory(() => AudienceCubit(accountStatsUseCase: sl()));
    sl.registerFactory(() => AwardCubit(
          createAwardUseCase: sl(),
          deleteAwardUseCase: sl(),
        ));
    sl.registerFactory(() => UploadCubit(uploadFileUseCase: sl()));
    sl.registerFactory(
      () => ProfileInformationCubit(
        influencerProfileUseCase: sl(),
        profileService: sl(),
      ),
    );
    sl.registerFactory(
      () => DeleteAccountCubit(deleteAccountUseCase: sl()),
    );
  }
}
