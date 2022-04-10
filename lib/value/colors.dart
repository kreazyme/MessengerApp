import 'package:flutter/cupertino.dart';

class AppColors {
  static const Color mainColor = Color(0xffFA53FD);
  static const Color primaryColor = Color(0xffF5AAFA);
}

class ContactColors {
  static List<Color> lscolor = <Color>[
    Color(0xff34691A),
    Color(0xffEF6C00),
    Color(0xff8E6D63),
    Color(0xff01589B),
    Color(0xff0389D0),
    Color(0xff0389D0),
    Color(0xffEE4279)
  ];
  Color RandomColor() {
    return (lscolor..shuffle()).first;
  }
}
