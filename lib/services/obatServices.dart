// ignore_for_file: file_names, camel_case_types, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter_application_crud/models/obatModel.dart';
import 'package:http/http.dart' as http;

class obatService {
  static const String _baseUrl = 'http://192.168.43.220:8000';
  static getUrl() {
    return _baseUrl;
  }

  Future getobatService() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/showalldataobat'));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<obatModel> obat = it.map((e) => obatModel.fromJson(e)).toList();
        return obat;
      } else {
        throw Exception("Gagal Load Data");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future createobatService(String nama, String dosis, String deskripsi,
      String jenis, String foto) async {
    try {
      final response =
          await http.post(Uri.parse(_baseUrl + '/TambahObat'), body: {
        "nama": nama,
        "dosis": dosis,
        "deskripsi": deskripsi,
        "jenis": jenis,
        "foto": foto,
      });
      if (response.statusCode == 200) {
        print("penyimpnan berhasil");
        return true;
      } else {
        print("gagal menyimpan data");
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateObatService(int id, String nama, String dosis, String deskripsi,
      String jenis, String foto) async {
    // Uri urlApi = Uri.parse(_baseUrl + 'updateobat');
    try {
      final response = await http
          .put(Uri.parse(_baseUrl + '/updateobat/' + id.toString()), body: {
        "nama": nama,
        "dosis": dosis,
        "deskripsi": deskripsi,
        "jenis": jenis,
        "foto": foto,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
