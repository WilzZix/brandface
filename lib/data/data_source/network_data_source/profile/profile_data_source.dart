import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/data/models/profile/catalog/category_model.dart';
import 'package:brandface/data/models/profile/catalog/city_model.dart';
import 'package:brandface/data/models/profile/catalog/language_model.dart';
import 'package:brandface/data/models/profile/catalog/region_model.dart';
import 'package:brandface/data/models/profile/catalog/service_type_model.dart';
import 'package:brandface/data/models/profile/catalog/sphere_model.dart';
import 'package:brandface/data/models/profile/review_model.dart';
import 'package:brandface/domain/entities/profile/award_entity.dart';

import '../../../../core/network/dio_client.dart';
import '../../../models/profile/catalog/influencer_profile_information_model.dart';
import '../../../models/profile/catalog/social_media_account_stats_model.dart';
import '../../../models/profile/influencer_analytics_model.dart';
import '../../../models/profile/profile_model.dart';

abstract class ProfileDataSource {
  Future<ProfileModel> getProfile({required String profileId});

  Future<InfluencerProfileInformationModel> getInfluencerProfile();

  Future<CategoryModel> getCategories();

  Future<ServiceTypeModel> getServices();

  Future<List<RegionModel>> getRegions();

  Future<List<CityModel>> getCities();

  Future<List<SphereModel>> getSpheres();

  Future<LanguageModel> getLanguages();

  Future<SocialMediaAccountStatsModel> getSocialMediaStats({
    required String platform,
    required String username,
  });

  Future<InfluencerAnalyticsModel> getInfluencerAnalytics();

  Future<List<ReviewModel>> getInfluencerReviews({required int influencerId});

  Future<AwardEntity> createAward({required String title});

  Future<void> deleteAward({required int awardId});
}

class ProfileDataSourceImpl implements ProfileDataSource {
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
}
