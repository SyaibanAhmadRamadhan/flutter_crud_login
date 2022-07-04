// ignore_for_file: file_names, camel_case_types, avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter_application_crud/api/Api.dart';
import 'package:flutter_application_crud/models/obatModel.dart';
import 'package:flutter_application_crud/api/apiUrl.dart';
import 'package:http/http.dart' as http;

class obatService {
  static const String _baseUrl = 'http://192.168.43.220:8000';
  static getUrl() {
    return _baseUrl;
  }

  static Future<List<obatModel>> getobatService() async {
    try {
      final response = await http.get(Uri.parse(apiUrl.obat));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final parsed = json.cast<Map<String, dynamic>>();
        return parsed
            .map<obatModel>((json) => obatModel.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future createobatService(String nama, String dosis, String deskripsi,
      String jenis, String foto) async {
    String api_url = apiUrl.tambahObat;
    var body = {
      "nama": nama,
      "dosis": dosis,
      "deskripsi": deskripsi,
      "jenis": jenis,
      "foto": foto,
    };
    var response = await Api().post(api_url, body);
    var varjson = json.decode(response.body);
    if (varjson['code'] == 200) {
      return CreateObatModel.fromJson(varjson);
    } else {
      return CreateObatModel.error(varjson);
    }
    // } else {
    //   return CreateObatModel.error(varjson);
    // }
  }

  static Future updateProduk({CreateObatModel? obat}) async {
    String api_Url = apiUrl.updateObat(obat!.id!);

    var body = {
      "nama": obat.nama,
      "jenis": obat.jenis,
      "deskripsi": obat.deskripsi,
      "dosis": obat.dosis,
      "foto": obat.foto
    };

    var response = await Api().put(api_Url, body);
    var varjson = json.decode(response.body);
    if (varjson['code'] == 200) {
      return CreateObatModel.success(varjson);
    } else {
      return CreateObatModel.error(varjson);
    }
  }

  static Future deleteProduk(id) async {
    String api_Url = apiUrl.deleteObat(id);
    var response = await Api().delete(api_Url);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  void dispose() {}
}
