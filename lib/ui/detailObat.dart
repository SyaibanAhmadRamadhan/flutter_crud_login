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
        title: Text(widget.obat.nama),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          children: [
            Image.memory(
              base64Decode(widget.obat.foto),
              width: 80,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff3164bd), Color(0xff295cb5)])),
              child: Text(
                'nama obat : ${widget.obat.nama}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.lightBlue,
              width: double.infinity,
              height: double.maxFinite,
              child: Text(
                'jenis obat : ${widget.obat.jenis}',
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.lightBlue,
              width: double.infinity,
              height: double.maxFinite,
              child: Text(
                'dosis obat : ${widget.obat.dosis}',
                style: const TextStyle(fontSize: 50, color: Colors.black),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.lightBlue,
              width: double.infinity,
              height: double.maxFinite,
              child: Text(
                'deskripsi obat : ${widget.obat.deskripsi}',
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
