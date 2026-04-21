import 'package:brandface/domain/entities/profile/catalog/language_entity.dart';

class LanguageModel {
  final String? message;
  final List<LanguageData>? data;

  LanguageModel({this.message, this.data});

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => LanguageData.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.map((e) => e.toJson()).toList()};
  }
}

class LanguageData {
  final int? id;
  final String? name;
  final String? code;

  LanguageData({this.id, this.name, this.code});

  factory LanguageData.fromJson(Map<String, dynamic> json) {
    return LanguageData(id: json['id'], name: json['name'], code: json['code']);
  }

  LanguageEntity toEntity() {
    return LanguageEntity(id: id ?? 0, name: name ?? '', code: code ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code};
  }
}
