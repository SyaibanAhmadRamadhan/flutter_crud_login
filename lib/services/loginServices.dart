// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter_application_crud/models/loginModel.dart';
import 'package:flutter_application_crud/services/Api.dart';
import 'package:flutter_application_crud/services/apiUrl.dart';

class loginService {
  static Future<loginModel> login({String? email, String? password}) async {
    String ApiUrl = apiUrl.login;
    var body = {'email': email, 'password': password};
    var response = await Api().post(ApiUrl, body);
    var jsonVar = json.decode(response.body);
    if (jsonVar['code'] == 200) {
      return loginModel.fromJson(jsonVar);
    } else {
      return loginModel.error(jsonVar);
    }
  }
}
