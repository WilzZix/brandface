import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/data_source/network_data_source/billing/billing_data_source.dart';
import 'package:brandface/data/data_source/network_data_source/home/home_data_source.dart';
import 'package:brandface/data/data_source/network_data_source/login/login_data_source.dart';
import 'package:brandface/data/data_source/network_data_source/notification/notification_data_source.dart';
import 'package:brandface/data/data_source/network_data_source/offer/offer_data_source.dart';
import 'package:brandface/data/data_source/network_data_source/profile/profile_data_source.dart';
import 'package:brandface/data/data_source/network_data_source/registration/registration_data_source.dart';
import 'package:brandface/data/repositories/home_repository_impl.dart';
import 'package:brandface/data/repositories/notification_repository_impl.dart';
import 'package:brandface/data/repositories/offer_repository_impl.dart';
import 'package:brandface/data/repositories/billing_repository_impl.dart';
import 'package:brandface/data/repositories/profile_repository_impl.dart';
import 'package:brandface/data/repositories/registration_repository_impl.dart';
import 'package:brandface/domain/repository/home_repository.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:brandface/domain/repository/notification_repository.dart';
import 'package:brandface/domain/repository/offer_repository.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:brandface/domain/repository/registration_repository.dart';
import 'package:brandface/domain/usecase/catalog/category/city_use_case.dart';
import 'package:brandface/domain/usecase/catalog/category/get_languages_use_case.dart';
import 'package:brandface/domain/usecase/catalog/category/region_use_case.dart';
import 'package:brandface/domain/usecase/catalog/category/service_type_use_case.dart';
import 'package:brandface/domain/usecase/catalog/category/sphere_use_case.dart';
import 'package:brandface/domain/usecase/billing/add_billing_card_use_case.dart';
import 'package:brandface/domain/usecase/billing/boost_profile_use_case.dart';
import 'package:brandface/domain/usecase/billing/cancel_subscription_use_case.dart';
import 'package:brandface/domain/usecase/billing/delete_billing_card_use_case.dart';
import 'package:brandface/domain/usecase/billing/get_billing_dashboard_use_case.dart';
import 'package:brandface/domain/usecase/billing/set_default_billing_card_use_case.dart';
import 'package:brandface/domain/usecase/home/get_home_dashboard_use_case.dart';
import 'package:brandface/domain/usecase/login/delete_account_use_case.dart';
import 'package:brandface/domain/usecase/login/get_me_use_case.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:brandface/domain/usecase/notification/get_notifications_use_case.dart';
import 'package:brandface/domain/usecase/notification/mark_all_notifications_read_use_case.dart';
import 'package:brandface/domain/usecase/notification/mark_notification_read_use_case.dart';
import 'package:brandface/domain/usecase/offer/apply_to_offer_use_case.dart';
import 'package:brandface/domain/usecase/offer/create_offer_use_case.dart';
import 'package:brandface/domain/usecase/offer/get_available_offers_use_case.dart';
import 'package:brandface/domain/usecase/offer/get_offer_detail_use_case.dart';
import 'package:brandface/domain/usecase/offer/get_recommended_offers_use_case.dart';
import 'package:brandface/domain/usecase/profile/create_award_use_case.dart';
import 'package:brandface/domain/usecase/profile/delete_award_use_case.dart';
import 'package:brandface/domain/usecase/profile/get_ambassadors_use_case.dart';
import 'package:brandface/domain/usecase/profile/get_influencer_profile_use_case.dart';
import 'package:brandface/domain/usecase/profile/get_influencer_reviews_use_case.dart';
import 'package:brandface/domain/usecase/profile/get_profile_use_case.dart';
import 'package:brandface/domain/usecase/profile/get_social_media_account_stats_use_case.dart';
import 'package:brandface/presentation/home_page/bloc/home_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassadors/ambassadors_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/brand_stats_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/collaboration_offers_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/create_offer/create_offer_cubit.dart';
import 'package:brandface/presentation/home_page/notifications/bloc/notifications_cubit.dart';
import 'package:brandface/presentation/home_page/offers/bloc/offer_detail_cubit.dart';
import 'package:brandface/presentation/home_page/offers/bloc/offers_feed_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_cubit.dart';
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
import '../../presentation/home_page/profile/bloc/reviews/reviews_cubit.dart';
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
    sl.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl(sl()));
    sl.registerLazySingleton<BillingDataSource>(
      () => BillingDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<NotificationDataSource>(
      () => NotificationDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<OfferDataSource>(() => OfferDataSourceImpl(sl()));
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
    sl.registerLazySingleton(() => GetHomeDashboardUseCase(repository: sl()));
    sl.registerLazySingleton(
      () => GetBillingDashboardUseCase(repository: sl()),
    );
    sl.registerLazySingleton(() => AddBillingCardUseCase(repository: sl()));
    sl.registerLazySingleton(
      () => SetDefaultBillingCardUseCase(repository: sl()),
    );
    sl.registerLazySingleton(() => DeleteBillingCardUseCase(repository: sl()));
    sl.registerLazySingleton(() => CancelSubscriptionUseCase(repository: sl()));
    sl.registerLazySingleton(() => BoostProfileUseCase(repository: sl()));
    sl.registerLazySingleton(
      () => GetInfluencerProfileUseCase(repository: sl()),
    );
    sl.registerLazySingleton(() => GetMeUseCase(iLoginRepository: sl()));
    sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
    sl.registerLazySingleton(() => GetLanguagesUseCase(repository: sl()));
    sl.registerLazySingleton(() => GetNotificationsUseCase(repository: sl()));
    sl.registerLazySingleton(
      () => MarkNotificationReadUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => MarkAllNotificationsReadUseCase(repository: sl()),
    );
    sl.registerLazySingleton(() => GetAvailableOffersUseCase(repository: sl()));
    sl.registerLazySingleton(
      () => GetRecommendedOffersUseCase(repository: sl()),
    );
    sl.registerLazySingleton(() => GetOfferDetailUseCase(repository: sl()));
    sl.registerLazySingleton(() => ApplyToOfferUseCase(repository: sl()));
    sl.registerLazySingleton(() => CreateOfferUseCase(repository: sl()));
    sl.registerLazySingleton(
      () => GetSocialMediaAccountStatsUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetInfluencerReviewsUseCase(repository: sl()),
    );
    sl.registerLazySingleton(() => CreateAwardUseCase(repository: sl()));
    sl.registerLazySingleton(() => DeleteAwardUseCase(repository: sl()));
    sl.registerLazySingleton(() => GetAmbassadorsUseCase(repository: sl()));

    ///Repository
    sl.registerLazySingleton<ILoginRepository>(
      () => LoginRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<IRegistrationRepository>(
      () => RegistrationRepositoryImpl(dataSource: sl()),
    );
    sl.registerLazySingleton<IHomeRepository>(
      () => HomeRepositoryImpl(dataSource: sl()),
    );
    sl.registerLazySingleton<IBillingRepository>(
      () => BillingRepositoryImpl(dataSource: sl()),
    );
    sl.registerLazySingleton<INotificationRepository>(
      () => NotificationRepositoryImpl(dataSource: sl()),
    );
    sl.registerLazySingleton<IOfferRepository>(
      () => OfferRepositoryImpl(dataSource: sl()),
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
    sl.registerFactory(
      () => FillProfileBloc(
        fillProfileInfoUsecase: sl(),
        updateMyProfileUsecase: sl(),
      ),
    );
    sl.registerFactory(
      () => FillBrandProfileBloc(fillBrandProfileUsecase: sl()),
    );
    sl.registerFactory(() => CategoryCubit(categoryUseCase: sl()));
    sl.registerFactory(() => ServiceTypeCubit(serviceTypeUseCase: sl()));
    sl.registerFactory(() => RegionCubit(regionUseCase: sl()));
    sl.registerFactory(() => CityCubit(cityUseCase: sl()));
    sl.registerFactory(() => SphereCubit(sphereUseCase: sl()));
    sl.registerFactory(() => HomeCubit(getHomeDashboardUseCase: sl()));
    sl.registerFactory(() => BrandStatsCubit(offerRepository: sl()));
    sl.registerFactory(() => CollaborationOffersCubit(offerRepository: sl()));
    sl.registerFactory(
      () => CreateOfferCubit(createOfferUseCase: sl()),
    );
    sl.registerFactory(
      () => BillingCubit(
        getBillingDashboardUseCase: sl(),
        addBillingCardUseCase: sl(),
        setDefaultBillingCardUseCase: sl(),
        deleteBillingCardUseCase: sl(),
        cancelSubscriptionUseCase: sl(),
        boostProfileUseCase: sl(),
      ),
    );
    sl.registerFactory(
      () => NotificationsCubit(
        getNotificationsUseCase: sl(),
        markNotificationReadUseCase: sl(),
        markAllNotificationsReadUseCase: sl(),
      ),
    );
    sl.registerFactory(
      () => OffersFeedCubit(
        getAvailableOffersUseCase: sl(),
        getRecommendedOffersUseCase: sl(),
      ),
    );
    sl.registerFactory(
      () => OfferDetailCubit(
        getOfferDetailUseCase: sl(),
        applyToOfferUseCase: sl(),
      ),
    );
    sl.registerFactory(
      () => GetProfileCubit(
        getProfileUseCase: sl(),
        getInfluencerProfileUseCase: sl(),
      ),
    );
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
      () => ReviewsCubit(
        getInfluencerProfileUseCase: sl(),
        getInfluencerReviewsUseCase: sl(),
      ),
    );
    sl.registerFactory(() => DeleteAccountCubit(deleteAccountUseCase: sl()));
    sl.registerFactory(
      () => AmbassadorsCubit(getAmbassadorsUseCase: sl()),
    );
  }
}
