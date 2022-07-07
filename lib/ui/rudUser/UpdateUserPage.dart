// ignore_for_file: file_names, unrelated_type_equality_checks, deprecated_member_use

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:AKHIS/models/ReadUpdateDeleteUserModel.dart';
import 'package:AKHIS/services/ReadUpdateDeleteUserService.dart';
import 'package:AKHIS/ui/rudUser/ReadDeleteUserPage.dart';
import 'package:AKHIS/widgets/SuksesDialog.dart';
import 'package:AKHIS/widgets/WarningDialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker_web/image_picker_web.dart'; // for chrome

class UpdateUserPage extends StatefulWidget {
  final ReadUserModel user;
  const UpdateUserPage({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController jenisKelamin = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController role = TextEditingController();
  int id = 0;
  bool imageUpdate = false;
  late Uint8List imageFile;
  late String _role = 'member';
  late String _gender = 'pria';
  Future openImage() async {
    try {
      final pickedFile = await ImagePickerWeb.getImageAsBytes(); // for chrome
      if (pickedFile != null) {
        setState(() {
          imageFile = pickedFile;
        });
      }
    } catch (e) {
      return [];
    }
  }

  @override
  void initState() {
    if (widget.user.id != 0) {
      id = widget.user.id;
      nama = TextEditingController(text: widget.user.nama);
      email = TextEditingController(text: widget.user.email);
      _gender = widget.user.jenisKelamin;
      _role = widget.user.role;
      alamat = TextEditingController(text: widget.user.alamat);
      imageFile = base64Decode(widget.user.foto); // for chrome
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ubah data user'),
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
                          child: !imageUpdate
                              ? GestureDetector(
                                  child: Center(
                                      child: Image.memory(
                                  (imageFile),
                                  fit: BoxFit.cover,
                                  height: 110,
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          hintText: 'nama user',
                          labelText: 'nama user'),
                    )),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email harus diisi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          hintText: 'email user',
                          labelText: 'email user'),
                    )),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: alamat,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'alamat harus diisi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          hintText: 'alamat user',
                          labelText: 'alamat user'),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(FontAwesomeIcons.male),
                      Radio(
                          value: 'pria',
                          groupValue: _gender,
                          onChanged: (String? newValue) {
                            setState(() {
                              _gender = newValue!.toString();
                            });
                          }),
                      const Text('pria'),
                      Radio(
                          value: "wanita",
                          groupValue: _gender,
                          onChanged: (String? newValue) {
                            setState(() {
                              _gender = newValue!.toString();
                            });
                          }),
                      const Text('wanita')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(FontAwesomeIcons.userGroup),
                      Radio(
                          value: 'admin',
                          groupValue: _role,
                          onChanged: (String? newValue) {
                            setState(() {
                              _role = newValue!.toString();
                            });
                          }),
                      const Text('admin'),
                      Radio(
                          value: "member",
                          groupValue: _role,
                          onChanged: (String? newValue) {
                            setState(() {
                              _role = newValue!.toString();
                            });
                          }),
                      const Text('member')
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      update();
                    },
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
    UserUpdateModel createProduk = UserUpdateModel(id: widget.user.id);
    createProduk.nama = nama.text;
    createProduk.email = email.text;
    createProduk.jenisKelamin = _gender;
    createProduk.role = _role;
    createProduk.alamat = alamat.text;
    // createProduk.foto = base64string; // for android
    createProduk.foto = base64Encode(imageFile); // for chrome
    rudUserService.PutUpdateUserService(user: createProduk).then((value) {
      if (value.code == 200) {
        showDialog(
          context: context,
          builder: (context) => SuccessDialog(
            description: "data dengan nama ${widget.user.nama}",
            okClick: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const ReadDeleteUserPage(),
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
}
