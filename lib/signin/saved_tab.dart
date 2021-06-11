import 'package:appecommerce/constants.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/pages/Search.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SavedTab extends StatefulWidget {
  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  String DocumentID = "";

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Saved",
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
            icon: Icon(EvaIcons.search),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef
                  .doc(_firebaseServices.getUserId())
                  .collection("Saved")
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
                  return snapshot.data.size > 0
                      ? ListView(
                          children: snapshot.data.docs.map((document) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                          productId: document.data()['id']),
                                    ));
                              },
                              child: FutureBuilder(
                                future: _firebaseServices.productsRef
                                    .doc(document.data()['id'])
                                    .get(),
                                builder: (context, productSnap) {
                                  if (productSnap.hasError) {
                                    return Container(
                                      child: Center(
                                        child: Text("${productSnap.error}"),
                                      ),
                                    );
                                  }
                                  if (productSnap.connectionState ==
                                      ConnectionState.done) {
                                    DocumentID = document.id;
                                    Map _productMap = productSnap.data.data();
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16.0,
                                        horizontal: 24.0,
                                      ),
                                      child: Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        actionExtentRatio: 0.25,
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
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 88,
                                                child: AspectRatio(
                                                  aspectRatio: 0.88,
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFF5F6F9),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: FadeInImage(
                                                      fit: BoxFit.scaleDown,
                                                      image: NetworkImage(
                                                        "${_productMap['images'][0]}",
                                                      ),
                                                      placeholder: AssetImage(
                                                        'assets/shared/loading.gif',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${_productMap['name']}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 22),
                                                    maxLines: 2,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text.rich(
                                                    TextSpan(
                                                      text:
                                                          "\$${_productMap['price']}",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: kPrimaryColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        secondaryActions: <Widget>[
                                          Container(
                                            height: 100,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius.circular(30.0),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _firebaseServices.usersRef
                                                      .doc(_firebaseServices.getUserId())
                                                      .collection("Saved")
                                                      .doc(document.id)
                                                      .delete();
                                                });
                                              },
                                              child: Icon(EvaIcons.trash2Outline, color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            );
                          }).toList(),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 70,
                                        child: Container(
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                      Container(
                                        height: 250,
                                        width: double.infinity,
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
                                              "You haven't product",
                                              style: TextStyle(
                                                color: Color(0xFF67778E),
                                                fontFamily: 'Roboto-Light.ttf',
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
                            ]);
                }

                // Loading State
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Loading(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
