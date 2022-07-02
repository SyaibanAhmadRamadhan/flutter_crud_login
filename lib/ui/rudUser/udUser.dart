// ignore_for_file: file_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_crud/models/readUserModel.dart';
import 'package:flutter_application_crud/services/readUserService.dart';
import 'package:flutter_application_crud/ui/rudUser/readUserPage.dart';
import 'package:flutter_application_crud/widgets/succesDialog.dart';
import 'package:flutter_application_crud/widgets/warning_dialog.dart';
// import 'package:image_picker/image_picker.dart'; // for android
import 'package:image_picker_web/image_picker_web.dart'; // for chrome

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
  // final ImagePicker _picker = ImagePicker(); // for android
  bool imageUpdate = false; // for android
  bool imageAvalible = false; // for chrome
  late Uint8List imageFile; // for chrome
  // late Uint8List imagepath; // for android
  // String base64string = ''; // for android
  // String imagefile = ''; // for android
  late String _role = 'member';
  late String _gender = 'pria';
  Future openImage() async {
    try {
      // var pickedFile = await _picker.pickImage(source: ImageSource.gallery); // for android
      final pickedFile = await ImagePickerWeb.getImageAsBytes(); // for chrome
      if (pickedFile != null) {
        setState(() {
          imageFile = pickedFile;
          imageAvalible = true;
        }); // for chrome

        // imagefile = pickedFile.path; // for android
        // File imagefile2 = File(imagefile); // for android
        // Uint8List imagebytes = await imagefile2.readAsBytes(); // for android
        // base64string = base64.encode(imagebytes); // for android
        // imagepath = base64.decode(base64string); // for android
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
      imageFile = base64Decode(widget.user.foto); // for android
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
                                      child:
                                          //       Image.memory(
                                          //   (imagepath),
                                          //   fit: BoxFit.cover,
                                          //   height: 110,
                                          // )// for android

                                          Image.memory(
                                  (imageFile),
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
                  child: ElevatedButton(
                    // color: Colors.green,
                    onPressed: () {
                      update();
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
    UserUpdate createProduk = UserUpdate(id: widget.user.id);
    createProduk.nama = nama.text;
    createProduk.email = email.text;
    createProduk.jenisKelamin = _gender;
    createProduk.role = _role;
    createProduk.alamat = alamat.text;
    // createProduk.foto = base64Encode(imagepath); // for android
    createProduk.foto = base64Encode(imageFile); // for chrome
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
