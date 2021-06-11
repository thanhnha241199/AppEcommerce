import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  double price;

  Dashboard({this.price});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    widget.price = sum;
  }

  @override
  double sum = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Dashboard",
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
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.orderRef.where("trang thai",isEqualTo: "Đã giao").get(),
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
                    children: snapshot.data.docs.map((document) {
                      sum= sum + document.data()['price'];
                      print(sum.toString());
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 24.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: FadeInImage(
                                      fit: BoxFit.scaleDown,
                                      image: NetworkImage(
                                        "https://www.mageworx.com/media/catalog/product/o/r/order_editor.png",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${document.id}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "${document.data()['price']}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "${document.data()['trang thai']}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    maxLines: 2,
                                  ),
                                ],
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
      ),
    );
  }
}

class Cart extends StatelessWidget {
  double dash;

  Cart({this.dash});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: 180,
        child: RaisedButton(
          //TODO: Navigator
          onPressed: () {
            Get.to(Dashboard());
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // TODO: Revenue
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Danh Thu",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "\$$dash",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 6),
                        blurRadius: 10,
                        color: Color(0xFFB0B0B0).withOpacity(0.2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      EvaIcons.creditCardOutline,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
