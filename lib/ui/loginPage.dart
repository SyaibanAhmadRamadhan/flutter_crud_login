// ignore_for_file: file_names, unused_import, use_build_context_synchronously, prefer_const_constructors, unnecessary_new, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_application_crud/services/loginServices.dart';
import 'package:flutter_application_crud/services/userInfo.dart';
import 'package:flutter_application_crud/ui/homePage.dart';
// import 'package:flutter_application_crud/ui/obatPage.dart';
import 'package:flutter_application_crud/ui/registerPage.dart';
import 'package:flutter_application_crud/ui/userPage.dart';
import 'package:flutter_application_crud/widgets/warning_dialog.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.asset(
              //   'images/tokokitalogo.png',
              //   width: 150,
              //   height: 120,
              // ),
              SizedBox(
                height: 20,
                width: 50,
                child: _isLoading ? const CircularProgressIndicator() : null,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(248, 106, 203, 248),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _emailTextField(),
                      _passwordTextField(),
                      const SizedBox(height: 10),
                      _loginButton(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Belum punya akun? ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              registerPage()));
                                },
                                child: const Text(
                                  "Daftar",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white),
            // underline

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          obscureText: false,
          controller: _emailTextboxController,
          validator: (value) => EmailValidator.validate(value)
              ? null
              : "isi alamat email dengan benar"),
    );
  }

  Widget _passwordTextField() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Colors.white),
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        obscureText: true,
        controller: _passwordTextboxController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Password harus diisi';
          }
          return null;
        },
      ),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    loginService
        .login(
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
          await UserInfo().setRole(value.role.toString());
          await UserInfo().setToken(value.token.toString());
          await UserInfo().setUserID(value.id!);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const userPage(),
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
    setState(() {
      _isLoading = false;
    });
  }

  // Widget menuRegistrasi() {
  //   return Center(
  //     child: InkWell(
  //       child: const Text(
  //         "Registrasi?",
  //         style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
  //       ),
  //       onTap: () {
  //         // Navigator.push(context,
  //         //     MaterialPageRoute(builder: (context) => const RegistrasiPage()));
  //       },
  //     ),
  //   );
  // }

  Widget _loginButton() {
    return StreamBuilder<bool>(
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shadowColor: Colors.black,
            minimumSize: const Size.fromHeight(50),
          ),
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _submit();
            }
          },
        );
      },
    );
  }

  // create widget spacebeetwen
  Widget spaceBeetwen() {
    return const SizedBox(
      height: 20,
    );
  }
}
