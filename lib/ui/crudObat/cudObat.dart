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
import 'package:image_picker/image_picker.dart'; // for android
// import 'package:image_picker_web/image_picker_web.dart'; // for chrome

class createObatPage extends StatefulWidget {
  final obatModel obat;
  const createObatPage({Key? key, required this.obat}) : super(key: key);

  @override
  State<createObatPage> createState() => _createObatPageState();
}

class _createObatPageState extends State<createObatPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController jenis = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController dosis = TextEditingController();
  int id = 0;
  bool _isUpdate = false;
  bool imageAvalible = false; // for chrome
  final ImagePicker _picker = ImagePicker(); // for run android
  bool imageUpdate = false;
  Uint8List imagepath = Uint8List(0); // for run android
  String base64string = ''; // for run android for update
  String imagefile = ''; // for run android
  // late Uint8List imageFile = Uint8List(0); // for chrome
  bool imagestatus = false; // for run android bagian update status

  Future openImage() async {
    try {
      var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      // final pickedFile = await ImagePickerWeb.getImageAsBytes(); // for chrome
      if (pickedFile != null) {
        // setState(() {
        //   imageFile = pickedFile;
        //   imageAvalible = true;
        // }); // for chrome
        imagefile = pickedFile.path; // for android
        File imagefile2 = File(imagefile); // for android
        Uint8List imagebytes = await imagefile2.readAsBytes(); // for android
        setState(() {
          base64string = base64.encode(imagebytes); // for android
          imagepath = base64.decode(base64string); // for android
          imagestatus = true; // for run android bagian update status
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
      _isUpdate = true; // for android
      imageUpdate = true;
      imagepath = base64Decode(widget.obat.foto);
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
                                      (imagepath),
                                      fit: BoxFit.cover,
                                      height: 110,
                                    ) // for android
                                          //           Image.memory(
                                          //   (imageFile),
                                          //   fit: BoxFit.cover,
                                          //   height: 110,
                                          // ) // for chrome
                                          ))
                                  : const Center(
                                      child: Text("masukansss gambar")))
                          : Flexible(
                              child: imagefile != '' // for android
                                  // imageAvalible // for chrome
                                  ? GestureDetector(
                                      child: Center(
                                          child:
                                              //       Image.file(
                                              //   File(imagefile),
                                              //   fit: BoxFit.cover,
                                              //   height: 110,
                                              // )// for android
                                              Image.memory(
                                      (imagepath),
                                      fit: BoxFit.cover,
                                      height: 110,
                                    ) // for chrome
                                          ))
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
    // jika imagefile tidak ada munculkan dialog box
    setState(() {});
    CreateObatModel createProduk = CreateObatModel(id: widget.obat.id);
    createProduk.nama = nama.text;
    createProduk.jenis = jenis.text;
    createProduk.deskripsi = deskripsi.text;
    createProduk.dosis = dosis.text;
    createProduk.foto = base64Encode(imagepath); // for android
    // createProduk.foto = base64Encode(imageFile); // for chrom
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
          .createobatService(nama.text, deskripsi.text, jenis.text, dosis.text,
              base64string) // for android
          // (nama.text, deskripsi.text, jenis.text, dosis.text,
          //     base64Encode(imageFile)) // for chrome
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
