// ignore_for_file: file_names, unused_import, use_build_context_synchronously, prefer_const_constructors, unnecessary_new, import_of_legacy_library_into_null_safe, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:AKHIS/services/LoginServices.dart';
import 'package:AKHIS/services/UserSession.dart';
import 'package:AKHIS/ui/crudObat/ReadDeleteObatPage.dart';
import 'package:AKHIS/ui/RegisterPage.dart';
import 'package:AKHIS/ui/ProfileMemberPage.dart';
import 'package:AKHIS/widgets/WarningDialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TOKO OBAT'),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "email",
                            labelText: "email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        controller: _emailTextboxController,
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
                        controller: _passwordTextboxController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password harus diisi';
                          }
                          return null;
                        },
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      ElevatedButton(
                        // color: Colors.blue,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _submit();
                          }
                        },
                        child: const Text('LOGIN'),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Belum punya akun? ",
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
                                              const RegisterPage()));
                                },
                                child: const Text(
                                  "Register",
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {});
    LoginService
        .PostLoginService(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text.toString())
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
          await UserSession().setRole(value.role.toString());
          await UserSession().setToken(value.token.toString());
          await UserSession().setUserID(value.id!);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileMemberPage(),
            ),
          );
        }
      },
      onError: (error) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "Login gagal, silahkan coba lagi guys !",
          ),
        );
      },
    );
    setState(() {});
  }

  // create widget spacebeetwen
  Widget spaceBeetwen() {
    return const SizedBox(
      height: 20,
    );
  }
}
