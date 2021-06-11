import 'package:appecommerce/admin/adminpage.dart';
import 'package:appecommerce/models/Product.dart';
import 'package:appecommerce/pages/Categories.dart';
import 'package:appecommerce/pages/Flashsale.dart';
import 'package:appecommerce/pages/MainMenu.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/pages/ProductHotSale.dart';
import 'package:appecommerce/pages/Search.dart';
import 'package:appecommerce/pages/morecategories.dart';
import 'package:appecommerce/pages/small_banner.dart';
import 'package:appecommerce/signin/cart_page.dart';
import 'package:appecommerce/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  String cartid;
  HomePage({this.cartid});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  int notic =0;
  @override
  void initState() {
    super.initState();
    //getData();
  }
  List bannerAdSlider = [
    "assets/images/banners/banner1.png",
    "assets/images/banners/banner2.jpg",
    "assets/images/banners/banner3.jpg",
    "assets/images/banners/banner4.jpg",
    "assets/images/banners/banner5.jpg",
    "assets/images/banners/banner6.jpg",
    "assets/images/banners/banner7.jpg",
    "assets/images/banners/banner8.jpg",
  ];


  Stack _buildIconButton({
    VoidCallback onPressed,
    IconData icon,
    int notification = 0,
  }){
    return Stack(
      children: <Widget>[
        IconButton(
          iconSize: 30,
          onPressed: onPressed,
          icon: Icon(icon),
          color: Colors.black,
        ),
        notification == 0
            ? SizedBox()
            : Positioned(
          right: 0,
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white),
            ),
            constraints: BoxConstraints(
              minWidth: 20,
              minHeight: 20,
            ),
            child: Text(
              '$notification',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }




  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  Future<dynamic> getData() async {

    final DocumentReference document =   FirebaseFirestore.instance.collection("Users").doc(_firebaseServices.getUserId()).collection("Cart").doc("XS4obmGsU6VUbofi1tfo");

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        notic = notic + snapshot.data()['quantity'];
        print(snapshot.data()['quantity']);
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: _buildSearch(),
        backgroundColor: Colors.red,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildIconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPage()));
                      },
                      icon: EvaIcons.shoppingBagOutline,
                      notification: notic,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPage()));
                      },
                      icon: Icon(EvaIcons.messageCircleOutline),
                      iconSize: 28,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                _buildBanner(),
                MainMenu(),
                SmallBanner(),
                _buildSaleHot(),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                  child: Container(
                    color: Color(0xFFf5f6f7),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _buildFlashSaleImage(),
                        _buildCountDown()
                      ],
                    ),
                    _buildMoreButton(),
                  ],
                ),
                _buildFlashSale(),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                  child: Container(
                    color: Color(0xFFf5f6f7),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(22.0),
                          fontWeight: FontWeight.bold),
                    ),
                    _buildMoreCategories(),
                  ],
                ),
                CategoriesPage(),
                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                  child: Container(
                    color: Color(0xFFf5f6f7),
                  ),
                ),
                _buildProduct(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearch() {
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Search()));
      },
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(4),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(4.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(4.0),
            ),
          ),
          isDense: true,
          hintText: "Shopee",
          hintStyle: TextStyle(
            fontSize: getProportionateScreenWidth(18.0),
            color: Colors.deepOrange,
          ),
          prefixIcon: Icon(
            EvaIcons.searchOutline,
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: getProportionateScreenWidth(40.0),
            minHeight: getProportionateScreenWidth(40.0),
          ),
          suffixIcon: Icon(
            EvaIcons.cameraOutline,
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
  Widget _buildSaleHot() {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, left: 20.0),
                              child: Text(
                                "SẢN PHẨM BÁN CHẠY",
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(18.0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        _buildMoreButtonadd(),
                      ],
                    ),
                  ),
                  Container(
                      height: getProportionateScreenHeight(220.0),
                      child: Stack(
                        children: [
                          FutureBuilder<QuerySnapshot>(
                            future: _firebaseServices.productsRef.get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Scaffold(
                                  body: Center(
                                    child: Text("Error: ${snapshot.error}"),
                                  ),
                                );
                              }
                              // Collection Data ready to display
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                // Display the data inside a list view
                                return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.size,
                                  itemBuilder: (context, index) {
                                    print("${snapshot.data.size}");
                                    return Container(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        height: MediaQuery.of(context).size.width / 6,
                                        width: MediaQuery.of(context).size.width / 3,
                                        margin: EdgeInsets.all(8),
                                        child: Column(
                                          children: <Widget>[
                                            Card(
                                              child: AspectRatio(
                                                aspectRatio: 3 / 2.5,
                                                child: Image(
                                                  height:
                                                  getProportionateScreenHeight(20.0),
                                                  image: NetworkImage(snapshot.data.docs[index]['images'][0]),
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data.docs[index]['name'],
                                            ),
                                            Text(
                                              snapshot.data.docs[index]['price'].toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.amber,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return Text("");
                            },
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 5 / 2.8,
        autoPlay: true,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: bannerAdSlider.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(6.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: AssetImage(i),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildProduct() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Products",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(22.0),
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: Stack(
            children: [
              FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.productsRef
                        .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  }
                  // Collection Data ready to display
                  if (snapshot.connectionState == ConnectionState.done) {
                    // Display the data inside a list view
                    return GridView.count(
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      childAspectRatio: 1 / 1.25,
                      children: snapshot.data.docs.map((document) {
                        return Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: FadeInImage(
                                        height: 125,
                                        width: 125,
                                        fit: BoxFit.scaleDown,
                                        image: NetworkImage(
                                          document.data()['images'][0],
                                        ),
                                        placeholder: AssetImage(
                                          'assets/shared/loading.gif',
                                        ),
                                      ),
                                    ),
                                    Text(
                                      document.data()['name'],
                                    ),
                                    Text(
                                      "\$${document.data()['price']}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductPage(productId: document.id),
                                      ));
                                },
                              ),
                            )
                          ],
                        );
                      }).toList(),
                    );
                  }
                  // Loading State
                  return Text("");
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFlashSale() {
    return Wrap(
      children: [
        Container(
          child: Column(
            children: [
              Stack(
                children: [
                  FutureBuilder<QuerySnapshot>(
                    future: _firebaseServices.productsRef.where("flashsale", isEqualTo: "true")
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Scaffold(
                          body: Center(
                            child: Text("Error: ${snapshot.error}"),
                          ),
                        );
                      }
                      // Collection Data ready to display
                      if (snapshot.connectionState == ConnectionState.done) {
                        // Display the data inside a list view
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                Container(
                                  height: getProportionateScreenHeight(35.0),
                                  child: _buildFlashSale(),
                                ),
                                Container(
                                  height: getProportionateScreenHeight(300.0),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data.size,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductPage(productId: snapshot.data.docs[index].id),
                                                  ));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              height:
                                              MediaQuery.of(context).size.width / 3,
                                              width: MediaQuery.of(context).size.width /
                                                  2.2,
                                              margin: EdgeInsets.all(10),
                                              child: Column(
                                                children: <Widget>[
                                                  Card(
                                                    child: AspectRatio(
                                                      aspectRatio: 1 / 1,
                                                      child: Image(
                                                        image: NetworkImage(snapshot.data.docs[index]['images'][0]),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data.docs[index]['name'],
                                                  ),
                                                  Text(
                                                    snapshot.data.docs[index]['price'].toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                      getProportionateScreenHeight(
                                                          18.0),
                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.amber,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      // Loading State
                      return Text("");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  CountdownFormatted _buildCountDown() => CountdownFormatted(
        duration: Duration(hours: 2),
        builder: (BuildContext context, String remaining) {
          final showTime = (String text) => Container(
                width: getProportionateScreenWidth(30.0),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15.0),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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

  FlatButton _buildMoreCategories() => FlatButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MoreCategories()));
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Text(
          "Xem tất cả",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      );

  FlatButton _buildMoreButton() => FlatButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FlashSale()));
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Text(
          "Xem tất cả",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      );

  FlatButton _buildMoreButtonadd() => FlatButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PageHotSale()));
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Text(
          "Xem thêm",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      );

  Image _buildFlashSaleImage() => Image.asset(
        "assets/images/banners/ic_flash_sale.png",
        width: getProportionateScreenWidth(100.0),
      );
}

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

