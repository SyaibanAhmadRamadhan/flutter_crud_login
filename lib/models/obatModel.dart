// ignore_for_file: file_names, camel_case_types, unused_import

// import 'dart:ffi';

class obatModel {
  obatModel({
    required this.id,
    required this.nama,
    required this.jenis,
    required this.dosis,
    required this.deskripsi,
    required this.foto,
    this.message,
    this.code,
    this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String nama;
  String jenis;
  String dosis;
  String deskripsi;
  String foto;
  int? code;
  bool? status;
  String? message;
  String createdAt;
  String updatedAt;

  factory obatModel.fromJson(Map<String, dynamic> json) => obatModel(
        id: json["id"],
        nama: json["nama"].toString(),
        jenis: json["jenis"].toString(),
        dosis: json["dosis"].toString(),
        deskripsi: json["deskripsi"].toString(),
        foto: json["foto"].toString(),
        message: json['data'],
        code: json['code'],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class CreateObatModel {
  int? id;
  int? code;
  String? nama;
  String? deskripsi;
  String? jenis;
  String? foto;
  String? dosis;
  String? message;
  CreateObatModel(
      {this.id,
      this.code,
      this.nama,
      this.deskripsi,
      this.jenis,
      this.dosis,
      this.foto,
      this.message});

  factory CreateObatModel.fromJson(Map<String, dynamic> json) {
    return CreateObatModel(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      jenis: json['jenis'],
      dosis: json['dosis'],
      foto: json['foto'],
    );
  }
  factory CreateObatModel.success(Map<String, dynamic> json) {
    return CreateObatModel(
      code: json['code'],
    );
  }
  factory CreateObatModel.error(Map<String, dynamic> json) {
    return CreateObatModel(
      message: json['data'],
      code: json['code'],
    );
  }
}
