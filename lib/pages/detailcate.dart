import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'MainMenu/menu1.dart';

class Cate extends StatefulWidget {
  String id;
  Cate({this.id});
  @override
  _CateState createState() => _CateState();
}

class _CateState extends State<Cate> {
  FirebaseServices _firebaseServices =FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Danh muc",
          style: TextStyle(color: Colors.black),
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
      body:  Container(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productsRef.where("id", isEqualTo: widget.id)
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
                  return snapshot.data.size > 0 ? GridView.count(
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
                return Text("");
              },
            ),
          ],
        ),
      ),
    );
  }
}
