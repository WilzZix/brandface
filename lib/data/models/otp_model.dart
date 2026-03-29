import 'package:brandface/domain/entities/otp_entity.dart';

class OtpModel {
  String? message;
  Data? data;

  OtpModel({this.message, this.data});

  OtpModel.fromJson(Map<String, dynamic> json) {
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

  OtpEntity toEntity() {
    return OtpEntity(detail: data!.detail, code: data?.code);
  }
}

class Data {
  String? detail;
  String? code;

  Data({this.detail, this.code});

  Data.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = detail;
    data['code'] = code;
    return data;
  }
}
