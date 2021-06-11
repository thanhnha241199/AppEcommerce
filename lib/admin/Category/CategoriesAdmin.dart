import 'package:appecommerce/admin/Category/AddCategory.dart';
import 'package:appecommerce/admin/Category/ChildCategory.dart';
import 'package:appecommerce/admin/Category/DetailCategory.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/signin/custom_input.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CategoriesAdmin extends StatefulWidget {
  CategoriesAdmin({Key key}) : super(key: key);

  @override
  _CategoriesAdminState createState() => _CategoriesAdminState();
}

class _CategoriesAdminState extends State<CategoriesAdmin>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  ScrollController scrollController;
  bool dialVisible = true;

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  FirebaseServices _firebaseServices = FirebaseServices();
  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Categories",
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
      body: Container(
        child: Stack(
          children: [
            if (_searchString.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  child: Stack(
                    children: [
                      FutureBuilder<QuerySnapshot>(
                        future: _firebaseServices.cateRef.get(),
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
                            return Container(
                                child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 2,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.all(8),
                              children: snapshot.data.docs.map((document) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChildCategory(childcate: document.id)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, -15),
                                              blurRadius: 20,
                                              color: Color(0xFFDADADA)
                                                  .withOpacity(0.15),
                                            ),
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Column(
                                              children: <Widget>[
                                                //Now change font's family from "Google Fonts"
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: FadeInImage(
                                                    height: 100,
                                                    width: 100,
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      "${document.data()['img']}",
                                                    ),
                                                    placeholder: AssetImage(
                                                      'assets/shared/loading.gif',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              document.data()['content'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            // child: Text(this.category.content, textAlign: TextAlign.center,
                                            //   style: Theme.of(context).textTheme.title,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ));
                          }
                          // Loading State
                          return Scaffold(
                            body: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Loading(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            else
              FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.cateRef
                    .orderBy("search_string")
                    .startAt([_searchString]).endAt(
                        ["$_searchString\uf8ff"]).get(),
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
                    return snapshot.data.size > 0 ? ListView(
                      padding: EdgeInsets.only(
                        top: 100.0,
                        bottom: 12.0,
                      ),
                      children: snapshot.data.docs.map((document) {
                        print("${document.data().length}");
                        return Container(
                            child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 2,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(8),
                          children: snapshot.data.docs.map((document) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChildCategory(childcate: document.id)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, -15),
                                          blurRadius: 20,
                                          color: Color(0xFFDADADA)
                                              .withOpacity(0.15),
                                        ),
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            //Now change font's family from "Google Fonts"
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: FadeInImage(
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "${document.data()['img']}",
                                                ),
                                                placeholder: AssetImage(
                                                  'assets/shared/loading.gif',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          document.data()['content'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // child: Text(this.category.content, textAlign: TextAlign.center,
                                        //   style: Theme.of(context).textTheme.title,),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ));
                      }).toList(),
                    ): Container(
                      color: Colors.white,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                decoration:
                                BoxDecoration(color: Colors.white),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 250,
                                      child: Image.asset(
                                        "assets/images/empty_shopping_cart.png",
                                        height: 250,
                                        width: double.infinity,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      child: Container(
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Not Found",
                                            style: TextStyle(
                                              color: Color(0xFF67778E),
                                              fontFamily:
                                              'Roboto-Light.ttf',
                                              fontSize: 20,
                                              fontStyle: FontStyle.normal,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                          ]),
                    );
                  }

                  // Loading State
                  return Scaffold(
                    body: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Loading(),
                      ),
                    ),
                  );
                },
              ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: CustomInput(
                hintText: "Search here...",
                onSubmitted: (value) {
                  setState(() {
                    _searchString = value.toLowerCase();
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // child: Icon(Icons.add),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        visible: dialVisible,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: Icon(EvaIcons.plusOutline, color: Colors.white),
            backgroundColor: Colors.deepOrange,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddCategory()));
            },
            label: 'Add Categories',
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            labelBackgroundColor: Colors.deepOrangeAccent,
          ),
          SpeedDialChild(
            child: Icon(Icons.brush, color: Colors.white),
            backgroundColor: Colors.green,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailCategory()));
            },
            label: 'Edit Categories',
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            labelBackgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
