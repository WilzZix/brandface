import 'package:brandface/domain/usecase/registration/params/fill_influencer_profile_param.dart';

class FillBrandProfileParam {
  final int? logoId;
  final String? logoUrl;
  final int? regionId;
  final int? cityId;
  final int? sphereId;
  final String? description;
  final String? website;
  final List<Contact>? contacts;
  final List<int>? categoryIds;

  FillBrandProfileParam({
    this.logoId,
    this.logoUrl,
    this.regionId,
    this.cityId,
    this.sphereId,
    this.description,
    this.website,
    this.contacts,
    this.categoryIds,
  });

  FillBrandProfileParam copyWith({
    int? logoId,
    String? logoUrl,
    int? regionId,
    int? cityId,
    int? sphereId,
    String? description,
    String? website,
    List<Contact>? contacts,
    List<int>? categoryIds,
  }) => FillBrandProfileParam(
    logoId: logoId ?? this.logoId,
    logoUrl: logoUrl ?? this.logoUrl,
    regionId: regionId ?? this.regionId,
    cityId: cityId ?? this.cityId,
    sphereId: sphereId ?? this.sphereId,
    description: description ?? this.description,
    website: website ?? this.website,
    contacts: contacts ?? this.contacts,
    categoryIds: categoryIds ?? this.categoryIds,
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
