import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/widgets/default_button.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetail extends StatefulWidget {
  String detail;

  OrderDetail({this.detail});

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  FirebaseServices _firebaseFirestore = FirebaseServices();
String check="Chưa xác nhận";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detail Order",
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
            setState(() {});
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseFirestore.orderRef.limit(1).get(),
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
                    return Wrap(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Người nhận: " +
                                    document.data()['address'][0]['name'],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                "Số điện thoại: " +
                                    document.data()['address'][0]['sdt'],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            "Địa chỉ: " +
                                document.data()['address'][0]['chitiet'],
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                        Wrap(
                          children: List.generate(
                              document.data()['product'].length,
                              (index) => Row(
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
                                                document.data()['product']
                                                    [index]['images'],
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
                                            "${document.data()['product'][index]['id']}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                            maxLines: 2,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "${document.data()['product'][index]['name']}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                            maxLines: 2,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "${document.data()['product'][index]['size']}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Text(
                            "ORDERID: " + document.id,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Text(
                            "Hinh thuc thanh toan: " +
                                document.data()['hinh thuc thanh toan'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Text(
                            "Trang thai: " + document.data()['trang thai'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                       SizedBox(
                          width: 190,
                          child: DefaultButton(
                            text: "Huy don",
                            press: () {
                              _firebaseFirestore.orderRef
                                  .doc(widget.detail)
                                  .update({
                                "trang thai": "Đã hủy"
                              }).whenComplete(() {
                                Get.back();
                                Get.to(OrderDetail());
                              });
                            },
                          ),
                        )
                      ],
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
    );
  }
}
