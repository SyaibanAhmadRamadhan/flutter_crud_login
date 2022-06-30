// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter_application_crud/api/Api.dart';
import 'package:flutter_application_crud/models/userModel.dart';
import '../api/apiUrl.dart';

class userService {
  static var listUser;
  get length => null;
  get userStream => null;

  static Future<userModel> getUserDetail(int id) async {
    String api_Url = apiUrl.getUserDetail(id);
    var response = await Api().get(api_Url);
    var varjson = json.decode(response.body);
    userModel user = userModel.fromJson(varjson);
    return user;
  }
}
