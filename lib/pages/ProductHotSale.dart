import 'dart:math';

import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';


class PageHotSale extends StatefulWidget {
  @override
  _PageHotSaleState createState() => _PageHotSaleState();
}

class _PageHotSaleState extends State<PageHotSale> {
  List<String> items = [];
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.blue,
    Colors.amber,
    Colors.cyan,
    Colors.pink
  ];
  Random random = new Random();

  Color getRandomColor() {
    return colors.elementAt(random.nextInt(colors.length));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Init the items
    for (var i = 0; i < 100; i++) {
      items.add('Item $i');
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _buildFlashSaleImage(),
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
            onPressed: () {},
            icon: Icon(EvaIcons.shareOutline),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Image.asset("assets/images/banners/bannerflashsale.png"),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                      ),
                      title: Text(items.elementAt(index)),
                    ),
                  );
                },

                //physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Image _buildFlashSaleImage() {
    return Image.asset(
      "assets/images/banners/ic_flash_sale.png",
      width: 100,
      fit: BoxFit.scaleDown,
    );
  }

  CountdownFormatted _buildCountDown() => CountdownFormatted(
        duration: Duration(hours: 2),
        builder: (BuildContext context, String remaining) {
          final showTime = (String text) => Container(
                width: 30,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                ),
              );
          List<String> time = remaining.split(':').toList();
          return Row(
            children: [
              showTime(time[0]),
              showTime(time[1]),
              showTime(time[2]),
            ],
          ); // 01:00:00
        },
      );
}
