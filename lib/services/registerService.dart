// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter_application_crud/api/Api.dart';
import 'package:flutter_application_crud/api/apiUrl.dart';
import 'package:flutter_application_crud/models/registerModel.dart';

class registerService {
  static Future<registerModel> register(
      {String? nama,
      String? email,
      String? password,
      String? alamat,
      // String? role,
      String? jenisKelamin,
      String? foto}) async {
    String api_url = apiUrl.register;

    var body = {
      'nama': nama,
      'email': email,
      'password': password,
      'alamat': alamat,
      // 'role': role,
      'jenisKelamin': jenisKelamin,
      'foto': foto
    };
    var response = await Api().post(api_url, body);
    var var_json = json.decode(response.body);
    return registerModel.fromJson(var_json);
  }
}
