import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreCategories extends StatefulWidget {
  @override
  _MoreCategoriesState createState() => _MoreCategoriesState();
}

class _MoreCategoriesState extends State<MoreCategories> {
  int _selectedIndex = 0;
  var list = [
    _Categories1(),
    _Categories2(),
    _Categories3(),
    _Categories4(),
    _Categories5(),
    _Categories6(),
    _Categories7(),
    _Categories8(),
    _Categories9(),
    _Categories10(),
    _Categories11(),
    _Categories12(),
    _Categories13(),
    _Categories14(),
    _Categories15(),
    _Categories16(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tất cả danh mục",
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
      ),
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      //backgroundColor: Colors.grey,
                      selectedLabelTextStyle: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                      unselectedLabelTextStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.normal),
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      destinations: [
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories2_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories2_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Thời Trang \nNam',textAlign: TextAlign.center
                            ),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories3_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories3_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Thời Trang \nNữ',textAlign: TextAlign.center
                            ),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories4_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories4_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text('Điện thoại \n& Phụ Kiện',textAlign: TextAlign.center),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories5_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories5_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text('Mẹ & Bé',textAlign: TextAlign.center),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories6_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories6_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Thiết Bị\nĐiện Tử',textAlign: TextAlign.center),
                            ),
                          ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories7_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories7_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text('Nhà Cửa \n& Đời Sống',textAlign: TextAlign.center),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories8_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories8_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text('Máy tính \n& Laptop',textAlign: TextAlign.center),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories9_none.png",
                            height: 40,
                            width: 40,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories9_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Sức Khỏe \n& Sắc Đẹp,',textAlign: TextAlign.center
                            ),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories10_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories10_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Máy ảnh & \nMáy quay phim',textAlign: TextAlign.center
                            ),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories11_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories11_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Giày Dép\nNữ",textAlign: TextAlign.center),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories12_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories12_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Đồng Hồ",textAlign: TextAlign.center),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories13_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories13_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Túi Ví",textAlign: TextAlign.center),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories14_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories14_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Giày Dép\nNam",textAlign: TextAlign.center),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories15_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories15_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Phụ Kiện\nThời Trang",textAlign: TextAlign.center),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories16_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories16_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Thiết Bị Điện\nGia Dụng",textAlign: TextAlign.center),
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            "assets/categories/categories17_none.png",
                            height: 30,
                            width: 30,
                          ),
                          selectedIcon: Image.asset(
                            "assets/categories/categories17_select.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Thể Thao &\nDu Lịch",textAlign: TextAlign.center)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
              child: Stack(
                  children: [
                    list[_selectedIndex],
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
Widget _widget(String img, String text){
  return Stack(
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(img,
          height: 50,
          width: 50,),
          Text(text)
        ],
      ),
    ],
  );
}
Widget _Categories1(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories1/categories1_1.png","Áo thun"),
      _widget("assets/categories/categories1/categories1_2.png","Áo sơ mi"),
      _widget("assets/categories/categories1/categories1_3.png","Áo Vest"),
      _widget("assets/categories/categories1/categories1_4.png","Áo len"),
      _widget("assets/categories/categories1/categories1_5.png","Đồ bộ"),
      _widget("assets/categories/categories1/categories1_6.png","Đồ đôi"),
      _widget("assets/categories/categories1/categories1_7.png","Quần"),
      _widget("assets/categories/categories1/categories1_8.png","Ví"),
      _widget("assets/categories/categories1/categories1_9.png","Mắt kính"),
      _widget("assets/categories/categories1/categories1_10.png","Phụ kiện"),
      _widget("assets/categories/categories1/categories1_11.png","Trang sức"),
      _widget("assets/categories/categories1/categories1_12.png","Thắt lưng"),
      _widget("assets/categories/categories1/categories1_13.png","Đồ lót"),
    ],
  );
}
Widget _Categories2(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories2/categories2_1.png","Áo"),
      _widget("assets/categories/categories2/categories2_2.png","Đầm"),
      _widget("assets/categories/categories2/categories2_3.png","Chân váy"),
      _widget("assets/categories/categories2/categories2_4.png","Quần"),
      _widget("assets/categories/categories2/categories2_5.png","Jumpsuit"),
      _widget("assets/categories/categories2/categories2_6.png","Đồ ngủ"),
      _widget("assets/categories/categories2/categories2_7.png","Đồ bơi"),
      _widget("assets/categories/categories2/categories2_8.png","Thể thao"),
      _widget("assets/categories/categories2/categories2_9.png","Áo Vest"),
      _widget("assets/categories/categories2/categories2_10.png","Đồ đông"),
      _widget("assets/categories/categories2/categories2_11.png","Đồ bầu"),
      _widget("assets/categories/categories2/categories2_12.png","Đồ đôi"),
      _widget("assets/categories/categories2/categories2_13.png","Phụ kiện"),
    ],
  );
}
Widget _Categories3(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories3/categories3_1.jpg","Điện thoại"),
      _widget("assets/categories/categories3/categories3_2.jpg","Tablet"),
      _widget("assets/categories/categories3/categories3_3.png","Ốp lưng"),
      _widget("assets/categories/categories3/categories3_4.png","Miếng dán"),
      _widget("assets/categories/categories3/categories3_5.png","Pin DP"),
      _widget("assets/categories/categories3/categories3_6.png","Bộ sạc"),
      _widget("assets/categories/categories3/categories3_7.png","Giá đỡ"),
      _widget("assets/categories/categories3/categories3_8.png","Gậy chụp"),
      _widget("assets/categories/categories3/categories3_9.png","Sim"),
    ],
  );
}
Widget _Categories4(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories4/categories4_1.png","Đồ dùng "),
      _widget("assets/categories/categories4/categories4_2.png","Tả & Bỉm"),
      _widget("assets/categories/categories4/categories4_3.png","Xe đẩy"),
      _widget("assets/categories/categories4/categories4_4.png","Vitamin"),
      _widget("assets/categories/categories4/categories4_5.png","Sữa"),
      _widget("assets/categories/categories4/categories4_6.png","Thực phẩm"),
      _widget("assets/categories/categories4/categories4_7.png","Thuốc"),
      _widget("assets/categories/categories4/categories4_8.png","Dụng cụ"),
    ],
  );
}
Widget _Categories5(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories5/categories5_1.png","Âm thanh"),
      _widget("assets/categories/categories5/categories5_2.png","Tai nghe"),
      _widget("assets/categories/categories5/categories5_3.png","VR"),
      _widget("assets/categories/categories5/categories5_4.png","TV Box"),
      _widget("assets/categories/categories5/categories5_5.png","Tivi"),
      _widget("assets/categories/categories5/categories5_6.png","Phụ kiện"),
      _widget("assets/categories/categories5/categories5_7.png","Tai nghe"),
      _widget("assets/categories/categories5/categories5_8.png","Game")
    ],
  );
}
Widget _Categories6(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories6/categories6_1.png","Tiện ích"),
      _widget("assets/categories/categories6/categories6_2.png","Bếp"),
      _widget("assets/categories/categories6/categories6_3.png","Chăn, Nệm"),
      _widget("assets/categories/categories6/categories6_4.png","Vitamin"),
      _widget("assets/categories/categories6/categories6_5.png","Tủ đựng"),
      _widget("assets/categories/categories6/categories6_6.png","Phòng tắm"),
      _widget("assets/categories/categories6/categories6_7.png","Nội thất"),
      _widget("assets/categories/categories6/categories6_8.png","Đèn"),
      _widget("assets/categories/categories6/categories6_9.png","Dụng cụ"),
      _widget("assets/categories/categories6/categories6_10.png","Sân vườn"),
    ],
  );
}
Widget _Categories7(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories7/categories7_1.png","Laptop"),
      _widget("assets/categories/categories7/categories7_2.png","Desktop"),
      _widget("assets/categories/categories7/categories7_3.png","Linh kiện"),
      _widget("assets/categories/categories7/categories7_4.png","Chuột"),
      _widget("assets/categories/categories7/categories7_5.png","TB Mạng"),
      _widget("assets/categories/categories7/categories7_6.png","Lưu trữ"),
      _widget("assets/categories/categories7/categories7_7.png","Máy in"),
      _widget("assets/categories/categories7/categories7_8.png","Phần mềm"),
      _widget("assets/categories/categories7/categories7_9.png","Vệ sinh"),
      _widget("assets/categories/categories7/categories7_10.png","Audio"),
    ],
  );
}
Widget _Categories8(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories8/categories8_1.png","Da"),
      _widget("assets/categories/categories8/categories8_2.png","Son"),
      _widget("assets/categories/categories8/categories8_3.png","Trang điểm"),
      _widget("assets/categories/categories8/categories8_4.png","Mắt"),
      _widget("assets/categories/categories8/categories8_5.png","Nam"),
      _widget("assets/categories/categories8/categories8_6.png","Cơ thể"),
      _widget("assets/categories/categories8/categories8_7.png","Tóc"),
      _widget("assets/categories/categories8/categories8_8.png","Rắng"),
      _widget("assets/categories/categories8/categories8_9.png","Massage"),
      _widget("assets/categories/categories8/categories8_10.png","Dụng cụ"),
      _widget("assets/categories/categories8/categories8_11.png","Nước hoa"),
    ],
  );
}
Widget _Categories9(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories9/categories9_1.png","Máy ảnh"),
      _widget("assets/categories/categories9/categories9_2.png","Thẻ nhớ"),
      _widget("assets/categories/categories9/categories9_3.png","Camera"),
      _widget("assets/categories/categories9/categories9_4.png","DSLR"),
      _widget("assets/categories/categories9/categories9_5.png","Máy ảnh"),
      _widget("assets/categories/categories9/categories9_6.png","Máy quay"),
      _widget("assets/categories/categories9/categories9_7.png","Phụ kiện"),
    ],
  );
}
Widget _Categories10(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories10/categories10_1.png","Cao gót"),
      _widget("assets/categories/categories10/categories10_2.png","Đế bằng"),
      _widget("assets/categories/categories10/categories10_3.png","Sandal"),
      _widget("assets/categories/categories10/categories10_4.png","Đế xuồng"),
      _widget("assets/categories/categories10/categories10_5.png","Bốt"),
      _widget("assets/categories/categories10/categories10_6.png","Guốc"),
      _widget("assets/categories/categories10/categories10_7.png","Sneaker"),
      _widget("assets/categories/categories10/categories10_8.png","Phụ kiện"),
    ],
  );
}
Widget _Categories11(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories11/categories11_1.png","Nam"),
      _widget("assets/categories/categories11/categories11_2.png","Nữ"),
      _widget("assets/categories/categories11/categories11_3.png","Trẻ em"),
      _widget("assets/categories/categories11/categories11_4.png","Phụ kiện"),
    ],
  );
}
Widget _Categories12(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories12/categories12_1.png","Túi Nữ"),
      _widget("assets/categories/categories12/categories12_2.png","Túi Nữ"),
      _widget("assets/categories/categories12/categories12_3.png","Balo"),
      _widget("assets/categories/categories12/categories12_4.png","Ví Nữ"),
      _widget("assets/categories/categories12/categories12_5.png","Cặp"),
      _widget("assets/categories/categories12/categories12_6.png","Túi tiện ích"),
      _widget("assets/categories/categories12/categories12_7.png","Túi vải"),
      _widget("assets/categories/categories12/categories12_8.png","Phụ kiện"),
    ],
  );
}
Widget _Categories13(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories13/categories13_1.png","Thể thao"),
      _widget("assets/categories/categories13/categories13_2.png","Giày lười"),
      _widget("assets/categories/categories13/categories13_3.png","Giày tây"),
      _widget("assets/categories/categories13/categories13_4.png","Sandal"),
      _widget("assets/categories/categories13/categories13_5.png","Dép"),
      _widget("assets/categories/categories13/categories13_6.png","Giày"),
      _widget("assets/categories/categories13/categories13_7.png","Phụ kiện"),
    ],
  );
}
Widget _Categories14(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories14/categories14_1.png","Trang sức"),
      _widget("assets/categories/categories14/categories14_2.png","Mắt kính"),
      _widget("assets/categories/categories14/categories14_3.png","Nón"),
      _widget("assets/categories/categories14/categories14_4.png","Khăn"),
      _widget("assets/categories/categories14/categories14_5.png","Kẹp Tóc"),
      _widget("assets/categories/categories14/categories14_6.png","Dây lưng"),
      _widget("assets/categories/categories14/categories14_7.png","Hình xăm"),
      _widget("assets/categories/categories14/categories14_8.png","Wedding"),
      _widget("assets/categories/categories14/categories14_9.png","Khẩu trang"),
    ],
  );
}
Widget _Categories15(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories15/categories15_1.png","Nhà bếp"),
      _widget("assets/categories/categories15/categories15_2.png","Quạt"),
      _widget("assets/categories/categories15/categories15_3.png","Bàn là"),
      _widget("assets/categories/categories15/categories15_4.png","Hút bụi"),
      _widget("assets/categories/categories15/categories15_5.png","Gia dụng"),
      _widget("assets/categories/categories15/categories15_6.png","Khác"),
    ],
  );
}
Widget _Categories16(){
  return GridView.count(
    physics: BouncingScrollPhysics(),
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    padding: EdgeInsets.all(10.0),
    mainAxisSpacing: 10.0,
    childAspectRatio: 1 / 1,
    children: <Widget>[
      _widget("assets/categories/categories16/categories16_1.png","Áo"),
      _widget("assets/categories/categories16/categories16_2.png","Giày"),
      _widget("assets/categories/categories16/categories16_3.png","Phụ kiện"),
      _widget("assets/categories/categories16/categories16_4.png","Găng tay"),
      _widget("assets/categories/categories16/categories16_5.png","Kính"),
      _widget("assets/categories/categories16/categories16_6.png","Balo"),
      _widget("assets/categories/categories16/categories16_7.png","Khác"),
    ],
  );
}