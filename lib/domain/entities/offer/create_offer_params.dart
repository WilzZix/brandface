class CreateOfferParams {
  final String title;
  final List<int> categoryIds;
  final String? description;
  final String? requiredGender;
  final int? requiredAgeMin;
  final int? requiredAgeMax;
  final String? requiredRegion;
  final String? requiredCity;
  final int? requiredFollowersMin;
  final int? requiredFollowersMax;
  final String? requiredEngagementRate;
  final String? duration;
  final String? deadline;
  final String? visibility;

  const CreateOfferParams({
    required this.title,
    required this.categoryIds,
    this.description,
    this.requiredGender,
    this.requiredAgeMin,
    this.requiredAgeMax,
    this.requiredRegion,
    this.requiredCity,
    this.requiredFollowersMin,
    this.requiredFollowersMax,
    this.requiredEngagementRate,
    this.duration,
    this.deadline,
    this.visibility,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'title': title,
      'category_ids': categoryIds,
    };
    if (description != null && description!.isNotEmpty) {
      map['description'] = description;
    }
    if (requiredGender != null) map['required_gender'] = requiredGender;
    if (requiredAgeMin != null) map['required_age_min'] = requiredAgeMin;
    if (requiredAgeMax != null) map['required_age_max'] = requiredAgeMax;
    if (requiredRegion != null) map['required_region'] = requiredRegion;
    if (requiredCity != null) map['required_city'] = requiredCity;
    if (requiredFollowersMin != null) {
      map['required_followers_min'] = requiredFollowersMin;
    }
    if (requiredFollowersMax != null) {
      map['required_followers_max'] = requiredFollowersMax;
    }
    if (requiredEngagementRate != null) {
      map['required_engagement_rate'] = requiredEngagementRate;
    }
    if (duration != null) map['duration'] = duration;
    if (deadline != null) map['deadline'] = deadline;
    if (visibility != null) map['visibility'] = visibility;
    return map;
  }
}
