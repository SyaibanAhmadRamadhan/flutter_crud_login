// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, file_names, camel_case_types, unrelated_type_equality_checks

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:AKHIS/models/ObatModel.dart';
import 'package:AKHIS/services/ObatServices.dart';
import 'package:AKHIS/ui/crudObat/ReadDeleteObatPage.dart';
import 'package:AKHIS/widgets/SuksesDialog.dart';
import 'package:AKHIS/widgets/WarningDialog.dart';
import 'package:image_picker_web/image_picker_web.dart';

class CreateUpdateObatPage extends StatefulWidget {
  final ReadObatModel obat;
  const CreateUpdateObatPage({Key? key, required this.obat}) : super(key: key);

  @override
  State<CreateUpdateObatPage> createState() => _CreateUpdateObatPageState();
}

class _CreateUpdateObatPageState extends State<CreateUpdateObatPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController jenis = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController dosis = TextEditingController();
  int id = 0;
  bool _isUpdate = false;
  bool imageAvalible = false;
  bool imageUpdate = false;
  late Uint8List imageFile = Uint8List(0);
  bool imagestatus = false;

  Future openImage() async {
    try {
      final pickedFile = await ImagePickerWeb.getImageAsBytes();
      if (pickedFile != null) {
        setState(() {
          imageFile = pickedFile;
          imageAvalible = true;
        });
      } else {}
    } catch (e) {
      return [];
    }
  }

  @override
  void initState() {
    if (widget.obat.id != 0) {
      id = widget.obat.id;
      nama = TextEditingController(text: widget.obat.nama);
      jenis = TextEditingController(text: widget.obat.jenis);
      dosis = TextEditingController(text: widget.obat.dosis);
      deskripsi = TextEditingController(text: widget.obat.deskripsi);
      _isUpdate = true;
      imageUpdate = true;
      imageFile = base64Decode(widget.obat.foto);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isUpdate ? const Text('ubah data') : const Text("input data"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      openImage();
                    },
                    child: const Center(
                      child: Text('ambil gambar'),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      imageUpdate
                          ? Flexible(
                              child: !imagestatus
                                  ? GestureDetector(
                                      child: Center(
                                          child: Image.memory(
                                      (imageFile),
                                      fit: BoxFit.cover,
                                      height: 110,
                                    )))
                                  : const Center(
                                      child: Text("masukansss gambar")))
                          : Flexible(
                              child:
                                  // imageFile != '' // for android
                                  imageAvalible // for chrome
                                      ? GestureDetector(
                                          child: Center(
                                              child: Image.memory(
                                          (imageFile),
                                          fit: BoxFit.cover,
                                          height: 110,
                                        )))
                                      : const Center(
                                          child: Text("masukan gambar")))
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: nama,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'nama harus diisi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "nama obat",
                          labelText: "nama obat",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                    )),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: jenis,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'jenis harus diisi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'jenis obat',
                          labelText: 'jenis obat',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                    )),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: dosis,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'dosis harus diisi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          hintText: 'dosis obat',
                          labelText: 'dosis obat'),
                    )),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: deskripsi,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'deskripsi harus diisi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          hintText: 'deskripsi obat',
                          labelText: 'deskripsi obat'),
                    )),
                // const Divider(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: ElevatedButton(
                    // color: Colors.green,
                    onPressed: () {
                      _isUpdate ? update() : submit();
                    },
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10.0)),
                    child: const Text(
                      'SIMPAN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  update() {
    CreateUpdateObatModel createProduk = CreateUpdateObatModel(id: widget.obat.id);
    createProduk.nama = nama.text;
    createProduk.jenis = jenis.text;
    createProduk.deskripsi = deskripsi.text;
    createProduk.dosis = dosis.text;
    createProduk.foto = base64Encode(imageFile);
    ObatService.PutUpdateObatService(obat: createProduk).then((value) {
      if (value.code == 200) {
        showDialog(
          context: context,
          builder: (context) => SuccessDialog(
            description: "data obat berhasil diubah",
            okClick: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const ReadDeleteObatPage(),
                ),
                (route) => false,
              );
            },
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => WarningDialog(description: "${value.message}"),
        );
      }
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
      setState(() {});
    });
  }

  submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ObatService
          .PostCreateObatService(nama.text, deskripsi.text, jenis.text, dosis.text,
              base64Encode(imageFile))
          .then(
        (value) async {
          if (value.code != 200) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => WarningDialog(
                description: "${value.message}",
              ),
            );
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => SuccessDialog(
                description: "menambah data obat berhasil",
                okClick: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const ReadDeleteObatPage(),
                    ),
                    (route) => false,
                  );
                },
              ),
            );
          }
        },
        onError: (error) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const WarningDialog(
              description: "menambah data obat gagal !",
            ),
          );
        },
      );
      setState(() {});
    }
  }
}
