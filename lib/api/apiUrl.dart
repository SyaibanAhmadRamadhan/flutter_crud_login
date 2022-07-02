// import 'package:flutter/cupertino.dart';

// ignore_for_file: file_names, camel_case_types

class apiUrl {
  static const String baseUrl = "http://localhost:8000";
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String tambahObat = '$baseUrl/TambahObat';
  static const String user = '$baseUrl/showalldatauser';
  static const String obat = '$baseUrl/showalldataobat';

  static String getUserDetail(int id) {
    return '$baseUrl/showdetailuser/$id';
  }

  static String updateObat(int id) {
    return '$baseUrl/updateobat/$id';
  }

  static String deleteObat(int id) {
    return '$baseUrl/deleteobat/$id';
  }

  static String updateUser(int id) {
    return '$baseUrl/updateuser/$id';
  }

  static String deleteUser(int id) {
    return '$baseUrl/deleteuser/$id';
  }
}
