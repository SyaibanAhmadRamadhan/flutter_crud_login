// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'dart:convert';
import 'package:AKHIS/api/Api.dart';
import 'package:AKHIS/api/apiUrl.dart';
import 'package:AKHIS/models/RegisterModel.dart';

class RegisterService {
  static Future<RegisterModel> PostRegisterService(
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
    if (var_json['code'] == 200) {
      return RegisterModel.fromJson(var_json);
    } else {
      return RegisterModel.error(var_json);
    }
  }
}
