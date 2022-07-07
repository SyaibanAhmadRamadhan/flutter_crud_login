// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api

import 'dart:convert';
import 'package:AKHIS/services/UserSession.dart';
import 'package:flutter/material.dart';
import 'package:AKHIS/models/ObatModel.dart';
import 'package:AKHIS/services/ObatServices.dart';
import 'package:AKHIS/ui/crudObat/CreateUpdateObat.dart';
import 'package:AKHIS/ui/DetailObatPage.dart';
import 'package:AKHIS/ui/SearchObatPage.dart';
import 'package:AKHIS/widgets/BottomBar.dart';
import 'package:AKHIS/widgets/SuksesDialog.dart';

class ReadDeleteObatPage extends StatefulWidget {
  const ReadDeleteObatPage({Key? key}) : super(key: key);

  @override
  _ReadDeleteObatPageState createState() => _ReadDeleteObatPageState();
}

class _ReadDeleteObatPageState extends State<ReadDeleteObatPage> {
  bool isSearching = false;
  bool role = true;
  bool roleBottom = true;
  TextEditingController searchText = TextEditingController();
  @override
  void initState() {
    userRole();
    // userRoleBottom();
    super.initState();
  }

  // void userRoleBottom() async {
  //   var role1 = await UserInfo().getRole();
  //   setState(() {
  //     if (role1 == 'admin') {
  //       roleBottom = true;
  //     }
  //     if (role1 == 'member') {
  //       roleBottom = false;
  //     }
  //   });
  // }

  void userRole() async {
    var getRole = await UserSession().getRole();
    setState(() {
      if (getRole == 'admin') {
        role = true;
      }
      if (getRole == 'member') {
        role = false;
      }
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SearchObatPage(
                            obat: searchText.text,
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
      body: FutureBuilder<List<ReadObatModel>>(
        future: ObatService.GetReadObatService(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<ReadObatModel> listObat = snapshot.data!;
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
                                DetailObatPage(obat: listObat[index])));
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
                            role
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          CreateUpdateObatPage(
                                                            obat:
                                                                listObat[index],
                                                          )));
                                        },
                                        child: const Icon(Icons.edit, size: 35),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          ObatService
                                              .GetDeleteObatService(listObat[index].id)
                                              .then((value) => {
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: (BuildContext
                                                              context) =>
                                                          SuccessDialog(
                                                        description:
                                                            "Data berhasil dihapus",
                                                        okClick: () {
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const ReadDeleteObatPage(),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  });
                                        },
                                        child:
                                            const Icon(Icons.delete, size: 35),
                                      )
                                    ],
                                  )
                                : const SizedBox()
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
      bottomNavigationBar:
          role ? BottomBarAdmin(0, context) : BottomBarUser(0, context),
      floatingActionButton: role
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => CreateUpdateObatPage(
                            obat: ReadObatModel(
                          id: 0,
                          deskripsi: '',
                          nama: '',
                          jenis: '',
                          dosis: '',
                          foto: '',
                          createdAt: '',
                          updatedAt: '',
                          // status: true,
                        ))));
              },
              tooltip: 'Tambah Data',
              backgroundColor: Colors.black,
              child: const Icon(Icons.add),
            )
          : const SizedBox(),
    );
  }
}
