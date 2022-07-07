// ignore_for_file: file_names, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:AKHIS/models/ReadUpdateDeleteUserModel.dart';

class DetailUserPage extends StatefulWidget {
  const DetailUserPage({Key? key, required this.user}) : super(key: key);
  final ReadUserModel user;
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
                        base64Decode(widget.user.foto),
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Text(
                        "email user : ${widget.user.email}",
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                    Center(
                      child: Text(
                        "nama user : ${widget.user.nama}",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    Center(
                      child: Text(
                        "role user : ${widget.user.role}",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    Center(
                      child: Text(
                        "jenisKelamin user : ${widget.user.jenisKelamin}",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    Center(
                      child: Text(
                        "alamat user : ${widget.user.alamat}",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
