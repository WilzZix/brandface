import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/domain/usecase/registration/params/brand_registration_params.dart';
import 'package:brandface/domain/usecase/registration/params/fill_brand_profile_param.dart';
import 'package:brandface/domain/usecase/registration/params/fill_influencer_profile_param.dart';
import 'package:brandface/domain/usecase/registration/params/registration_params.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/network/dio_client.dart';
import '../../../models/registration/registration_model.dart';

abstract class RegistrationDataSource {
  Future<RegistrationModel> registration({required RegistrationParams params});

  Future<RegistrationModel> brandRegistration({
    required BrandRegistrationParams params,
  });

  Future<void> fillProfileInfo({
    required FillInfluencerProfileParam params,
    required String profileId,
  });

  Future<void> fillBrandProfileInfo({
    required FillBrandProfileParam params,
    required String profileId,
  });

  Future<void> updateMyInfluencerProfile({
    required FillInfluencerProfileParam params,
  });

  Future<void> updateMyProfileSection({
    required String url,
    required Map<String, dynamic> payload,
  });
}

class RegistrationDataSourceImpl implements RegistrationDataSource {
  final DioClient _dioClient;

  RegistrationDataSourceImpl({required DioClient dioClient})
    : _dioClient = dioClient;

  @override
  Future<RegistrationModel> registration({
    required RegistrationParams params,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiRoutes.registration,
        data: params.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegistrationModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RegistrationModel> brandRegistration({
    required BrandRegistrationParams params,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiRoutes.brandRegistration,
        data: params.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegistrationModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> fillProfileInfo({
    required FillInfluencerProfileParam params,
    required String profileId,
  }) async {
    try {
      final response = await _dioClient.patch(
        ApiRoutes.fillProfile(profileId),
        data: params.toJson(),
      );
      if (kDebugMode) debugPrint(response.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> fillBrandProfileInfo({
    required FillBrandProfileParam params,
    required String profileId,
  }) async {
    try {
      final response = await _dioClient.patch(
        ApiRoutes.fillBrandProfile(profileId),
        data: params.toJson(),
      );
      if (kDebugMode) debugPrint(response.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateMyInfluencerProfile({
    required FillInfluencerProfileParam params,
  }) async {
    try {
      final response = await _dioClient.patch(
        ApiRoutes.myProfile,
        data: params.toJson(),
      );
      if (kDebugMode) debugPrint(response.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateMyProfileSection({
    required String url,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await _dioClient.patch(url, data: payload);
      if (kDebugMode) debugPrint(response.toString());
    } catch (e) {
      rethrow;
    }
  }
}
