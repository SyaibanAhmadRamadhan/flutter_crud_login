// ignore_for_file: file_names, must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_crud/models/obatModel.dart';
import 'package:flutter_application_crud/services/obatServices.dart';
import 'package:flutter_application_crud/ui/crudObat/cudObat.dart';
import 'package:flutter_application_crud/ui/crudObat/readObatPage.dart';
import 'package:flutter_application_crud/ui/detailObat.dart';
import 'package:flutter_application_crud/widgets/succesDialog.dart';

class SearchObatPage extends StatefulWidget {
  late String keyword;

  SearchObatPage({required this.keyword});
  @override
  _SearchObatPageState createState() => _SearchObatPageState();
}

class _SearchObatPageState extends State<SearchObatPage> {
  late Future data;
  List<obatModel> data2 = [];
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();
  bool cekData = true;

  @override
  void initState() {
    data = obatService.getobatService();
    data.then((value) {
      setState(() {
        data2 = value;
        data2 = data2
            .where((element) =>
                element.nama
                    .toLowerCase()
                    .contains(widget.keyword.toLowerCase()) ||
                element.jenis
                    .toString()
                    .toLowerCase()
                    .contains(widget.keyword.toLowerCase()))
            .toList();
        if (data2.isEmpty) {
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
      body: data2.isEmpty
          ? cekData
              ? Center(
                  child: CircularProgressIndicator(color: Colors.black),
                )
              : Center(
                  child: Text(
                    'Pencarian Tidak Ditemukan',
                    style: TextStyle(fontSize: 25),
                  ),
                )
          : FutureBuilder<List<obatModel>>(
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
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.memory(
                                    base64Decode(listObat[index].foto),
                                    width: 80,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Column(
                                        children: [
                                          Text(
                                            listObat[index].nama,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            listObat[index].jenis,
                                            style:
                                                const TextStyle(fontSize: 13),
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
                                                  builder:
                                                      (BuildContext context) =>
                                                          createObatPage(
                                                            obat:
                                                                listObat[index],
                                                          )));
                                        },
                                        child: const Icon(Icons.edit),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          obatService
                                              .deleteProduk(listObat[index].id)
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
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const readObatPage(),
                                                            ),
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
                      ),
                    ),
                  );
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => createObatPage(
                      obat: obatModel(
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
      ),
    );
  }
}
