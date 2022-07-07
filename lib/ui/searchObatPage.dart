// ignore_for_file: file_names, must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'dart:convert';

import 'package:AKHIS/services/UserSession.dart';
import 'package:flutter/material.dart';
import 'package:AKHIS/models/ObatModel.dart';
import 'package:AKHIS/services/ObatServices.dart';
import 'package:AKHIS/ui/crudObat/CreateUpdateObat.dart';
import 'package:AKHIS/ui/crudObat/ReadDeleteObatPage.dart';
import 'package:AKHIS/ui/DetailObatPage.dart';
import 'package:AKHIS/widgets/SuksesDialog.dart';

class SearchObatPage extends StatefulWidget {
  late String obat;

  SearchObatPage({required this.obat});
  @override
  _SearchObatPageState createState() => _SearchObatPageState();
}

class _SearchObatPageState extends State<SearchObatPage> {
  late Future dataObat;
  List<ReadObatModel> listObat = [];
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();
  bool cekData = true;
  bool role = true;
  @override
  void initState() {
    dataObat = ObatService.GetReadObatService();
    dataObat.then((value) {
      setState(() {
        listObat = value;
        listObat = listObat
            .where((element) =>
                element.nama
                    .toLowerCase()
                    .contains(widget.obat.toLowerCase()) ||
                element.jenis.toLowerCase().contains(widget.obat.toLowerCase()))
            .toList();
        if (listObat.isEmpty) {
          cekData = false;
        }
      });
    });
    userRole();
    super.initState();
  }

  void userRole() async {
    var getRole = await UserSession().getRole();
    if (getRole == 'admin') {
      role = false;
    } else {
      role = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text(
                'PENCARIAN OBAT',
                style: TextStyle(color: Colors.black, fontSize: 26),
              )
            : TextField(
                controller: searchText,
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
      body: listObat.isEmpty
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
              itemCount: listObat.length,
              itemBuilder: (context, index) => Column(
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
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
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
                                child: Column(children: [
                                  Text(
                                    listObat[index].nama,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    listObat[index].jenis,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ]),
                              ),
                              !role
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        CreateUpdateObatPage(
                                                          obat: listObat[index],
                                                        )));
                                          },
                                          child: const Icon(Icons.edit),
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
                                                        barrierDismissible:
                                                            true,
                                                        builder: (BuildContext
                                                                context) =>
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
                                                                    const ReadDeleteObatPage(),
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
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
      floatingActionButton: !role
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
