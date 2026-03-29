import 'package:brandface/domain/entities/verify_otp_entity.dart';

class VerifyOtpModel {
  String? message;
  Data? data;

  VerifyOtpModel({this.message, this.data});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
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

  VerifyOtpEntity toEntity() {
    return VerifyOtpEntity(access: data?.access, refresh: data?.refresh, isNewUser: data?.isNewUser, role: data?.role);
  }
}

class Data {
  String? access;
  String? refresh;
  bool? isNewUser;
  String? role;

  Data({this.access, this.refresh, this.isNewUser, this.role});

  Data.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
    isNewUser = json['is_new_user'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    data['refresh'] = refresh;
    data['is_new_user'] = isNewUser;
    data['role'] = role;
    return data;
  }
}
