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
import 'package:brandface/domain/entities/profile/review_entity.dart';
import 'package:dart_either/dart_either.dart';

import '../../core/error/failures.dart';
import '../entities/profile/profile_entity.dart';

abstract class IProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile({
    required String profileId,
  });

  Future<Either<Failure, InfluencerProfileInformationEntity>>
  getInfluencerProfile();

  Future<Either<Failure, List<CategoryItemEntity>>> getCategories();

  Future<Either<Failure, List<ServiceTypeEntity>>> getServices();

  Future<Either<Failure, List<RegionEntity>>> getRegions();

  Future<Either<Failure, List<CityEntity>>> getCities();

  Future<Either<Failure, List<SphereEntity>>> getSpheres();

  Future<Either<Failure, List<LanguageEntity>>> getLanguages();

  Future<Either<Failure, List<BrandShortEntity>>> getBrands();

  Future<Either<Failure, SocialMediaAccountStatsEntity>>
  getSocialMediaAccountStats({
    required String platform,
    required String username,
  });

  Future<Either<Failure, InfluencerAnalyticsEntity>> getInfluencerAnalytics();

  Future<Either<Failure, List<ReviewEntity>>> getInfluencerReviews({
    required int influencerId,
  });

  Future<Either<Failure, AwardEntity>> createAward({required String title});

  Future<Either<Failure, void>> deleteAward({required int awardId});

  Future<Either<Failure, AvailableDateItem>> addAvailableDate({
    required String dateFrom,
    required String dateTo,
    String? note,
  });

  Future<Either<Failure, void>> deleteAvailableDate({required int dateId});

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
  });

  Future<Either<Failure, AmbassadorDetailEntity>> getAmbassadorDetail({
    required int ambassadorId,
  });
}
