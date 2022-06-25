// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, avoid_web_libraries_in_flutter, unused_import, avoid_unnecessary_containers, camel_case_types, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_crud/models/obatModel.dart';
import 'package:flutter_application_crud/services/obatServices.dart';
import 'package:flutter_application_crud/ui/createObat.dart';
import 'package:flutter_application_crud/ui/searchObatPage.dart';
import 'package:flutter_application_crud/ui/updateObat.dart';
import 'package:flutter_application_crud/ui/userPage.dart';

class obatPage extends StatefulWidget {
  @override
  _obatPageState createState() => _obatPageState();
}

class _obatPageState extends State<obatPage> {
  late Future obat;
  List<obatModel> listObat = [];
  obatService repository = obatService();

  bool isSearching = false;
  TextEditingController searchText = TextEditingController();

  void ambilData() {
    obat = obatService().getobatService();
    obat.then((value) {
      setState(() {
        listObat = value;
      });
    });
  }

  FutureOr onGoBack(dynamic value) {
    ambilData();
  }

  void navigateAddObat() {
    Route route = MaterialPageRoute(builder: (context) => CreateObat());
    Navigator.push(context, route).then((onGoBack));
  }

  @override
  void initState() {
    ambilData();
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
                onSubmitted: (value) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SearchObatPage(keyword: searchText.text)));
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
                  ? Icon(
                      Icons.search,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.cancel,
                      color: Colors.red,
                    )),
        ],
      ),
      body: listObat.isEmpty
          ? Center(
              child: CircularProgressIndicator(color: Colors.black),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  child: Text(listObat[index].nama),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: listObat.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateAddObat();
        },
        tooltip: 'Tambah Data',
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (i) {
          switch (i) {
            case 0:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => obatPage()));
              break;
            case 1:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => userPage()));
              break;
            default:
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'obat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: 'user')
        ],
      ),
    );
  }
}
