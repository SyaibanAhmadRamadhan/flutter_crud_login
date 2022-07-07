// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'dart:convert';
import 'package:AKHIS/models/LoginModel.dart';
import 'package:AKHIS/api/Api.dart';
import 'package:AKHIS/api/apiUrl.dart';

class LoginService {
  static Future<LoginModel> PostLoginService(
      {String? email, String? password}) async {
    String ApiUrl = apiUrl.login;
    var body = {'email': email, 'password': password};
    var response = await Api().post(ApiUrl, body);
    var jsonVar = json.decode(response.body);
    if (jsonVar['code'] == 200) {
      return LoginModel.fromJson(jsonVar);
    } else {
      return LoginModel.error(jsonVar);
    }
  }
}
