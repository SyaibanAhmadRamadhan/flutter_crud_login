// ignore_for_file: unused_import, file_names, camel_case_types

// import 'package:flutter/cupertino.dart';

class loginModel {
  loginModel({
    this.code,
    this.id,
    this.token,
    // required this.nama,
    this.status,
    this.email,
    this.role,
    this.message,
    // required this.jenisKelamin,
    // required this.foto,
    // required this.alamat,
    // required this.createdAt,
    // required this.updatedAt,
  });

  int? id;
  int? code;
  // String nama;
  String? token;
  String? email;
  String? message;
  bool? status;
  String? role;
  // String jenisKelamin;
  // String foto;
  // String alamat;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory loginModel.fromJson(Map<String, dynamic> json) {
    return loginModel(
      code: json['code'],
      // nama: json["nama"],
      status: json["status"],
      email: json["email"],
      token: json['data']['token'],
      role: json["data"]["user"]["role"],
      id: json["data"]["user"]["id"],
      // jenisKelamin: json["jenisKelamin"],
      // foto: json["foto"],
      // alamat: json["alamat"],
      // createdAt: DateTime.parse(json["created_at"]),
      // updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
  factory loginModel.error(Map<String, dynamic> json) {
    return loginModel(
        code: json['code'], status: json['status'], message: json['data']);
  }
}
