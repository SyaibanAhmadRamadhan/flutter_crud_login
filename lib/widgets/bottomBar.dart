// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_crud/ui/adminPage.dart';
import 'package:flutter_application_crud/ui/crudObat/readObatPage.dart';
import 'package:flutter_application_crud/ui/obatPage.dart';
import 'package:flutter_application_crud/ui/rudUser/readUserPage.dart';
import 'package:flutter_application_crud/ui/userPage.dart';

Widget bottomBar(index, BuildContext context) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: index,
    onTap: (i) {
      switch (i) {
        case 0:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const readObatPage(),
            ),
            (route) => false,
          );
          break;
        case 1:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const adminPage(),
            ),
            (route) => false,
          );
          break;
        case 2:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const readUserPage(),
            ),
            (route) => false,
          );
          break;
        default:
      }
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'obat'),
      BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle), label: 'profile'),
      BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle), label: 'user')
    ],
  );
}

Widget bottomBarUser(index, BuildContext context) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: index,
    onTap: (i) async {
      switch (i) {
        case 0:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const obatPage(),
            ),
            (route) => false,
          );
          break;
        case 1:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const userPage(),
            ),
            (route) => false,
          );
          break;
        default:
      }
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'obat'),
      BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle), label: 'profile'),
    ],
  );
}
