import 'package:brandface/domain/entities/registration/registration_entity.dart';

class RegistrationModel {
  String? message;
  Data? data;

  RegistrationModel({this.message, this.data});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  RegistrationEntity toEntity() {
    return RegistrationEntity(role: data!.role ?? '', profileId: data!.profileId ?? 0);
  }
}

class Data {
  String? role;
  int? profileId;

  Data({this.role, this.profileId});

  Data.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    profileId = json['profile_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['profile_id'] = profileId;
    return data;
  }
}
