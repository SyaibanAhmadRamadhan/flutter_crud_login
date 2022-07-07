// ignore_for_file: file_names, camel_case_types, avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:convert';

import 'package:AKHIS/api/Api.dart';
import 'package:AKHIS/models/ObatModel.dart';
import 'package:AKHIS/api/apiUrl.dart';
import 'package:http/http.dart' as http;

class ObatService {
  static const String _baseUrl = 'http://192.168.43.220:8000';
  static getUrl() {
    return _baseUrl;
  }

  static Future<List<ReadObatModel>> GetReadObatService() async {
    try {
      final response = await http.get(Uri.parse(apiUrl.obat));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final parsed = json.cast<Map<String, dynamic>>();
        return parsed
            .map<ReadObatModel>((json) => ReadObatModel.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future PostCreateObatService(String nama, String dosis, String deskripsi,
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
      return CreateUpdateObatModel.fromJson(varjson);
    } else {
      return CreateUpdateObatModel.error(varjson);
    }
    // } else {
    //   return CreateObatModel.error(varjson);
    // }
  }

  static Future PutUpdateObatService({CreateUpdateObatModel? obat}) async {
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
      return CreateUpdateObatModel.success(varjson);
    } else {
      return CreateUpdateObatModel.error(varjson);
    }
  }

  static Future GetDeleteObatService(id) async {
    String api_Url = apiUrl.deleteObat(id);
    var response = await Api().delete(api_Url);
    var var_jon = json.decode(response.body);
    return var_jon['status'];
  }

  void dispose() {}
}
