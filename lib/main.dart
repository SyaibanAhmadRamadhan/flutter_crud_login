// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:AKHIS/services/UserSession.dart';
import 'package:AKHIS/ui/LoginPage.dart';
import 'package:AKHIS/ui/ProfileMemberPage.dart';

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
    var token = await UserSession().getToken();
    if (token != null) {
      setState(() {
        page = ProfileMemberPage();
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
