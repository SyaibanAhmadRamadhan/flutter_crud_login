// ignore_for_file: unused_import, file_names, camel_case_types

// import 'package:flutter/cupertino.dart';

class LoginModel {
  LoginModel({
    this.code,
    this.id,
    this.token,
    this.status,
    this.email,
    this.role,
    this.message,
  });

  int? id;
  int? code;
  String? token;
  String? email;
  String? message;
  bool? status;
  String? role;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      code: json['code'],
      status: json["status"],
      email: json["email"],
      token: json['data']['token'],
      role: json["data"]["user"]["role"],
      id: json["data"]["user"]["id"],
    );
  }
  factory LoginModel.error(Map<String, dynamic> json) {
    return LoginModel(
      code: json['code'],
      status: json['status'],
      message: json['data'],
    );
  }
}
