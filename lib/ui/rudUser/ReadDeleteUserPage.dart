// ignore_for_file: file_names, camel_case_types
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:AKHIS/models/ReadUpdateDeleteUserModel.dart';
import 'package:AKHIS/services/ReadUpdateDeleteUserService.dart';
import 'package:AKHIS/ui/DetailUserPage.dart';
import 'package:AKHIS/ui/SearchUserPage.dart';
import 'package:AKHIS/ui/rudUser/UpdateUserPage.dart';
import 'package:AKHIS/widgets/BottomBar.dart';
import 'package:AKHIS/widgets/SuksesDialog.dart';

class ReadDeleteUserPage extends StatefulWidget {
  const ReadDeleteUserPage({Key? key}) : super(key: key);

  @override
  State<ReadDeleteUserPage> createState() => _ReadDeleteUserPageState();
}

class _ReadDeleteUserPageState extends State<ReadDeleteUserPage> {
  bool isSearching = false;
  TextEditingController user = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: !isSearching
              ? const Text(
                  'DAFTAR USER',
                  style: TextStyle(color: Colors.black, fontSize: 26),
                )
              : TextField(
                  controller: user,
                  style: const TextStyle(color: Colors.black, fontSize: 26),
                  decoration: const InputDecoration(
                      hintText: "Pencarian",
                      hintStyle: TextStyle(color: Colors.grey)),
                  onSubmitted: (value) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchUserPage(
                              user: user.text,
                            )));
                  },
                ),
          backgroundColor: Colors.blue.shade200,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
                icon: !isSearching
                    ? const Icon(
                        Icons.search,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      )),
          ],
        ),
        body: FutureBuilder<List<ReadUserModel>>(
          future: rudUserService.GetReadUserService(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<ReadUserModel> listUser = snapshot.data!;
              return Container(
                padding: const EdgeInsets.all(5),
                child: ListView.builder(
                  itemCount: listUser.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DetailUserPage(user: listUser[index])));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(top: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.memory(
                                base64Decode(listUser[index].foto),
                                width: 80,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Column(
                                    children: [
                                      Text(
                                        listUser[index].nama,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        listUser[index].email,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  UpdateUserPage(
                                                    user: listUser[index],
                                                  )));
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      size: 35,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      rudUserService
                                          .GetDeleteUserService(listUser[index].id)
                                          .then((value) => {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  builder:
                                                      (BuildContext context) =>
                                                          SuccessDialog(
                                                    description:
                                                        "Data user berhasil dihapus",
                                                    okClick: () {
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const ReadDeleteUserPage(),
                                                        ),
                                                        (route) => false,
                                                      );
                                                    },
                                                  ),
                                                )
                                              });
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      size: 35,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
        bottomNavigationBar: BottomBarAdmin(2, context));
  }
}
