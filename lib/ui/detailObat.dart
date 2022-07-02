// ignore_for_file: file_names, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_crud/models/obatModel.dart';

class detailObatPage extends StatefulWidget {
  const detailObatPage({Key? key, required this.obat}) : super(key: key);
  final obatModel obat;
  @override
  State<detailObatPage> createState() => _detailObatPageState();
}

class _detailObatPageState extends State<detailObatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.obat.dosis),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Card(
            elevation: 0,
            margin: const EdgeInsets.all(20),
            // Detail Produk
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.memory(
                        base64Decode(widget.obat.foto),
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Text(
                        "nama obat : ${widget.obat.nama}",
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                    Center(
                      child: Text(
                        "jenis obat : ${widget.obat.jenis}",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    Center(
                      child: Text(
                        "dosis obat : ${widget.obat.dosis}",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    Center(
                      child: Text(
                        "deskripsi obat : ${widget.obat.deskripsi}",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
