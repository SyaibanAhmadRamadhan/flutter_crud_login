// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:flutter_application_crud/models/loginModel.dart';
import 'package:flutter_application_crud/services/userInfo.dart';
import 'package:flutter_application_crud/ui/adminPage.dart';
import 'package:flutter_application_crud/ui/crudObat/readObatPage.dart';
import 'package:flutter_application_crud/ui/loginPage.dart';
import 'package:flutter_application_crud/ui/userPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    var role = await UserInfo().getRole();
    if (token != null) {
      setState(() {
        if (role == 'member') {
          page = userPage();
        }
        if (role == 'admin') {
          page = adminPage();
        }
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Obat',
      debugShowCheckedModeBanner: false,
      home: page,
      // builder: EasyLoading.init(),
    );
  }
}
