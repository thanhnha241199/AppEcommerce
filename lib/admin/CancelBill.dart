import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelBill extends StatefulWidget {
  @override
  _CancelBillState createState() => _CancelBillState();
}

class _CancelBillState extends State<CancelBill> {
  FirebaseServices _firebaseServices =FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cancel Bills",
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
              future: _firebaseServices.orderRef.where("trang thai",isEqualTo: "Đã hủy").get(),
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
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data.docs.map((document) {
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
