// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_crud/models/obatModel.dart';
import 'package:flutter_application_crud/models/userModel.dart';
import 'package:flutter_application_crud/services/obatServices.dart';
import 'package:flutter_application_crud/services/userInfo.dart';
import 'package:flutter_application_crud/services/userService.dart';
import 'package:flutter_application_crud/ui/detailObat.dart';
// import 'package:flutter_application_crud/ui/searchObatPage.dart';
import 'package:flutter_application_crud/widgets/bottomBar.dart';

class obatPage extends StatefulWidget {
  const obatPage({Key? key}) : super(key: key);

  @override
  _obatPageState createState() => _obatPageState();
}

class _obatPageState extends State<obatPage> {
  userModel user = userModel();

  bool isSearching = false;
  TextEditingController searchText = TextEditingController();

  void admin() async {
    var role = await UserInfo().getRole();
    await UserInfo().getUserID().then((id) => {
          userService.getUserDetail(id!).then((data) => {
                setState(() {
                  role = role.toString();
                  user = data;
                })
              })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: !isSearching
              ? const Text(
                  'DAFTAR OBAT',
                  style: TextStyle(color: Colors.black, fontSize: 26),
                )
              : TextField(
                  controller: searchText,
                  style: const TextStyle(color: Colors.black, fontSize: 26),
                  decoration: const InputDecoration(
                      hintText: "Pencarian",
                      hintStyle: TextStyle(color: Colors.grey)),
                  onSubmitted: (value) {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) =>
                    //         SearchObatPage(keyword: searchText.text)));
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
        body: FutureBuilder<List<obatModel>>(
          future: obatService.getobatService(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<obatModel> listObat = snapshot.data!;
              return Container(
                padding: const EdgeInsets.all(5),
                child: ListView.builder(
                  itemCount: listObat.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  detailObatPage(obat: listObat[index])));
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
                                base64Decode(listObat[index].foto),
                                width: 80,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Column(
                                    children: [
                                      Text(
                                        listObat[index].nama,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        listObat[index].jenis,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  )),
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
        bottomNavigationBar: bottomBarUser(0, context));
  }
}
