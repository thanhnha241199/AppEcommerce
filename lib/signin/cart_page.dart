import 'package:appecommerce/cart/components/addvoucher.dart';
import 'package:appecommerce/login/shared/constant.dart';
import 'package:appecommerce/pages/BottomNavigation.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/pages/Search.dart';
import 'package:appecommerce/signin/checkout.dart';
import 'package:appecommerce/widgets/default_button.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartPage extends StatefulWidget {
  final String productId;
  final String saveId;
  CartPage({this.productId, this.saveId});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  
  int sum = 0;
  String DocumentID = "";
  List<String> productName=[];
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  static const String routeName = '/CartPage';
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  void showFloatingFlushbar(BuildContext context, String text) {
    Flushbar(
      message: text,
      icon: Icon(
        EvaIcons.alertCircleOutline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      borderRadius: 8,
    )..show(context);
  }
  @override
  Widget build(BuildContext context) {
    sum = 0;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Cart",
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
              setState(() {
              });
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
                    .collection("Cart")
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data.size > 0
                        ? ListView(
                            physics: BouncingScrollPhysics(),
                            children: snapshot.data.docs.map((document) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductPage(productId: document.data()['id']),
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
                                      Map _productMap = productSnap.data.data();
                                      DocumentID = document.id;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16.0,
                                          horizontal: 24.0,
                                        ),
                                        child: Slidable(
                                          actionPane:
                                          SlidableDrawerActionPane(),
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
                                                SizedBox(
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
                                                      "${document.data()['name']}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                      maxLines: 2,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text.rich(
                                                      TextSpan(
                                                        text:
                                                        "\$${document.data()['price']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            color: kPrimaryColor),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text.rich(
                                                      TextSpan(
                                                        text:
                                                        "Size - ${document.data()['size']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            color: kPrimaryColor),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Row(
                                                        children: [
                                                          document.data()[
                                                          'quantity'] !=
                                                              0
                                                              ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _firebaseServices
                                                                    .usersRef
                                                                    .doc(_firebaseServices
                                                                    .getUserId())
                                                                    .collection(
                                                                    "Cart")
                                                                    .doc(document.id)
                                                                    .update({
                                                                  "quantity": document
                                                                      .data()[
                                                                  'quantity'] = document
                                                                      .data()['quantity'] -
                                                                      1,
                                                                  "size": document
                                                                      .data()[
                                                                  'size']
                                                                });
                                                              });
                                                            },
                                                            child:
                                                            Container(
                                                              height: 20.0,
                                                              width: 20.0,
                                                              decoration: BoxDecoration(
                                                                color: Colors.black,
                                                                borderRadius: BorderRadius.circular(5.0),
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                  FontAwesomeIcons.minus,
                                                                  color: Colors.white,
                                                                  size: 12.0,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                              : Container(),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                8.0),
                                                            child: Text(
                                                              "${document.data()['quantity']}",
                                                              style: TextStyle(
                                                                fontSize: 18.0,
                                                                color:
                                                                Colors.black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _firebaseServices
                                                                    .usersRef
                                                                    .doc(_firebaseServices
                                                                    .getUserId())
                                                                    .collection(
                                                                    "Cart")
                                                                    .doc(document.id)
                                                                    .update({
                                                                  "quantity": document
                                                                      .data()[
                                                                  'quantity'] = document
                                                                      .data()[
                                                                  'quantity'] +
                                                                      1,
                                                                  "size": document
                                                                      .data()[
                                                                  'size']
                                                                });
                                                              });
                                                            },
                                                            child: Container(
                                                              height: 20.0,
                                                              width: 20.0,
                                                              decoration: BoxDecoration(
                                                                color: Colors.black,
                                                                borderRadius: BorderRadius.circular(5.0),
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                  FontAwesomeIcons.plus,
                                                                  color: Colors.white,
                                                                  size: 12.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
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
                                                color: Colors.black,
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                              child: GestureDetector(
                                                onTap: () async{
                                                    await _firebaseServices.usersRef
                                                        .doc(_firebaseServices.getUserId())
                                                        .collection("Saved")
                                                        .get()
                                                        .then((querySnapshot) {
                                                      if(querySnapshot.size == 0){
                                                        _firebaseServices.usersRef
                                                            .doc(_firebaseServices.getUserId())
                                                            .collection("Saved")
                                                            .doc(widget.saveId)
                                                            .set({
                                                          "id": document.data()['id'],
                                                          "name": document.data()['name'],
                                                        });
                                                        // Scaffold.of(context).showSnackBar(_snackBarSave);
                                                      }else if(querySnapshot.size != 0){
                                                        querySnapshot.docs.asMap().forEach((index, result) {
                                                          productName.add(querySnapshot.docs[index]["id"]);
                                                        }
                                                        );
                                                      }
                                                    });
                                                    print(productName);
                                                    print(productName.where((i) => i == document.data()['id']));
                                                    if(productName.where((i) => i == document.data()['id']).isEmpty){
                                                      _firebaseServices.usersRef
                                                          .doc(_firebaseServices.getUserId())
                                                          .collection("Saved")
                                                          .doc(widget.saveId)
                                                          .set({
                                                        "id": document.data()['id'],
                                                        "name": document.data()['name'],
                                                      });
                                                      showFloatingFlushbar(context, "Add to cart");
                                                    }else{
                                                      showFloatingFlushbar(context,"Product Existed!!!!");
                                                    }
                                                    productName = [];
                                                  },
                                                child: Icon(EvaIcons.heartOutline, color: Colors.white,),
                                              )
                                            ),
                                            Container(
                                              height: 100,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                color: Colors.blueAccent,
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _firebaseServices.usersRef
                                                          .doc(_firebaseServices.getUserId())
                                                          .collection("Cart")
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
                                                "You haven't product",
                                                style: TextStyle(
                                                  color: Color(0xFF67778E),
                                                  fontFamily:
                                                      'Roboto-Light.ttf',
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: SizedBox(
                                                  width: 190,
                                                  child: DefaultButton(
                                                    text: "Mua hàng",
                                                    press: () {
                                                      Navigator.pop(context);
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              new MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          BottomNav()));
                                                    },
                                                  ),
                                                ),
                                              )
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
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Stack(
            children: [
              FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.usersRef
                    .doc(_firebaseServices.getUserId())
                    .collection("Cart")
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data.size > 0
                        ? Stack(
                            children: snapshot.data.docs.map((document) {
                              return GestureDetector(
                                onTap: () {},
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
                                      sum = sum +
                                          _productMap['price'] *
                                              document.data()['quantity'];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 30,
                                          horizontal: 30,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, -15),
                                              blurRadius: 20,
                                              color: Color(0xFFDADADA)
                                                  .withOpacity(0.15),
                                            )
                                          ],
                                        ),
                                        child: SafeArea(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFF5F6F9),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                    ),
                                                    child: Icon(
                                                      EvaIcons.shoppingCartOutline,
                                                      color: Colors.deepOrange,)
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                      "Shipping : \$0"),
                                                  const SizedBox(
                                                      width: 10)
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFF5F6F9),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: SvgPicture.asset(
                                                        "assets/icons/receipt.svg"),
                                                  ),
                                                  Spacer(),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Addvoucher()));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            "Add voucher code"),
                                                        const SizedBox(
                                                            width: 10),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          size: 12,
                                                          color: Colors.black,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text.rich(
                                                    TextSpan(
                                                      text: "Total:\n",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black),
                                                      children: [
                                                        TextSpan(
                                                          text: "\$${sum}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 190,
                                                    child: DefaultButton(
                                                      text: "Check Out",
                                                      press: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        CheckOut(tempt: sum)));
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    return Container(
                                      color: Colors.white,
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          )
                        : Text("");
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
        ));
  }
}
