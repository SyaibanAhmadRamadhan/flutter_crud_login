// ignore_for_file: file_names, camel_case_types, unnecessary_new, unused_local_variable, avoid_unnecessary_containers, import_of_legacy_library_into_null_safe, deprecated_member_use, unnecessary_const

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:AKHIS/services/RegisterService.dart';
import 'package:AKHIS/services/UserSession.dart';
import 'package:AKHIS/ui/LoginPage.dart';
import 'package:AKHIS/ui/ProfileMemberPage.dart';
import 'package:AKHIS/widgets/SuksesDialog.dart';
import 'package:AKHIS/widgets/WarningDialog.dart';
import 'package:image_picker_web/image_picker_web.dart'; // for chrome

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserSession().getToken();
    var role = await UserSession().getRole();
    if (token != null) {
      setState(() {
        const ProfileMemberPage();
      });
    } else {
      setState(() {
        const RegisterPage();
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool imageAvalible = false; // for chrome
  late Uint8List imageFile; // for chrome
  Future openImage() async {
    try {
      final image = await ImagePickerWeb.getImageAsBytes(); // for chrome
      if (image != null) {
        setState(() {
          imageFile = image;
          imageAvalible = true;
        }); // for chrome
      } else {}
    } catch (e) {
      return [];
    }
  }

  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
  final _namaTextFieldController = TextEditingController();
  final _alamatTextFieldController = TextEditingController();

  List<String> gender = ['pria', 'wanita'];
  String? _gender = "pria";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REGISTER'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      openImage();
                    },
                    child: const Text("Open Image")),
                imageAvalible
                    ? Image.memory(
                        (imageFile),
                        fit: BoxFit.cover,
                        height: 110,
                      )
                    : Container(child: const Text("No Image selected.")),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "nama lengkap",
                              labelText: "nama lengkap",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          controller: _namaTextFieldController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'nama harus diisi';
                            }
                            return null;
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "email",
                              labelText: "email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          controller: _emailTextFieldController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email harus diisi';
                            }
                            return null;
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "password",
                              labelText: "password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          controller: _passwordTextFieldController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password harus diisi';
                            }
                            return null;
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        TextFormField(
                          maxLines: 3,
                          decoration: InputDecoration(
                              hintText: "alamat",
                              labelText: "alamat",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          controller: _alamatTextFieldController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email harus diisi';
                            }
                            return null;
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Row(
                          children: <Widget>[
                            const Text(
                              "JENIS KELAMIN    ",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            ),
                            DropdownButton(
                              onChanged: (String? value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                              value: _gender,
                              items: gender.map((String? value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value!),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        ElevatedButton(
                          // color: Colors.blue,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submit();
                            }
                          },
                          child: const Text('REGISTER'),
                        ),
                        const Padding(padding: const EdgeInsets.only(top: 30)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Sudah punya akun? ",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    RegisterService
        .PostRegisterService(
            alamat: _alamatTextFieldController.text,
            nama: _namaTextFieldController.text,
            foto: base64Encode(imageFile), // for chrome
            jenisKelamin: _gender,
            email: _emailTextFieldController.text,
            password: _passwordTextFieldController.text.toString())
        .then(
      (value) async {
        if (value.code != 200) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => WarningDialog(
              description: "${value.message}",
            ),
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => SuccessDialog(
              description: "Register berhasil, silahkan login",
              okClick: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const LoginPage()));
              },
            ),
          );
        }
      },
      onError: (error) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "register gagal, silahkan coba lagi guys !",
          ),
        );
      },
    );
    setState(() {});
  }
}
