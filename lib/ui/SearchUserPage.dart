// ignore_for_file: file_names, must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'dart:convert';

import 'package:AKHIS/ui/rudUser/ReadDeleteUserPage.dart';
import 'package:AKHIS/ui/rudUser/UpdateUserPage.dart';
import 'package:AKHIS/ui/DetailUserPage.dart';
import 'package:AKHIS/widgets/SuksesDialog.dart';
import 'package:flutter/material.dart';
import 'package:AKHIS/models/ReadUpdateDeleteUserModel.dart';
import 'package:AKHIS/services/ReadUpdateDeleteUserService.dart';

class SearchUserPage extends StatefulWidget {
  late String user;

  SearchUserPage({required this.user});
  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  late Future dataUser;
  List<ReadUserModel> listUser = [];
  bool isSearching = false;
  TextEditingController user = TextEditingController();
  bool cekData = true;

  @override
  void initState() {
    dataUser = rudUserService.GetReadUserService();
    dataUser.then((value) {
      setState(() {
        listUser = value;
        listUser = listUser
            .where((element) =>
                element.nama
                    .toLowerCase()
                    .contains(widget.user.toLowerCase()) ||
                element.email
                    .toString()
                    .toLowerCase()
                    .contains(widget.user.toLowerCase()))
            .toList();
        if (listUser.isEmpty) {
          cekData = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text(
                'PENCARIAN USER',
                style: TextStyle(color: Colors.black, fontSize: 26),
              )
            : TextField(
                controller: user,
                style: TextStyle(color: Colors.black, fontSize: 26),
                decoration: InputDecoration(
                    hintText: "Pencarian",
                    hintStyle: TextStyle(color: Colors.grey)),
                onSubmitted: (value) {},
              ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: listUser.isEmpty
          ? !cekData
              ? Center(
                  child: Text(
                    'Pencarian Tidak Ditemukan',
                    style: TextStyle(fontSize: 25),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(color: Colors.black),
                )
          : ListView.builder(
              itemCount: listUser.length,
              itemBuilder: (context, index) => Column(
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
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
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
                                child: Column(children: [
                                  Text(
                                    listUser[index].nama,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    listUser[index].email,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ]),
                              ),
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
                                    child: const Icon(Icons.edit),
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
                                                        "Data berhasil dihapus",
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
                                    child: const Icon(Icons.delete),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (BuildContext context) => createObatPage(
          //             obat: obatModel(
          //           id: 0,
          //           deskripsi: '',
          //           nama: '',
          //           jenis: '',
          //           dosis: '',
          //           foto: '',
          //           createdAt: '',
          //           updatedAt: '',
          //           code: 0,
          //           message: '',
          //           status: true,
          //         ))));
        },
        tooltip: 'Tambah Data',
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
