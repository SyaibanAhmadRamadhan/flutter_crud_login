// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, file_names, camel_case_types

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_crud/models/obatModel.dart';
import 'package:flutter_application_crud/services/obatServices.dart';
import 'package:flutter_application_crud/ui/crudObat/readObatPage.dart';
import 'package:flutter_application_crud/widgets/succesDialog.dart';
import 'package:flutter_application_crud/widgets/warning_dialog.dart';
import 'package:image_picker/image_picker.dart';

class createObatPage extends StatefulWidget {
  final obatModel obat;
  const createObatPage({Key? key, required this.obat}) : super(key: key);
  // const createObatPage({Key? key}) : super(key: key);

  @override
  State<createObatPage> createState() => _createObatPageState();
}

class _createObatPageState extends State<createObatPage> {
  final _formKey = GlobalKey<FormState>();
  // TextEditingController? nama, jenis, dosis, deskripsi;
  TextEditingController nama = TextEditingController();
  TextEditingController jenis = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController dosis = TextEditingController();
  int id = 0;
  bool _isUpdate = false;
  final ImagePicker _picker = ImagePicker();
  bool imageUpdate = false;
  // late Uint8List imagepath;
  String imagepath = '';
  String base64string = '';

  Future openImage() async {
    try {
      var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;

        File imagefile = File(imagepath); //convert Path to File
        Uint8List imagebytes = await imagefile.readAsBytes();
        base64string = base64.encode(imagebytes);
        // Uint8List decodedbytes = base64.decode(base64string);
        //decode base64 stirng to bytes

        setState(() {});
      } else {
        // print("No image is selected.");
      }
    } catch (e) {
      // print("error while picking file.");
    }
  }

  @override
  void initState() {
    // nama = TextEditingController();
    // jenis = TextEditingController();
    // dosis = TextEditingController();
    // deskripsi = TextEditingController();
    if (widget.obat.id != 0) {
      id = widget.obat.id;
      nama = TextEditingController(text: widget.obat.nama);
      jenis = TextEditingController(text: widget.obat.jenis);
      dosis = TextEditingController(text: widget.obat.dosis);
      deskripsi = TextEditingController(text: widget.obat.deskripsi);
      _isUpdate = true;
      // imagepath = base64Decode(widget.obat.foto);
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
                      Flexible(
                          child: imagepath != ''
                              ? GestureDetector(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(imagepath),
                                        fit: BoxFit.fitHeight,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1,
                                      )))
                              : const Center(child: Text("masukan gambar")))
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
                      decoration: const InputDecoration(
                          icon: Icon(Icons.perm_identity),
                          hintText: 'nama obat',
                          labelText: 'nama obat'),
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
                      decoration: const InputDecoration(
                          icon: Icon(Icons.assignment_ind),
                          hintText: 'jenis obat',
                          labelText: 'jenis obat'),
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
                      decoration: const InputDecoration(
                          icon: Icon(Icons.perm_identity),
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
                      decoration: const InputDecoration(
                          icon: Icon(Icons.perm_identity),
                          hintText: 'deskripsi obat',
                          labelText: 'deskripsi obat'),
                    )),
                const Divider(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      _isUpdate ? update() : submit();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
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
    // jika imagefile tidak ada munculkan dialog box
    setState(() {});
    CreateObatModel createProduk = CreateObatModel(id: widget.obat.id);
    createProduk.nama = nama.text;
    createProduk.jenis = jenis.text;
    // remove dot from string
    createProduk.deskripsi = deskripsi.text;
    createProduk.dosis = dosis.text;
    // createProduk.gambarProduk = base64Encode(imageFile);
    obatService.updateProduk(obat: createProduk).then((value) {
      if (value.code == 200) {
        showDialog(
          context: context,
          builder: (context) => SuccessDialog(
            description: "data obat berhasil diubah",
            okClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const readObatPage(),
                ),
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
      obatService
          .createobatService(
              nama.text, deskripsi.text, jenis.text, dosis.text, base64string)
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const readObatPage()));
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
              description: "register gagal, silahkan coba lagi guys !",
            ),
          );
        },
      );
      setState(() {});
    }
  }
}
