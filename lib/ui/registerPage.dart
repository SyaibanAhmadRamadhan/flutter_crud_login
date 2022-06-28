// ignore_for_file: file_names, camel_case_types, unnecessary_new, unused_local_variable, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_application_crud/services/registerService.dart';
import 'package:flutter_application_crud/ui/loginPage.dart';
import 'package:flutter_application_crud/widgets/succesDialog.dart';
import 'package:flutter_application_crud/widgets/warning_dialog.dart';
import 'package:image_picker/image_picker.dart';

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool imageAvalible = false;
  // XFile? imageFile;
  // late String imageData;

  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  String base64string = "";
  Future openImage() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;

        File imagefile = File(imagepath); //convert Path to File
        Uint8List imagebytes = await imagefile.readAsBytes();
        base64string = base64.encode(imagebytes);
        Uint8List decodedbytes = base64.decode(base64string);
        //decode base64 stirng to bytes

        setState(() {});
      } else {
        // print("No image is selected.");
      }
    } catch (e) {
      // print("error while picking file.");
    }
  }

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();
  final _namaTextFieldController = TextEditingController();
  final _alamatTextFieldController = TextEditingController();
  // final _fotoTextFieldController = TextEditingController();
  final _jeniKelaminTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Container(
              //   child: _file == null ? Text('uload image') : Image.file(_file),
              // ),
              imagepath != ""
                  ? Image.file(File(imagepath))
                  : Container(
                      child: const Text("No Image selected."),
                    ),

              //open button ----------------
              ElevatedButton(
                  onPressed: () {
                    openImage();
                  },
                  child: const Text("Open Image")),
              SizedBox(
                height: 20,
                width: 50,
                child: _isLoading ? const CircularProgressIndicator() : null,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(248, 0, 0, 0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _emailTextField(),
                      _passwordTextField(),
                      _namaTextField(),
                      _alamatTextField(),
                      _jenisKelaminTextField(),
                      const SizedBox(height: 10),
                      _registerButton(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Sudah punya akun? ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _uploadimage() {
  //   return FormField(
  //     builder: (FormFieldState<String> state) {
  //       return Container(
  //         padding: const EdgeInsets.symmetric(vertical: 20),
  //         child: ElevatedButton.icon(
  //           style: ElevatedButton.styleFrom(
  //             padding: const EdgeInsets.all(20),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //           ),
  //           onPressed: () async {
  //             final ImagePicker picker = ImagePicker();
  //             XFile? image =
  //                 await picker.pickImage(source: ImageSource.gallery);
  //             setState(() {
  //               imageFile = image!;
  //               imageAvalible = true;
  //             });
  //             // final image64 = File(imageFile.path).readAsBytesSync();
  //             // imageData = base64Encode(image64);
  //           },
  //           icon: const Icon(Icons.image),
  //           label: const Text("upload gambar"),
  //         ),
  //       );
  //     },
  //     validator: (value) {
  //       if (value == null && imageAvalible == false) {
  //         showDialog(
  //           context: context,
  //           builder: (context) => const WarningDialog(
  //               description: "Gambar produk wajib diupload"),
  //         );
  //       }
  //       return null;
  //     },
  //   );
  // }
  // Widget _image() {
  //   return Container(
  //     alignment: Alignment.topLeft,
  //     child: Container(
  //       width: 200,
  //       height: 200,
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         border:
  //             Border.all(color: const Color.fromARGB(98, 0, 0, 0), width: 1),
  //       ),
  //       child:
  //           imageAvalible ? Image.memory(imageFile) : const Icon(Icons.image),
  //     ),
  //   );
  // }

  Widget _jenisKelaminTextField() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          labelText: 'jenis Kelamin',
          labelStyle: TextStyle(color: Colors.white),
          // underline

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        obscureText: false,
        controller: _jeniKelaminTextFieldController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'email harus diisi';
          }
          return null;
        },
      ),
    );
  }

  Widget _alamatTextField() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          labelText: 'Alamat',
          labelStyle: TextStyle(color: Colors.white),
          // underline

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        obscureText: false,
        controller: _alamatTextFieldController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'email harus diisi';
          }
          return null;
        },
      ),
    );
  }

  Widget _namaTextField() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          labelText: 'Nama',
          labelStyle: TextStyle(color: Colors.white),
          // underline

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        obscureText: false,
        controller: _namaTextFieldController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'email harus diisi';
          }
          return null;
        },
      ),
    );
  }

  Widget _emailTextField() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.white),
          // underline

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        obscureText: false,
        controller: _emailTextboxController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'email harus diisi';
          }
          return null;
        },
      ),
    );
  }

  Widget _passwordTextField() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Colors.white),
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        obscureText: true,
        controller: _passwordTextboxController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Password harus diisi';
          }
          return null;
        },
      ),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    registerService
        .register(
            alamat: _alamatTextFieldController.text,
            nama: _namaTextFieldController.text,
            foto: base64string,
            jenisKelamin: _jeniKelaminTextFieldController.text,
            email: _emailTextboxController.text,
            // role: _role.text,
            password: _passwordTextboxController.text.toString())
        .then(
      (value) async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
            description: "Register berhasil, silahkan login",
            okClick: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage()));
            },
          ),
        );
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
    setState(() {
      _isLoading = false;
    });
  }

  // Widget menuRegistrasi() {
  //   return Center(
  //     child: InkWell(
  //       child: const Text(
  //         "Registrasi?",
  //         style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
  //       ),
  //       onTap: () {
  //         // Navigator.push(context,
  //         //     MaterialPageRoute(builder: (context) => const RegistrasiPage()));
  //       },
  //     ),
  //   );
  // }

  Widget _registerButton() {
    return StreamBuilder<bool>(
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shadowColor: Colors.black,
            minimumSize: const Size.fromHeight(50),
          ),
          child: const Text(
            'Register',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _submit();
            }
          },
        );
      },
    );
  }

  // create widget spacebeetwen
}
