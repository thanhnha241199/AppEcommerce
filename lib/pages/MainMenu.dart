import 'package:flutter/material.dart';
import 'package:appecommerce/models/MainMenu.dart';
import 'package:appecommerce/pages/HomePage.dart';

const FAKE_CATEGORIES = const [
  MainMenu1(
      id: 1,
      content: 'Deal Gần Bạn - Chỉ 1K',
      image: "assets/mainmenu/icon1.png",
      press: "/Menu1"
  ),
  MainMenu1(
      id: 2,
      content: 'NowFood - Bữa ăn ngon 0đ',
      image: "assets/mainmenu/icon2.png",
      press: "/Menu2"),
  MainMenu1(
      id: 3,
      content: 'Freeship Extra',
      image: "assets/mainmenu/icon3.png",
      press: "/Menu3"),
  MainMenu1(
      id: 4, content: 'Hàng quốc tế',
      image: "assets/mainmenu/icon4.png",
      press: "/Menu4"),
  MainMenu1(
      id: 5,
      content: 'Hoàn xu đơn bất kì',
      image: "assets/mainmenu/icon5.png",
      press: "/Menu5"),
  MainMenu1(
      id: 6,
      content: '14.10 Chính Thức Ra Mắt',
      image: "assets/mainmenu/icon6.png",
      press: "/Menu6"),
  MainMenu1(
      id: 7,
      content: 'Humburgers',
      image: "assets/mainmenu/icon7.png",
      press: "/Menu7"),
  MainMenu1(
      id: 8, content: 'Italian',
      image: "assets/mainmenu/icon8.png",
      press: "/Menu8"),
  MainMenu1(
      id: 9,
      content: 'Foods Food',
      image: "assets/mainmenu/icon9.png",
      press: "/Menu9"),
  MainMenu1(
      id: 10,
      content: 'Pizza Pizza',
      image: "assets/mainmenu/icon10.png",
      press: "/Menu10"),
  MainMenu1(
      id: 11,
      content: 'Humburgers',
      image: "assets/mainmenu/icon11.png",
      press: "/Menu11"),
  MainMenu1(
      id: 12, content: 'Italian',
      image: "assets/mainmenu/icon12.png",
      press: "/Menu12"),
];

class MainMenu extends StatefulWidget {
  static const String routeName = '/MainMenu';
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(8),
        children: FAKE_CATEGORIES
            .map((eachCategory) => CategoryItem(mainMenu1: eachCategory))
            .toList(),
      ),
    );
  }
}


class CategoryItem extends StatelessWidget {
  MainMenu1 mainMenu1;
  CategoryItem({this.mainMenu1});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, this.mainMenu1.press);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    this.mainMenu1.image,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              this.mainMenu1.content,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

