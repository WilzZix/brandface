import 'package:brandface/core/error/exception_mapper.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
import 'package:brandface/domain/entities/profile/ambassador_entity.dart';
import 'package:brandface/domain/entities/profile/award_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/brand_short_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/category_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/city_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/language_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/region_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/service_type_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/social_media_account_stats_entity.dart';
import 'package:brandface/domain/entities/profile/influencer_analytics_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/sphere_entity.dart';
import 'package:brandface/domain/entities/profile/influencer_profile_information_entity.dart';
import 'package:brandface/domain/entities/profile/profile_entity.dart';
import 'package:brandface/domain/entities/profile/review_entity.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:brandface/utils/services/app_catalog_service.dart';
import 'package:dart_either/dart_either.dart';

import '../../utils/services/profile_service.dart';
import '../data_source/network_data_source/profile/profile_data_source.dart';
import '../models/profile/catalog/category_model.dart';
import '../models/profile/catalog/language_model.dart';

final class ProfileRepositoryImpl implements IProfileRepository {
  final ProfileDataSource _dataSource;
  final ProfileService _profileService;
  final IAppCatalogService _catalogLocalService;

  ProfileRepositoryImpl({
    required ProfileDataSource dataSource,
    required ProfileService profileService,
    required IAppCatalogService catalogLocalService,
  }) : _catalogLocalService = catalogLocalService,
       _profileService = profileService,
       _dataSource = dataSource;

  @override
  Future<Either<Failure, List<CategoryItemEntity>>> getCategories() {
    return guard(() async {
      final List<CategoryData> cachedCategories = _catalogLocalService
          .getCategories();

      if (cachedCategories.isNotEmpty) {
        return cachedCategories.map((model) => model.toEntity()).toList();
      }

      final categoryResponse = await _dataSource.getCategories();

      if (categoryResponse.data != null && categoryResponse.data!.isNotEmpty) {
        await _catalogLocalService.saveCategories(categoryResponse.data!);

        return categoryResponse.data!
            .map((model) => model.toEntity())
            .toList();
      } else {
        return <CategoryItemEntity>[];
      }
    });
  }

  @override
  Future<Either<Failure, List<ServiceTypeEntity>>> getServices() {
    return guard(() async {
      final servicesData = await _dataSource.getServices();
      return servicesData.data!.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<RegionEntity>>> getRegions() {
    return guard(() async {
      final servicesData = await _dataSource.getRegions();
      return servicesData.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<CityEntity>>> getCities() {
    return guard(() async {
      final data = await _dataSource.getCities();
      return data.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<SphereEntity>>> getSpheres() {
    return guard(() async {
      final data = await _dataSource.getSpheres();
      return data.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, ProfileEntity>> getProfile({
    required String profileId,
  }) {
    return guard(() async {
      final profileData = await _dataSource.getProfile(profileId: profileId);
      return profileData.toEntity();
    });
  }

  @override
  Future<Either<Failure, InfluencerProfileInformationEntity>>
  getInfluencerProfile() {
    final profileId = _profileService.getProfileId();

    if (profileId == null) {
      return Future.value(
        const Left(
          ServerFailure('Profile ID topilmadi. Iltimos, qayta kiring.'),
        ),
      );
    }

    return guard(() async {
      final profileModel = await _dataSource.getInfluencerProfile();
      return profileModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<LanguageEntity>>> getLanguages() {
    return guard(() async {
      // 1. Birinchi navbatda local keshdan tekshiramiz
      final List<LanguageData> cachedLangs = _catalogLocalService
          .getSpokenLanguages();

      if (cachedLangs.isNotEmpty) {
        // Agar keshda ma'lumot bo'lsa, serverga chiqmasdan qaytaramiz
        return cachedLangs.map((model) => model.toEntity()).toList();
      }

      // 2. Kesh bo'sh bo'lsa, serverdan olamiz
      final languageResponse = await _dataSource.getLanguages();

      if (languageResponse.data != null && languageResponse.data!.isNotEmpty) {
        // 3. Serverdan kelgan ma'lumotni keshga yozib qo'yamiz
        await _catalogLocalService.saveSpokenLanguages(languageResponse.data!);

        return languageResponse.data!
            .map((model) => model.toEntity())
            .toList();
      } else {
        return <LanguageEntity>[];
      }
    });
  }

  @override
  Future<Either<Failure, List<BrandShortEntity>>> getBrands() {
    return guard(() async {
      final brands = await _dataSource.getBrands();
      return brands.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, SocialMediaAccountStatsEntity>>
  getSocialMediaAccountStats({
    required String platform,
    required String username,
  }) {
    return guard(() async {
      final socialAccountStats = await _dataSource.getSocialMediaStats(
        platform: platform,
        username: username,
      );

      return socialAccountStats.toEntity();
    });
  }

  @override
  Future<Either<Failure, InfluencerAnalyticsEntity>> getInfluencerAnalytics() {
    return guard(() => _dataSource.getInfluencerAnalytics());
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> getInfluencerReviews({
    required int influencerId,
  }) {
    return guard(
      () => _dataSource.getInfluencerReviews(influencerId: influencerId),
    );
  }

  @override
  Future<Either<Failure, AwardEntity>> createAward({required String title}) {
    return guard(() => _dataSource.createAward(title: title));
  }

  @override
  Future<Either<Failure, void>> deleteAward({required int awardId}) {
    return guard(() => _dataSource.deleteAward(awardId: awardId));
  }

  @override
  Future<Either<Failure, AvailableDateItem>> addAvailableDate({
    required String dateFrom,
    required String dateTo,
    String? note,
  }) {
    return guard(
      () => _dataSource.addAvailableDate(
        dateFrom: dateFrom,
        dateTo: dateTo,
        note: note,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> deleteAvailableDate({required int dateId}) {
    return guard(() => _dataSource.deleteAvailableDate(dateId: dateId));
  }

  @override
  Future<Either<Failure, List<AmbassadorEntity>>> getAmbassadors({
    String? ordering,
    int? categoryId,
    int? regionId,
    int? languageId,
    String? gender,
    int? ageFrom,
    int? ageTo,
    bool? isTop,
    bool? isVip,
    int? followersFrom,
    int? followersTo,
    String? availableDate,
    String? currency,
    int? pricePerHourFrom,
    int? pricePerHourTo,
    String? role,
  }) {
    return guard(
      () => _dataSource.getAmbassadors(
        ordering: ordering,
        categoryId: categoryId,
        regionId: regionId,
        languageId: languageId,
        gender: gender,
        ageFrom: ageFrom,
        ageTo: ageTo,
        isTop: isTop,
        isVip: isVip,
        followersFrom: followersFrom,
        followersTo: followersTo,
        availableDate: availableDate,
        currency: currency,
        pricePerHourFrom: pricePerHourFrom,
        pricePerHourTo: pricePerHourTo,
        role: role,
      ),
    );
  }

  @override
  Future<Either<Failure, AmbassadorDetailEntity>> getAmbassadorDetail({
    required int ambassadorId,
  }) {
    return guard(
      () => _dataSource.getAmbassadorDetail(ambassadorId: ambassadorId),
    );
  }
}
