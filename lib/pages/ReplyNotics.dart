import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:appecommerce/pages/Search.dart';

class ReplyNotics extends StatefulWidget {
  @override
  _ReplyNoticsState createState() => _ReplyNoticsState();
}

class _ReplyNoticsState extends State<ReplyNotics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Khuyen Mai",
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
                                title: Text(
                                    "Khuyến mãi"),
                                leading: Icon(Icons.notifications, size: 40),
                                subtitle: Text("AAAAAAAAAAAAA"),
                              ),
                              onTap: () {
                              }
                          ),
                          Divider(),
                          //replyNotification(),
                        ])),
                  ],
                );
              },
              itemCount: 5,
            ))
    );
  }
}
