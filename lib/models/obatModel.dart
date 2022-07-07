// ignore_for_file: file_names, camel_case_types, unused_import

// import 'dart:ffi';

class ReadObatModel {
  ReadObatModel({
    required this.id,
    required this.nama,
    required this.jenis,
    required this.dosis,
    required this.deskripsi,
    required this.foto,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String nama;
  String jenis;
  String dosis;
  String deskripsi;
  String foto;
  String createdAt;
  String updatedAt;

  factory ReadObatModel.fromJson(Map<String, dynamic> json) => ReadObatModel(
        id: json["id"],
        nama: json["nama"].toString(),
        jenis: json["jenis"].toString(),
        dosis: json["dosis"].toString(),
        deskripsi: json["deskripsi"].toString(),
        foto: json["foto"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class CreateUpdateObatModel {
  int? id;
  int? code;
  String? nama;
  String? deskripsi;
  String? jenis;
  String? foto;
  String? dosis;
  String? message;
  CreateUpdateObatModel(
      {this.id,
      this.code,
      this.nama,
      this.deskripsi,
      this.jenis,
      this.dosis,
      this.foto,
      this.message});

  factory CreateUpdateObatModel.fromJson(Map<String, dynamic> json) {
    return CreateUpdateObatModel(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      jenis: json['jenis'],
      dosis: json['dosis'],
      foto: json['foto'],
      code: json['code'],
      message: json['data'],
    );
  }
  factory CreateUpdateObatModel.success(Map<String, dynamic> json) {
    return CreateUpdateObatModel(
      code: json['code'],
    );
  }
  factory CreateUpdateObatModel.error(Map<String, dynamic> json) {
    return CreateUpdateObatModel(
      message: json['data'],
      code: json['code'],
    );
  }
}
