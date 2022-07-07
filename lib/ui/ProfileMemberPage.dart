// ignore_for_file: file_names, camel_case_types, annotate_overrides, avoid_print, deprecated_member_use, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:AKHIS/models/ProfileMemberModel.dart';
import 'package:AKHIS/services/UserSession.dart';
import 'package:AKHIS/services/ProfileMemberService.dart';
import 'package:AKHIS/ui/LoginPage.dart';
import 'package:AKHIS/widgets/BottomBar.dart';

class ProfileMemberPage extends StatefulWidget {
  const ProfileMemberPage({Key? key}) : super(key: key);

  @override
  State<ProfileMemberPage> createState() => _ProfileMemberPageState();
}

class _ProfileMemberPageState extends State<ProfileMemberPage> {
  Widget page = const CircularProgressIndicator();
  // String roleUser = 'member';
  bool role = false;
  late int id;
  @override
  void initState() {
    super.initState();
    user();
    roleUser();
    isLoginuser();
  }

  void roleUser() async {
    var getRole = await UserSession().getRole();
    setState(() {
      if (getRole == 'admin') {
        role = true;
      } else {
        role = false;
      }
    });
  }

  void user() async {
    var userid = await UserSession().getUserID();
    setState(() {
      id = userid!;
    });
  }

  void isLoginuser() async {
    var token = await UserSession().getToken();
    if (token != null) {
      setState(() {
        page = const ProfileMemberPage();
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
            child: FutureBuilder<ProfileMemberModel>(
                future: userService.GetReadUserDetail(id),
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
        bottomNavigationBar:
            role ? BottomBarAdmin(1, context) : BottomBarUser(1, context));
  }
}

class MyProfile extends StatelessWidget {
  final ProfileMemberModel? data;

  const MyProfile({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Column(
            children: [
              Image.memory(
                base64Decode("${data?.foto}"),
                fit: BoxFit.cover,
                height: 180,
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
                  await UserSession().logout();
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
