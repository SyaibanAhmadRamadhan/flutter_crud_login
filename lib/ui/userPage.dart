// ignore_for_file: file_names, camel_case_types, annotate_overrides, avoid_print, deprecated_member_use, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_crud/models/userModel.dart';
import 'package:flutter_application_crud/services/userInfo.dart';
import 'package:flutter_application_crud/services/userService.dart';
import 'package:flutter_application_crud/ui/loginPage.dart';
import 'package:flutter_application_crud/widgets/bottomBar.dart';

class userPage extends StatefulWidget {
  const userPage({Key? key}) : super(key: key);

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  Widget page = const CircularProgressIndicator();
  String roleUser = 'member';
  int id = 1;
  String? role;
  void initState() {
    isLoginuser();
    super.initState();
  }

  void isLoginuser() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const userPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("profile")),
        body: Card(
          margin: const EdgeInsets.all(16),
          child: Container(
            alignment: Alignment.center,
            child: FutureBuilder<userModel>(
                future: userService.getUserDetail(id),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? MyProfile(
                          data: snapshot.data,
                        )
                      : const Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        );
                }),
          ),
        ),
        bottomNavigationBar: bottomBarUser(1, context));
  }
}

class MyProfile extends StatelessWidget {
  final userModel? data;

  const MyProfile({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Icon(Icons.person, size: 150),
              // const SizedBox(height: 16),
              Image.memory(
                base64Decode("${data?.foto}"),
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                'nama : ${data?.nama}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              Text(
                'email : ${data?.email}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "role : ${data?.role}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "gender : ${data?.jenisKelamin}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "alamat : ${data?.alamat}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                // color: Colors.blue,
                child: const Text('LOG OUT'),
                onPressed: () async {
                  await UserInfo().logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage(),
                    ),
                    (route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                      "Berhasil logout",
                      style: TextStyle(fontSize: 16),
                    )),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
