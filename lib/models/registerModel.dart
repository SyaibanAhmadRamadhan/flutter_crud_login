// ignore_for_file: camel_case_types, file_names

class registerModel {
  int? code;
  bool? status;
  String? data;
  registerModel({this.code, this.status, this.data});

  factory registerModel.fromJson(Map<String, dynamic> json) {
    return registerModel(
        code: json['code'], status: json['status'], data: json['data']);
  }
}
