import 'dart:math';

import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class FlashSale extends StatefulWidget {
  FlashSale({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _FlashSaleState createState() => _FlashSaleState();
}


class _FlashSaleState extends State<FlashSale> with SingleTickerProviderStateMixin/*<-- This is for the controllers*/ {
  TabController _tabController; // To control switching tabs
  ScrollController _scrollViewController; // To control scrolling

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
    _tabController = TabController(vsync: this, length: 6);
    _scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Init the items
    for (var i = 0; i < 100; i++) {
      items.add('Item $i');
    }

    return SafeArea(
      child: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: true,
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
              bottom: TabBar(
                physics: BouncingScrollPhysics(),
                isScrollable: true,
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                indicatorColor: Colors.red,
                tabs: <Widget>[
                  Tab(
                    child: Column(
                      children: [
                        Text(
                          '09:00',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Đang diễn ra',
                          style: TextStyle(color: Colors.black26, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        Text(
                          '12:00',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Sắp diễn ra',
                          style: TextStyle(color: Colors.black26, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        Text(
                          '12:30',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Sắp diễn ra',
                          style: TextStyle(color: Colors.black26, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        Text(
                          '13:00',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Sắp diễn ra',
                          style: TextStyle(color: Colors.black26, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        Text(
                          '15:00',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Sắp diễn ra',
                          style: TextStyle(color: Colors.black26, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        Text(
                          '17:00',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Sắp diễn ra',
                          style: TextStyle(color: Colors.black26, fontSize: 14),
                        ),
                      ],
                    ),
                  )
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            controller: _tabController,
            children: <Widget>[
              Scrollbar(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Image.asset(
                                "assets/images/banners/bannerflashsale.png"),
                            Container(
                              height: 30,
                              color: Color(0xFFf5f6f7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'KẾT THÚC TRONG',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        decoration: TextDecoration.none),
                                  ),
                                  _buildCountDown(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
              ),
              Scrollbar(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Image.asset(
                                "assets/images/banners/bannerflashsale.png"),
                            Container(
                              height: 30,
                              color: Color(0xFFf5f6f7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'KẾT THÚC TRONG',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        decoration: TextDecoration.none),
                                  ),
                                  _buildCountDown(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
              ),
              Scrollbar(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Image.asset(
                                "assets/images/banners/bannerflashsale.png"),
                            Container(
                              height: 30,
                              color: Color(0xFFf5f6f7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'KẾT THÚC TRONG',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        decoration: TextDecoration.none),
                                  ),
                                  _buildCountDown(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
              ),
              Scrollbar(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Image.asset(
                                "assets/images/banners/bannerflashsale.png"),
                            Container(
                              height: 30,
                              color: Color(0xFFf5f6f7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'KẾT THÚC TRONG',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        decoration: TextDecoration.none),
                                  ),
                                  _buildCountDown(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
              ),
              Scrollbar(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Image.asset(
                                "assets/images/banners/bannerflashsale.png"),
                            Container(
                              height: 30,
                              color: Color(0xFFf5f6f7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'KẾT THÚC TRONG',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        decoration: TextDecoration.none),
                                  ),
                                  _buildCountDown(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
              ),
              Scrollbar(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Image.asset(
                                "assets/images/banners/bannerflashsale.png"),
                            Container(
                              height: 30,
                              color: Color(0xFFf5f6f7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'KẾT THÚC TRONG',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        decoration: TextDecoration.none),
                                  ),
                                  _buildCountDown(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
              ),
            ],
          ),
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
