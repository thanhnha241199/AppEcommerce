import 'dart:io';

import 'package:appecommerce/admin/Category/AddChildCategory.dart';
import 'package:appecommerce/admin/Category/EditChildCategory.dart';
import 'file:///D:/Flutter/appecommerce/lib/admin/Product/product.dart';
import 'package:appecommerce/login/shared/constant.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/signin/custom_btn.dart';
import 'package:appecommerce/signin/custom_input.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ChildCategory extends StatefulWidget {
  final String childcate;
  final String cateid;

  ChildCategory({this.childcate, this.cateid});

  @override
  _ChildCategoryState createState() => _ChildCategoryState();
}

class _ChildCategoryState extends State<ChildCategory> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${widget.childcate}",
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
                        future: _firebaseServices.cateRef
                            .doc(widget.childcate)
                            .collection("ChildCate")
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
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // Display the data inside a list view
                            return ListView(
                              physics: BouncingScrollPhysics(),
                              children: snapshot.data.docs.map((document) {
                                return GestureDetector(
                                  onTap: () {
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
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: FadeInImage(
                                                    fit: BoxFit.scaleDown,
                                                    image: NetworkImage(
                                                      "${document.data()['img']}",
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
                                                  "${document.data()['id']}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                  maxLines: 2,
                                                ),
                                                SizedBox(height: 10),
                                                Text.rich(
                                                  TextSpan(
                                                    text:
                                                        "${document.data()['content']}",
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
                                                          EditChildCate(
                                                              cateid: widget.childcate, childcate: document.id)));
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
                                                _firebaseServices.cateRef
                                                    .doc(widget.childcate)
                                                    .collection("ChildCate")
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
                future: _firebaseServices.cateRef
                    .doc(widget.childcate)
                    .collection("ChildCate")
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
                    return snapshot.data.size >0 ? ListView(
                      padding: EdgeInsets.only(
                        top: 100.0,
                        bottom: 12.0,
                      ),
                      children: snapshot.data.docs.map((document) {
                        print("${document.id}");
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
                                    color: Color(0xFFDADADA).withOpacity(0.15),
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
                                            "${document.data()['img']}",
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
                                        "${document.data()['id']}",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        maxLines: 2,
                                      ),
                                      SizedBox(height: 10),
                                      Text.rich(
                                        TextSpan(
                                          text: "${document.data()['content']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
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
                                                EditChildCate(
                                                    cateid:
                                                    document
                                                        .id)));
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
                                      _firebaseServices.cateRef
                                          .doc(widget.childcate)
                                          .collection("ChildCate")
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
                      AddChildCategory(cateid: widget.childcate)));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}



