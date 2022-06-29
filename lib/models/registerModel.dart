// ignore_for_file: camel_case_types, file_names

class registerModel {
  int? code;
  bool? status;
  String? message;
  registerModel({this.code, this.status, this.message});

  factory registerModel.fromJson(Map<String, dynamic> json) {
    return registerModel(
        code: json['code'], status: json['status'], message: json['data']);
  }

  factory registerModel.error(Map<String, dynamic> json) {
    return registerModel(
      code: json['code'],
      status: json['status'],
      message: json['data'],
    );
  }
}
