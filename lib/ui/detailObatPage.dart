// ignore_for_file: unnecessary_import, file_names, unused_import, implementation_imports, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_crud/models/obatModel.dart';

class DetailObat extends StatefulWidget {
  DetailObat({required this.obat});
  final obatModel obat;

  @override
  _DetailObatState createState() => _DetailObatState();
}

class _DetailObatState extends State<DetailObat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.obat.nama),
      ),
      body: Container(
        width: double.infinity,
        child: ListView(
          children: [
            // Image.network()
            Container(
              padding: EdgeInsets.all(5),
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
                ),
              ),
              child: Text(
                widget.obat.nama,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.lightBlue,
              width: double.infinity,
              height: double.maxFinite,
              child: new Text(widget.obat.deskripsi),
            )
          ],
        ),
      ),
    );
  }
}
