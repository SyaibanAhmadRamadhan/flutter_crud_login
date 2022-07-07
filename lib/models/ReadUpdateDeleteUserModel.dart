// ignore_for_file: camel_case_types, file_names

class ReadUserModel {
  int id;
  String nama;
  String email;
  String role;
  String jenisKelamin;
  String foto;
  String alamat;
  int? code;
  bool? status;
  String? message;

  ReadUserModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.role,
    required this.jenisKelamin,
    required this.foto,
    required this.alamat,
    this.message,
    this.code,
    this.status,
  });

  factory ReadUserModel.fromJson(Map<String, dynamic> json) => ReadUserModel(
        id: json['id'],
        nama: json["nama"],
        email: json["email"],
        jenisKelamin: json["jenisKelamin"],
        foto: json["foto"],
        alamat: json["alamat"],
        role: json['role'],
      );
}

class UserUpdateModel {
  int? id;
  int? code;
  String? nama;
  String? email;
  String? role;
  String? jenisKelamin;
  String? alamat;
  String? foto;
  String? message;

  UserUpdateModel(
      {this.id,
      this.code,
      this.nama,
      this.email,
      this.jenisKelamin,
      this.alamat,
      this.role,
      this.foto,
      this.message});

  factory UserUpdateModel.fromJson(Map<String, dynamic> json) {
    return UserUpdateModel(
      id: json['id'],
      nama: json['nama'],
      alamat: json['alamat'],
      jenisKelamin: json['jenisKelamin'],
      role: json['role'],
      email: json['email'],
      foto: json['foto'],
    );
  }
  factory UserUpdateModel.success(Map<String, dynamic> json) {
    return UserUpdateModel(
      code: json['code'],
    );
  }
  factory UserUpdateModel.error(Map<String, dynamic> json) {
    return UserUpdateModel(
      message: json['data'],
      code: json['code'],
    );
  }
}
