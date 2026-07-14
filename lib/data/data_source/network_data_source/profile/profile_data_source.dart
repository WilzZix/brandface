import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/data/models/profile/ambassador_detail_model.dart';
import 'package:brandface/data/models/profile/ambassador_model.dart';
import 'package:brandface/data/models/profile/catalog/category_model.dart';
import 'package:brandface/data/models/profile/catalog/city_model.dart';
import 'package:brandface/data/models/profile/catalog/language_model.dart';
import 'package:brandface/data/models/profile/catalog/region_model.dart';
import 'package:brandface/data/models/profile/catalog/service_type_model.dart';
import 'package:brandface/data/models/profile/catalog/sphere_model.dart';
import 'package:brandface/data/models/profile/review_model.dart';
import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
import 'package:brandface/domain/entities/profile/award_entity.dart';

import '../../../../core/network/dio_client.dart';
import '../../../models/profile/catalog/brand_short_model.dart';
import '../../../models/profile/catalog/influencer_profile_information_model.dart';
import '../../../models/profile/catalog/social_media_account_stats_model.dart';
import '../../../models/profile/influencer_analytics_model.dart';
import '../../../models/profile/profile_model.dart';

abstract interface class ProfileDataSource {
  Future<ProfileModel> getProfile({required String profileId});

  Future<InfluencerProfileInformationModel> getInfluencerProfile();

  Future<CategoryModel> getCategories();

  Future<ServiceTypeModel> getServices();

  Future<List<RegionModel>> getRegions();

  Future<List<CityModel>> getCities();

  Future<List<SphereModel>> getSpheres();

  Future<LanguageModel> getLanguages();

  Future<List<BrandShortModel>> getBrands();

  Future<SocialMediaAccountStatsModel> getSocialMediaStats({
    required String platform,
    required String username,
  });

  Future<InfluencerAnalyticsModel> getInfluencerAnalytics();

  Future<List<ReviewModel>> getInfluencerReviews({required int influencerId});

  Future<AwardEntity> createAward({required String title});

  Future<void> deleteAward({required int awardId});

  Future<AvailableDateItem> addAvailableDate({
    required String dateFrom,
    required String dateTo,
    String? note,
  });

  Future<void> deleteAvailableDate({required int dateId});

  Future<List<AmbassadorModel>> getAmbassadors({
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

  Future<AmbassadorDetailModel> getAmbassadorDetail({required int ambassadorId});
}

final class ProfileDataSourceImpl implements ProfileDataSource {
  final DioClient _dioClient;

  ProfileDataSourceImpl(this._dioClient);

  @override
  Future<CategoryModel> getCategories() async {
    try {
      final result = await _dioClient.get(ApiRoutes.niches);
      return CategoryModel.fromJson(result.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ServiceTypeModel> getServices() async {
    try {
      final result = await _dioClient.get(ApiRoutes.serviceType);
      return ServiceTypeModel.fromJson(result.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RegionModel>> getRegions() async {
    try {
      final result = await _dioClient.get(ApiRoutes.regions);
      final List<dynamic> data = result.data['data'];

      return data.map((json) => RegionModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CityModel>> getCities() async {
    try {
      final result = await _dioClient.get(ApiRoutes.cities);
      final List<dynamic> data = result.data['data'];
      return data.map((json) => CityModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SphereModel>> getSpheres() async {
    try {
      final result = await _dioClient.get(ApiRoutes.spheres);
      final List<dynamic> data = result.data['data'];
      return data.map((json) => SphereModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileModel> getProfile({required String profileId}) async {
    try {
      final result = await _dioClient.get(ApiRoutes.profile(profileId));
      return ProfileModel.fromJson(result.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<InfluencerProfileInformationModel> getInfluencerProfile() async {
    try {
      final result = await _dioClient.get(ApiRoutes.myProfile);
      return InfluencerProfileInformationModel.fromJson(result.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LanguageModel> getLanguages() async {
    try {
      final result = await _dioClient.get(ApiRoutes.languages);
      return LanguageModel.fromJson(result.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BrandShortModel>> getBrands() async {
    try {
      final result = await _dioClient.get(ApiRoutes.brands);
      final payload = result.data;

      List<dynamic> list;
      if (payload is List) {
        list = payload;
      } else if (payload is Map) {
        final inner = payload['data'] ?? payload['results'];
        list = inner is List ? inner : [];
      } else {
        list = [];
      }

      return list
          .map((item) => BrandShortModel.fromJson(
                item is Map<String, dynamic>
                    ? item
                    : Map<String, dynamic>.from(item as Map),
              ))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SocialMediaAccountStatsModel> getSocialMediaStats({
    required String platform,
    required String username,
  }) async {
    try {
      final result = await _dioClient.post(
        ApiRoutes.socialProfileStats,
        data: {'platform': platform, 'username': username},
      );
      return SocialMediaAccountStatsModel.fromJson(result.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<InfluencerAnalyticsModel> getInfluencerAnalytics() async {
    try {
      final result = await _dioClient.get(ApiRoutes.influencerAnalytics);
      return InfluencerAnalyticsModel.fromApiJson(result.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ReviewModel>> getInfluencerReviews({
    required int influencerId,
  }) async {
    try {
      final result = await _dioClient.get(
        ApiRoutes.influencerReviews(influencerId),
      );
      final payload = result.data;

      if (payload is List) {
        return payload
            .map(
              (item) => ReviewModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      }

      final root = payload is Map<String, dynamic>
          ? payload
          : payload is Map
          ? Map<String, dynamic>.from(payload)
          : <String, dynamic>{};

      final data = root['data'];
      if (data is List) {
        return data
            .map(
              (item) => ReviewModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      }

      return const [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AwardEntity> createAward({required String title}) async {
    try {
      final result = await _dioClient.post(
        ApiRoutes.myAwards,
        data: {'title': title},
      );
      final data = result.data['data'] ?? result.data;
      return AwardEntity(id: data['id'], title: data['title']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAward({required int awardId}) async {
    try {
      await _dioClient.delete(ApiRoutes.deleteAward(awardId));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AvailableDateItem> addAvailableDate({
    required String dateFrom,
    required String dateTo,
    String? note,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiRoutes.myAvailableDates,
        data: {
          'date_from': dateFrom,
          'date_to': dateTo,
          if (note != null && note.isNotEmpty) 'note': note,
        },
      );
      final payload = response.data;
      final map = payload is Map
          ? Map<String, dynamic>.from(payload)
          : <String, dynamic>{};
      return AvailableDateItem(
        id: (map['id'] as num?)?.toInt() ?? 0,
        dateFrom: map['date_from']?.toString() ?? dateFrom,
        dateTo: map['date_to']?.toString() ?? dateTo,
        note: map['note']?.toString(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAvailableDate({required int dateId}) async {
    try {
      await _dioClient.delete(ApiRoutes.myAvailableDate(dateId));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AmbassadorModel>> getAmbassadors({
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
  }) async {
    try {
      // NOTE: Query parameter names below assume DRF/REST conventions.
      // Adjust if backend uses different keys (e.g. `min_age` vs `age_from`).
      final queryParams = <String, dynamic>{};
      if (ordering != null) queryParams['ordering'] = ordering;
      if (categoryId != null) queryParams['category_id'] = categoryId;
      if (regionId != null) queryParams['region_id'] = regionId;
      if (languageId != null) queryParams['language_id'] = languageId;
      if (gender != null && gender != 'any') queryParams['gender'] = gender;
      if (ageFrom != null) queryParams['age_from'] = ageFrom;
      if (ageTo != null) queryParams['age_to'] = ageTo;
      if (isTop == true) queryParams['is_top'] = true;
      if (isVip == true) queryParams['is_vip'] = true;
      if (followersFrom != null) queryParams['followers_from'] = followersFrom;
      if (followersTo != null) queryParams['followers_to'] = followersTo;
      if (availableDate != null) queryParams['available_date'] = availableDate;
      if (currency != null) queryParams['currency'] = currency;
      if (pricePerHourFrom != null) {
        queryParams['price_per_hour_from'] = pricePerHourFrom;
      }
      if (pricePerHourTo != null) {
        queryParams['price_per_hour_to'] = pricePerHourTo;
      }
      if (role != null && role.isNotEmpty) queryParams['role'] = role;

      final response = await _dioClient.get(
        ApiRoutes.ambassadors,
        queryParameters: queryParams.isEmpty ? null : queryParams,
      );
      final payload = response.data;

      List<dynamic> list;
      if (payload is List) {
        list = payload;
      } else if (payload is Map) {
        final inner = payload['results'] ?? payload['data'];
        list = inner is List ? inner : [];
      } else {
        list = [];
      }

      return list.map((item) {
        final map = item is Map<String, dynamic>
            ? item
            : Map<String, dynamic>.from(item as Map);
        return AmbassadorModel.fromJson(map);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AmbassadorDetailModel> getAmbassadorDetail({
    required int ambassadorId,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiRoutes.profile(ambassadorId.toString()),
      );
      final payload = response.data;
      final data = payload is Map && payload['data'] is Map
          ? Map<String, dynamic>.from(payload['data'] as Map)
          : Map<String, dynamic>.from(payload as Map);
      return AmbassadorDetailModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
