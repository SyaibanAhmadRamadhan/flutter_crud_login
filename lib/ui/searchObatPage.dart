// ignore_for_file: file_names, must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_crud/models/obatModel.dart';
import 'package:flutter_application_crud/services/obatServices.dart';

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
    data = obatService().getobatService();
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
                  'DAFTAR OBAT',
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
            : ListView.builder(
                itemCount: data2.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data2[index].nama),
                  );
                },
              ));
  }
}
