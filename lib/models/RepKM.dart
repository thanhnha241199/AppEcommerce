import 'package:flutter/material.dart';

class RepKhuyenMai {
  //this is called "model"
  final int repid;
  final String reptitle;
  final String repsubtitle;
  final IconData repicon;

  RepKhuyenMai({this.repid,@required this.reptitle, @required this.repsubtitle, this.repicon});

}