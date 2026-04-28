import 'package:brandface/domain/usecase/registration/params/fill_influencer_profile_param.dart';

class FillBrandProfileParam {
  final int? logoId;
  final int? regionId;
  final int? cityId;
  final int? sphereId;
  final String? description;
  final String? website;
  final List<Contact>? contacts;
  final List<int>? categoryIds;
  final List<int>? languageIds;

  FillBrandProfileParam({
    this.logoId,
    this.regionId,
    this.cityId,
    this.sphereId,
    this.description,
    this.website,
    this.contacts,
    this.categoryIds,
    this.languageIds,
  });

  FillBrandProfileParam copyWith({
    int? logoId,
    int? regionId,
    int? cityId,
    int? sphereId,
    String? description,
    String? website,
    List<Contact>? contacts,
    List<int>? categoryIds,
    List<int>? languageIds,
  }) => FillBrandProfileParam(
    logoId: logoId ?? this.logoId,
    regionId: regionId ?? this.regionId,
    cityId: cityId ?? this.cityId,
    sphereId: sphereId ?? this.sphereId,
    description: description ?? this.description,
    website: website ?? this.website,
    contacts: contacts ?? this.contacts,
    categoryIds: categoryIds ?? this.categoryIds,
    languageIds: languageIds ?? this.languageIds,
  );

  Map<String, dynamic> toJson() {
    return {
      'logo_id': logoId,
      'region_id': regionId,
      'city_id': cityId,
      'sphere_id': sphereId,
      'description': description,
      'website': website,
      'contacts': contacts?.map((e) => e.toJson()).toList(),
      'category_ids': categoryIds,
      'language_ids': languageIds,
    }..removeWhere((key, value) => value == null);
  }
}

class FillBrandProfileRequestParams {
  final String profileId;
  final FillBrandProfileParam profileData;

  FillBrandProfileRequestParams({
    required this.profileId,
    required this.profileData,
  });
}
