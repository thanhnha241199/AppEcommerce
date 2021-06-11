import 'package:appecommerce/admin/Product/addproduct.dart';
import 'package:appecommerce/login/shared/constant.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/signin/custom_btn.dart';
import 'package:appecommerce/signin/custom_input.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class Product extends StatefulWidget {
  final String productId;

  Product({this.productId});

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> with SingleTickerProviderStateMixin {
  FirebaseServices _firebaseServices = FirebaseServices();
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

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

  String _searchString = "";
  ScrollController scrollController;
  bool dialVisible = true;

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Product",
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
                        future: _productsRef.get(),
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
                            return snapshot.data.size >0 ? ListView(
                              physics: BouncingScrollPhysics(),
                              children: snapshot.data.docs.map((document) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductPage(productId: document.id),
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
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
                                            SizedBox(
                                              width: 90,
                                              child: AspectRatio(
                                                aspectRatio: 0.9,
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF5F6F9),
                                                    borderRadius:
                                                        BorderRadius.circular(15),
                                                  ),
                                                  child: FadeInImage(
                                                    fit: BoxFit.scaleDown,
                                                    image: NetworkImage(
                                                      "${document.data()['images'][0]}",
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
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Container(
                                          height: 100,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          child: GestureDetector(
                                            onTap: () async {
                                              await _firebaseServices.productsRef.doc(document.id).update({"flashsale": "no"}).whenComplete(() {
                                                Get.snackbar("Update", "Trang thai đổi thành đã xác nhận",
                                                    backgroundColor: Colors.white,
                                                    snackPosition: SnackPosition.BOTTOM,
                                                    duration: Duration(milliseconds: 5000));
                                                Get.back();
                                                Get.back();
                                                Get.to(Product());
                                              });
                                            },
                                            child: Icon(EvaIcons.lockOutline, color: Colors.white),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          child: GestureDetector(
                                            onTap: () async{
                                              await _firebaseServices.productsRef.doc(document.id).update({"flashsale": "true"}).whenComplete(() {
                                                Get.snackbar("Update", "Có flashsale",
                                                    backgroundColor: Colors.white,
                                                    snackPosition: SnackPosition.BOTTOM,
                                                    duration: Duration(milliseconds: 5000));
                                                Get.back();
                                                Get.back();
                                                Get.to(Product());
                                              });
                                            },
                                            child: Icon(EvaIcons.loaderOutline, color: Colors.white),
                                          ),
                                        ),
                                      ],
                                      secondaryActions: <Widget>[
                                        Container(
                                          height: 100,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditProduct(
                                                              productId:
                                                                  document.id)));
                                            },
                                            child: Icon(EvaIcons.edit2Outline,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _firebaseServices.productsRef
                                                    .doc(document.id)
                                                    .delete();
                                              });
                                            },
                                            child: Icon(EvaIcons.trash2Outline,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ) : Container(
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
                future: _firebaseServices.productsRef
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
                    return ListView(
                      padding: EdgeInsets.only(
                        top: 100.0,
                        bottom: 12.0,
                      ),
                      children: snapshot.data.docs.map((document) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
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
                                  SizedBox(
                                    width: 90,
                                    child: AspectRatio(
                                      aspectRatio: 0.9,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF5F6F9),
                                          borderRadius:
                                          BorderRadius.circular(15),
                                        ),
                                        child: FadeInImage(
                                          fit: BoxFit.scaleDown,
                                          image: NetworkImage(
                                            "${document.data()['images'][0]}",
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
                                  color: Colors.blueAccent,
                                  borderRadius:
                                  BorderRadius.circular(30.0),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProduct(
                                                    productId:
                                                    document.id)));
                                  },
                                  child: Icon(EvaIcons.edit2Outline,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius:
                                  BorderRadius.circular(30.0),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _firebaseServices.productsRef
                                          .doc(document.id)
                                          .delete();
                                    });
                                  },
                                  child: Icon(EvaIcons.trash2Outline,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddProduct()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class EditProduct extends StatefulWidget {
  final String productId;

  EditProduct({this.productId});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Edit Product",
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
              onPressed: () {},
              icon: Icon(EvaIcons.search),
            ),
          ],
        ),
        body: Stack(
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
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView(
                        physics: BouncingScrollPhysics(),
                        children: snapshot.data.docs.map((documnent) {
                          print("${documnent.id}");
                          print("${widget.productId}");
                          return documnent.id == widget.productId
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 24.0),
                                      child: Text(
                                        "ID",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    CustomInput(
                                      hintText:
                                          documnent.data()['id'].toString(),
                                      textInputAction: TextInputAction.next,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 24.0),
                                      child: Text(
                                        "Name",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    CustomInput(
                                      hintText: documnent.data()['name'],
                                      textInputAction: TextInputAction.next,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 24.0),
                                      child: Text(
                                        "Price",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    CustomInput(
                                      hintText:
                                          documnent.data()['price'].toString(),
                                      onChanged: (value) {},
                                      onSubmitted: (value) {},
                                      textInputAction: TextInputAction.next,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 24.0),
                                      child: Text(
                                        "Image",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    CustomInput(
                                      hintText: documnent.data()['images'][0],
                                      textInputType: TextInputType.multiline,
                                      onChanged: (value) {},
                                      onSubmitted: (value) {},
                                      textInputAction: TextInputAction.next,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 24.0),
                                      child: Text(
                                        "Size",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    CustomInput(
                                      hintText: documnent.data()['size'][0],
                                      onChanged: (value) {},
                                      onSubmitted: (value) {},
                                      textInputAction: TextInputAction.next,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 24.0),
                                      child: Text(
                                        "Description",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    CustomInput(
                                      hintText: documnent.data()['desc'],
                                      textInputType: TextInputType.multiline,
                                      onChanged: (value) {},
                                      onSubmitted: (value) {},
                                      textInputAction: TextInputAction.next,
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    CustomBtn(
                                      text: "Save",
                                      onPressed: () {},
                                    )
                                  ],
                                )
                              : Text("");
                        }).toList());
                  }
                  return Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Loading(),
                    ),
                  );
                })
          ],
        ));
  }
}
