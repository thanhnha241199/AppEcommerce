import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appecommerce/pages/Search.dart';
import 'package:appecommerce/pages/ReplyNotics.dart';
import 'package:appecommerce/models/Khuyenmai.dart';
import 'package:appecommerce/models/RepKM.dart';
List<KhuyenMai> KM = [
  KhuyenMai(
      idkm: 1,
      titlekm: "Khuyen Mai",
      subtitlekm: "Tang dien thoai iphone 11 pro max",
      iconkm: Icons.notifications
  ),
  KhuyenMai(
      idkm: 2,
      titlekm: "Khuyen Mai1",
      subtitlekm: "Tang 1 dien thoai iphone 11 pro max",
      iconkm: Icons.notifications
  ),
  KhuyenMai(
      idkm: 3,
      titlekm: "Khuyen Mai2",
      subtitlekm: "Tang 2 dien thoai iphone 11 pro max",
      iconkm: Icons.notifications
  ),
  KhuyenMai(
      idkm: 4,
      titlekm: "Khuyen Mai3",
      subtitlekm: "Tang 3 dien thoai iphone 11 pro max",
      iconkm: Icons.notifications
  ),
];
List<RepKhuyenMai> RepKM = [
  //array of food's objects
  RepKhuyenMai(
      repid: 1,
      reptitle: "Khuyen Mai",
      repsubtitle: "Tang dien thoai iphone 11 pro max",
      repicon: Icons.notifications
  ),
  RepKhuyenMai(
      repid: 2,
      reptitle: "Khuyen Mai1",
      repsubtitle: "Tang1 dien thoai iphone 11 pro max",
      repicon: Icons.notifications
  ),
  RepKhuyenMai(
      repid: 3,
      reptitle: "Khuyen Mai2",
      repsubtitle: "Tang2 dien thoai iphone 11 pro max",
      repicon: Icons.notifications
  ),
  RepKhuyenMai(
      repid: 4,
      reptitle: "Khuyen Mai3",
      repsubtitle: "Tang3 dien thoai iphone 11 pro max",
      repicon: Icons.notifications
  ),

];
class Noctics extends StatelessWidget {
  KhuyenMai khuyenMai;
  Noctics({this.khuyenMai});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Notifications",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0,
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Search()));
              },
              icon: Icon(EvaIcons.shoppingBagOutline),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Search()));
              },
              icon: Icon(EvaIcons.search),
            ),
          ],
        ),
        body: Scrollbar(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                        child: Stack(children: <Widget>[
                          GestureDetector(
                              child: ListTile(
                                contentPadding: EdgeInsets.all(8),
                                title: Text(KM[index].titlekm),
                                leading: Icon(
                                    KM[index].iconkm,
                                    size: 40),
                                subtitle: Text(KM[index].subtitlekm),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ReplyNotics()));
                              }
                          ),
                          Divider(),
                          //replyNotification(),
                        ])),
                  ],
                );
              },
              itemCount: KM.length,
            ))
    );
  }
}
