// ignore_for_file: file_names, camel_case_types, annotate_overrides, avoid_print, deprecated_member_use, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_crud/models/userModel.dart';
import 'package:flutter_application_crud/services/userInfo.dart';
import 'package:flutter_application_crud/services/userService.dart';
import 'package:flutter_application_crud/ui/crudObat/readObatPage.dart';
import 'package:flutter_application_crud/ui/loginPage.dart';
import 'package:flutter_application_crud/ui/rudUser/readUserPage.dart';

class adminPage extends StatefulWidget {
  const adminPage({Key? key}) : super(key: key);

  @override
  State<adminPage> createState() => _adminPageState();
}

class _adminPageState extends State<adminPage> {
  Widget page = const CircularProgressIndicator();
  int id = 1;
  String? role;
  String rolee = "member";
  void initState() {
    isUser();
    isAdmin();
    isLoginuser();
    super.initState();
  }

  void isLoginuser() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const adminPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  void isUser() async {
    var userID = await UserInfo().getUserID();
    setState(() {
      id = userID!;
    });
  }

  void isAdmin() async {
    var role = await UserInfo().getRole();
    setState(() {
      role = role.toString();
    });
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        onTap: (i) async {
          switch (i) {
            case 0:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const readObatPage()));
              break;
            case 1:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const adminPage()));
              break;
            case 2:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const readUserPage()));
              break;
            default:
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'obat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: 'profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: 'user')
        ],
      ),
    );
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
              RaisedButton(
                color: Colors.blue,
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
