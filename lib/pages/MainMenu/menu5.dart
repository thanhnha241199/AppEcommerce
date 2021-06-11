import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:appecommerce/pages/Search.dart';

class Menu5 extends StatefulWidget {
  @override
  _Menu5State createState() => _Menu5State();
}

class _Menu5State extends State<Menu5> {
  static String routeName = "/Menu5";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "NowFood - Bữa ăn ngon 0đ",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new Search()));
            },
            icon: Icon(EvaIcons.search),
          ),
        ],
      ),
    );
  }
}

