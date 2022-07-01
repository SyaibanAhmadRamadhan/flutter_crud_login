// ignore_for_file: file_names, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_crud/models/readUserModel.dart';

class DetailUserPage extends StatefulWidget {
  const DetailUserPage({Key? key, required this.user}) : super(key: key);
  final rudUserModel user;
  @override
  State<DetailUserPage> createState() => DdetailUserPageState();
}

class DdetailUserPageState extends State<DetailUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.nama),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          children: [
            Image.memory(
              base64Decode(widget.user.foto),
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
                'nama user : ${widget.user.nama}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.lightBlue,
              width: double.infinity,
              height: double.maxFinite,
              child: Text(
                'jenis user : ${widget.user.email}',
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.lightBlue,
              width: double.infinity,
              height: double.maxFinite,
              child: Text(
                'dosis user : ${widget.user.alamat}',
                style: const TextStyle(fontSize: 50, color: Colors.black),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.lightBlue,
              width: double.infinity,
              height: double.maxFinite,
              child: Text(
                'deskripsi user : ${widget.user.jenisKelamin}',
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
