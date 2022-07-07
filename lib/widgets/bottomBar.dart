

// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:AKHIS/ui/crudObat/ReadDeleteObatPage.dart';
import 'package:AKHIS/ui/rudUser/ReadDeleteUserPage.dart';
import 'package:AKHIS/ui/ProfileMemberPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget BottomBarAdmin(index, BuildContext context) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: index,
    onTap: (i) {
      switch (i) {
        case 0:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const ReadDeleteObatPage(),
            ),
            (route) => false,
          );
          break;
        case 1:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const ProfileMemberPage(),
            ),
            (route) => false,
          );
          break;
        case 2:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const ReadDeleteUserPage(),
            ),
            (route) => false,
          );
          break;
        default:
      }
    },
    items: const [
      BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.pills), label: 'obat'),
      BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.user), label: 'profile'),
      BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle), label: 'user')
    ],
  );
}

Widget BottomBarUser(index, BuildContext context) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: index,
    onTap: (i) async {
      switch (i) {
        case 0:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const ReadDeleteObatPage(),
            ),
            (route) => false,
          );
          break;
        case 1:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const ProfileMemberPage(),
            ),
            (route) => false,
          );
          break;
        default:
      }
    },
    items: const [
      BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.pills), label: 'obat'),
      BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.user), label: 'profile'),
    ],
  );
}
