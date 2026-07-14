base class CreateOfferParams {
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
      // Backend expects a valid decimal number, not a range string like "1-2" or "<1"
      final numericRate = _parseEngagementRate(requiredEngagementRate!);
      if (numericRate != null) {
        map['required_engagement_rate'] = numericRate;
      }
    }
    if (duration != null) map['duration'] = duration;
    if (deadline != null) map['deadline'] = deadline;
    if (visibility != null) map['visibility'] = visibility;
    return map;
  }

  /// Converts display range strings to a numeric value for the backend.
  /// Examples: '<1' → 1.0, '1-2' → 1.0, '5-10' → 5.0, '10+' → 10.0
  static double? _parseEngagementRate(String rate) {
    final trimmed = rate.trim();
    if (trimmed.isEmpty) return null;
    // '<1' → take the number after '<'
    if (trimmed.startsWith('<')) {
      return double.tryParse(trimmed.substring(1));
    }
    // '10+' → take the number before '+'
    if (trimmed.endsWith('+')) {
      return double.tryParse(trimmed.replaceAll('+', '').trim());
    }
    // '1-2', '2-5', '5-10' → take the lower bound
    if (trimmed.contains('-')) {
      final parts = trimmed.split('-');
      if (parts.isNotEmpty) return double.tryParse(parts.first.trim());
    }
    // Already a plain number
    return double.tryParse(trimmed);
  }
}
