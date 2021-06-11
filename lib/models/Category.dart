import 'package:flutter/material.dart';

class Category {
  //this is called "model"
  final int id;
  final String content;
  final String img;

  const Category({@required this.id, @required this.content, this.img});
}
