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
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String nama;
  String jenis;
  String dosis;
  String deskripsi;
  String foto;
  DateTime createdAt;
  DateTime updatedAt;

  factory obatModel.fromJson(Map<String, dynamic> json) {
    return obatModel(
      id: json["id"],
      nama: json["nama"],
      jenis: json["jenis"],
      dosis: json["dosis"],
      deskripsi: json["deskripsi"],
      foto: json["foto"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}
