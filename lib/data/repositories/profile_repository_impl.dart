import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
import 'package:brandface/domain/entities/profile/ambassador_entity.dart';
import 'package:brandface/domain/entities/profile/award_entity.dart';
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
import 'package:dio/dio.dart';

import '../../utils/services/profile_service.dart';
import '../data_source/network_data_source/profile/profile_data_source.dart';
import '../models/profile/catalog/category_model.dart';
import '../models/profile/catalog/language_model.dart';

class ProfileRepositoryImpl implements IProfileRepository {
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
  Future<Either<Failure, List<CategoryItemEntity>>> getCategories() async {
    try {
      final List<CategoryData> cachedCategories = _catalogLocalService
          .getCategories();

      if (cachedCategories.isNotEmpty) {
        return Right(
          cachedCategories.map((model) => model.toEntity()).toList(),
        );
      }

      final categoryResponse = await _dataSource.getCategories();

      if (categoryResponse.data != null && categoryResponse.data!.isNotEmpty) {
        await _catalogLocalService.saveCategories(categoryResponse.data!);

        final List<CategoryItemEntity> entities = categoryResponse.data!
            .map((model) => model.toEntity())
            .toList();
        return Right(entities);
      } else {
        return const Right([]);
      }
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          e.message ?? 'Serverda kutilmagan xatolik',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ServiceTypeEntity>>> getServices() async {
    try {
      final servicesData = await _dataSource.getServices();
      final List<ServiceTypeEntity> entities = servicesData.data!
          .map((model) => model.toEntity())
          .toList();
      return Right(entities);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          e.message ?? 'Serverda kutilmagan xatolik',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<RegionEntity>>> getRegions() async {
    try {
      final servicesData = await _dataSource.getRegions();
      final List<RegionEntity> entities = servicesData
          .map((model) => model.toEntity())
          .toList();
      return Right(entities);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          e.message ?? 'Serverda kutilmagan xatolik',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<CityEntity>>> getCities() async {
    try {
      final data = await _dataSource.getCities();
      final List<CityEntity> entities = data.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          e.message ?? 'Serverda kutilmagan xatolik',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<SphereEntity>>> getSpheres() async {
    try {
      final data = await _dataSource.getSpheres();
      final List<SphereEntity> entities = data.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          e.message ?? 'Serverda kutilmagan xatolik',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> getProfile({
    required String profileId,
  }) async {
    try {
      final profileData = await _dataSource.getProfile(profileId: profileId);
      return Right(profileData.toEntity());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          e.message ?? 'Serverda kutilmagan xatolik',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, InfluencerProfileInformationEntity>>
  getInfluencerProfile() async {
    try {
      final profileId = _profileService.getProfileId();

      if (profileId == null) {
        return const Left(
          ServerFailure('Profile ID topilmadi. Iltimos, qayta kiring.'),
        );
      }

      final profileModel = await _dataSource.getInfluencerProfile();

      return Right(profileModel.toEntity());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['message'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<LanguageEntity>>> getLanguages() async {
    try {
      // 1. Birinchi navbatda local keshdan tekshiramiz
      final List<LanguageData> cachedLangs = _catalogLocalService
          .getSpokenLanguages();

      if (cachedLangs.isNotEmpty) {
        // Agar keshda ma'lumot bo'lsa, serverga chiqmasdan qaytaramiz
        return Right(cachedLangs.map((model) => model.toEntity()).toList());
      }

      // 2. Kesh bo'sh bo'lsa, serverdan olamiz
      final languageResponse = await _dataSource.getLanguages();

      if (languageResponse.data != null && languageResponse.data!.isNotEmpty) {
        // 3. Serverdan kelgan ma'lumotni keshga yozib qo'yamiz
        await _catalogLocalService.saveSpokenLanguages(languageResponse.data!);

        final List<LanguageEntity> entities = languageResponse.data!
            .map((model) => model.toEntity())
            .toList();
        return Right(entities);
      } else {
        return const Right([]);
      }
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          e.message ?? 'Serverda kutilmagan xatolik',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, SocialMediaAccountStatsEntity>>
  getSocialMediaAccountStats({
    required String platform,
    required String username,
  }) async {
    try {
      final socialAccountStats = await _dataSource.getSocialMediaStats(
        platform: platform,
        username: username,
      );

      return Right(socialAccountStats.toEntity());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['message'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, InfluencerAnalyticsEntity>>
  getInfluencerAnalytics() async {
    try {
      final analytics = await _dataSource.getInfluencerAnalytics();
      return Right(analytics);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['message'] ??
              e.response?.data?['detail'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> getInfluencerReviews({
    required int influencerId,
  }) async {
    try {
      final reviews = await _dataSource.getInfluencerReviews(
        influencerId: influencerId,
      );
      return Right(reviews);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['message'] ??
              e.response?.data?['detail'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AwardEntity>> createAward({
    required String title,
  }) async {
    try {
      final award = await _dataSource.createAward(title: title);
      return Right(award);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['message'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAward({required int awardId}) async {
    try {
      await _dataSource.deleteAward(awardId: awardId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['message'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<AmbassadorEntity>>> getAmbassadors({
    String? ordering,
    int? categoryId,
    int? regionId,
    String? gender,
    bool? isTop,
    bool? isVip,
  }) async {
    try {
      final data = await _dataSource.getAmbassadors(
        ordering: ordering,
        categoryId: categoryId,
        regionId: regionId,
        gender: gender,
        isTop: isTop,
        isVip: isVip,
      );
      return Right(data);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['detail'] ??
              e.response?.data?['message'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AmbassadorDetailEntity>> getAmbassadorDetail({
    required int ambassadorId,
  }) async {
    try {
      final detail = await _dataSource.getAmbassadorDetail(
        ambassadorId: ambassadorId,
      );
      return Right(detail);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['detail'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }
}
