// ignore_for_file: camel_case_types, file_names

class RegisterModel {
  int? code;
  bool? status;
  String? message;
  RegisterModel({this.code, this.status, this.message});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
        code: json['code'], status: json['status'], message: json['data']);
  }

  factory RegisterModel.error(Map<String, dynamic> json) {
    return RegisterModel(
      code: json['code'],
      status: json['status'],
      message: json['data'],
    );
  }
}
