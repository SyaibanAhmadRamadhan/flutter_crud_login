// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_crud/services/obatServices.dart';
import 'package:flutter_application_crud/ui/searchObatPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CreateObat extends StatefulWidget {
  const CreateObat({Key? key}) : super(key: key);

  @override
  State<CreateObat> createState() => _CreateObatState();
}

class _CreateObatState extends State<CreateObat> {
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController dosis = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController foto = TextEditingController();
  String? jenisObat;
  int count = 0;

  void createData() {
    obatService()
        .createobatService(
            nama.text, dosis.text, deskripsi.text, jenisObat!, foto.text)
        .then((value) {
      setState(() {
        if (value) {
          Alert(
              context: context,
              title: "berhasil",
              desc: "Data telah tersimpan",
              type: AlertType.success,
              buttons: [
                DialogButton(
                    child: Text(
                      "Oke",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    })
              ]).show();
        } else {
          Alert(
              context: context,
              title: "gagal",
              desc: "data gagal disimpan",
              type: AlertType.error,
              buttons: [
                DialogButton(
                    child: Text("error"),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]).show();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text(
                'ADD OBAT',
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
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
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
                    ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nama,
              decoration: InputDecoration(
                  hintText: 'Masukan Nama Obat',
                  labelText: 'Nama Obat',
                  icon: Icon(Icons.assignment_outlined)),
            ),
            TextField(
              controller: dosis,
              decoration: InputDecoration(
                  hintText: 'Masukan Dosis Obat',
                  labelText: 'Dosis Obat',
                  icon: Icon(Icons.assignment_outlined)),
            ),
            TextField(
              controller: deskripsi,
              decoration: InputDecoration(
                  hintText: 'Masukan Deskripsi Obat',
                  labelText: 'Deskripsi Obat',
                  icon: Icon(Icons.assignment_outlined)),
            ),
            TextField(
              controller: foto,
              decoration: InputDecoration(
                  hintText: 'Masukan foto Obat',
                  labelText: 'foto Obat',
                  icon: Icon(Icons.assignment_outlined)),
            ),
            Row(
              children: [
                Radio(
                    value: 'Resep Dokter',
                    groupValue: jenisObat,
                    onChanged: (String? value) {
                      setState(() {
                        jenisObat = value;
                      });
                    }),
                Text("Resep Dokter", style: TextStyle(fontSize: 20)),
                Radio(
                    value: "Non Resep Dokter",
                    groupValue: jenisObat,
                    onChanged: (String? value) {
                      setState(() {
                        jenisObat = value;
                      });
                    }),
                Text(
                  "Non Resep Dokter",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  createData();
                },
                child: Text(
                  "Simpan Data",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
