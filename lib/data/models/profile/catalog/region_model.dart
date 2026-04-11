class RegionModel {
  final String? message;
  final List<RegionData>? data;

  RegionModel({required this.message, required this.data});

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => RegionData.fromJson(i)).toList()
          : null,
    );
  }
}

class RegionData {
  final int id;
  final String name;
  final String code;

  RegionData({required this.id, required this.name, required this.code});

  factory RegionData.fromJson(Map<String, dynamic> json) {
    return RegionData(id: json['id'], name: json['name'], code: json['code']);
  }
}
