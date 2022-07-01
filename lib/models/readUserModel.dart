// ignore_for_file: camel_case_types, file_names

class rudUserModel {
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

  rudUserModel({
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

  factory rudUserModel.fromJson(Map<String, dynamic> json) => rudUserModel(
        id: json['id'],
        nama: json["nama"],
        email: json["email"],
        jenisKelamin: json["jenisKelamin"],
        foto: json["foto"],
        alamat: json["alamat"],
        role: json['role'],
      );
}

class UserUpdate {
  int? id;
  int? code;
  String? nama;
  String? email;
  String? role;
  String? jenisKelamin;
  String? alamat;
  String? foto;
  String? message;

  UserUpdate(
      {this.id,
      this.code,
      this.nama,
      this.email,
      this.jenisKelamin,
      this.alamat,
      this.role,
      this.foto,
      this.message});

  factory UserUpdate.fromJson(Map<String, dynamic> json) {
    return UserUpdate(
      id: json['id'],
      nama: json['nama'],
      alamat: json['alamat'],
      jenisKelamin: json['jenisKelamin'],
      role: json['role'],
      email: json['email'],
      foto: json['foto'],
    );
  }
  factory UserUpdate.success(Map<String, dynamic> json) {
    return UserUpdate(
      code: json['code'],
    );
  }
  factory UserUpdate.error(Map<String, dynamic> json) {
    return UserUpdate(
      message: json['data'],
      code: json['code'],
    );
  }
}
