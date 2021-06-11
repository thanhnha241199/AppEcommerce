import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _searchString = "";

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.red,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        title: _buildSearch(),
        actions: _buildActions(),
      ),
      body: Scrollbar(
          child: Container(
        child: Stack(
          children: [
            if (_searchString.isEmpty)
              Center(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "Suggest Search",
                                    style: Constants.regularDarkText,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Chips(
                                        topic: "Coding Coding",
                                        isSelected: true),
                                    Chips(
                                        topic: "Working Shopping",
                                        isSelected: true),
                                    Chips(topic: "Shopping", isSelected: true),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Chips(
                                        topic: "Coding  Coding ",
                                        isSelected: true),
                                    Chips(
                                        topic: "Working  2", isSelected: true),
                                    Chips(
                                        topic: "Shopping  ", isSelected: true),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
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
                    return snapshot.data.size > 0
                        ? ListView(
                            children: snapshot.data.docs.map((document) {
                              return ProductCard(
                                title: document.data()['name'],
                                imageUrl: document.data()['images'][0],
                                price: "\$${document.data()['price']}",
                                productId: document.id,
                              );
                            }).toList(),
                          )
                        : Container(
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
          ],
        ),
      )),
    );
  }

  Widget _buildSearch() {
    return TextField(
      onSubmitted: (value) {
        setState(() {
          _searchString = value.toLowerCase();
        });
      },
      autofocus: true,
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
          fontSize: 18,
          color: Colors.deepOrange,
        ),
        prefixIcon: Icon(
          EvaIcons.search,
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40,
          minHeight: 40,
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
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Center(
            child: Text("Thoát", style: TextStyle(fontSize: 16)),
          ),
        ),
      )
    ];
  }
}

class Chips extends StatelessWidget {
  final String topic;
  final bool isSelected;

  Chips({this.topic, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.purple.withOpacity(0.1)
            : Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(100),
      ),
      alignment: Alignment.center,
      child: Text(
        topic,
        style: TextStyle(
            color: isSelected
                ? Colors.purple.withOpacity(0.7)
                : Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
