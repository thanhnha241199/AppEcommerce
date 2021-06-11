import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  FirebaseServices _firebaseServices =FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order",
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
              future: _firebaseServices.orderRef.get(),
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
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${document.id}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16),
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "${document.data()['price']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16),
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "${document.data()['trang thai']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16),
                                      maxLines: 2,
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
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  await _firebaseServices.orderRef.doc(document.id).update({"trang thai": "Chưa xác nhận"}).whenComplete(() {
                                    Get.snackbar("Update", "Trang thai đổi thành chưa xác nhận",
                                        backgroundColor: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: Duration(milliseconds: 5000));
                                    Get.back();
                                    Get.back();
                                    Get.to(Order());
                                  });
                                },
                                child: Icon(EvaIcons.logInOutline, color: Colors.white),
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  await _firebaseServices.orderRef.doc(document.id).update({"trang thai": "Đã xác nhận"}).whenComplete(() {
                                    Get.snackbar("Update", "Trang thai đổi thành đã xác nhận",
                                        backgroundColor: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: Duration(milliseconds: 5000));
                                    Get.back();
                                    Get.back();
                                    Get.to(Order());
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
                                  await _firebaseServices.orderRef.doc(document.id).update({"trang thai": "Đang giao"}).whenComplete(() {
                                    Get.snackbar("Update", "Trang thai đổi thành đang giao",
                                        backgroundColor: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: Duration(milliseconds: 5000));
                                    Get.back();
                                    Get.back();
                                    Get.to(Order());
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
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  await _firebaseServices.orderRef.doc(document.id).update({"trang thai": "Đã giao"}).whenComplete(() {
                                    Get.snackbar("Update", "Trang thai đổi thành đã giao",
                                        backgroundColor: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: Duration(milliseconds: 5000));
                                    Get.back();
                                    Get.back();
                                    Get.to(Order());
                                  });
                                },
                                child: Icon(EvaIcons.doneAllOutline, color: Colors.white),
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
                                 await _firebaseServices.orderRef.doc(document.id).update({"trang thai": "Đã hủy"}).whenComplete(() {
                                    Get.snackbar("Update", "Trang thai đổi thành đã hủy",
                                        backgroundColor: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: Duration(milliseconds: 5000));
                                    Get.back();
                                    Get.back();
                                    Get.to(Order());
                                  });
                                },
                                child: Icon(EvaIcons.closeOutline, color: Colors.white),
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
          ],
        ),
      ),
    );
  }
}
