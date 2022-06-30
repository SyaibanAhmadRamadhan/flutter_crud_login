// ignore_for_file: camel_case_types, file_names

class userModel {
  int? code;
  String? id;
  String? nama;
  String? email;
  String? role;
  String? alamat;
  String? foto;
  String? jenisKelamin;
  String? password;
  userModel({
    this.code,
    this.id,
    this.email,
    this.role,
    this.alamat,
    this.nama,
    this.foto,
    this.jenisKelamin,
    this.password,
  });

  factory userModel.fromJson(Map<String, dynamic> json) {
    return userModel(
        code: json['code'],
        email: json['data']['email'],
        nama: json['data']['nama'],
        role: json['data']['role'],
        alamat: json['data']['alamat'],
        foto: json['data']['foto'],
        jenisKelamin: json['data']['jenisKelamin'],
        password: json['data']['password']);
  }
}
