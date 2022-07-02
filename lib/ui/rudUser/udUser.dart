// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_crud/models/readUserModel.dart';
import 'package:flutter_application_crud/services/readUserService.dart';
import 'package:flutter_application_crud/ui/rudUser/readUserPage.dart';
import 'package:flutter_application_crud/widgets/succesDialog.dart';
import 'package:flutter_application_crud/widgets/warning_dialog.dart';
import 'package:image_picker/image_picker.dart';

class UpdateDeleteUser extends StatefulWidget {
  final rudUserModel user;
  const UpdateDeleteUser({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateDeleteUser> createState() => _UpdateDeleteUserState();
}

class _UpdateDeleteUserState extends State<UpdateDeleteUser> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController jenisKelamin = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController role = TextEditingController();
  int id = 0;
  final ImagePicker _picker = ImagePicker();
  bool imageUpdate = false;
  late Uint8List imagepath;
  String base64string = '';
  String imagefile = '';
  late String _role = 'member';
  late String _gender = 'pria';
  Future openImage() async {
    try {
      var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagefile = pickedFile.path;

        File imagefile2 = File(imagefile); //convert Path to File
        Uint8List imagebytes = await imagefile2.readAsBytes();
        base64string = base64.encode(imagebytes);
        imagepath = base64.decode(base64string);
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
    if (widget.user.id != 0) {
      id = widget.user.id;
      nama = TextEditingController(text: widget.user.nama);
      email = TextEditingController(text: widget.user.email);
      // jenisKelamin = TextEditingController(text: widget.user.jenisKelamin);
      // role = TextEditingController(text: widget.user.role);
      _gender = widget.user.jenisKelamin;
      _role = widget.user.role;
      alamat = TextEditingController(text: widget.user.alamat);
      imagepath = base64Decode(widget.user.foto);
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
                                  (imagepath),
                                  fit: BoxFit.cover,
                                  // width: MediaQuery.of(context).size.width,
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
                      decoration: const InputDecoration(
                          icon: Icon(Icons.perm_identity),
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
                      decoration: const InputDecoration(
                          icon: Icon(Icons.assignment_ind),
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
                      decoration: const InputDecoration(
                          icon: Icon(Icons.perm_identity),
                          hintText: 'alamat user',
                          labelText: 'alamat user'),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(Icons.generating_tokens_sharp),
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
                      const Icon(Icons.visibility),
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
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      update();
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
    UserUpdate createProduk = UserUpdate(id: widget.user.id);
    createProduk.nama = nama.text;
    createProduk.email = email.text;
    createProduk.jenisKelamin = _gender;
    createProduk.role = _role;
    createProduk.alamat = alamat.text;
    createProduk.foto = base64Encode(imagepath);
    rudUserService.updateUser(user: createProduk).then((value) {
      if (value.code == 200) {
        showDialog(
          context: context,
          builder: (context) => SuccessDialog(
            description: "data dengan nama ${widget.user.nama}",
            okClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const readUserPage(),
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
}
