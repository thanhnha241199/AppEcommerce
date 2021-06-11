import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/signin/addaddress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  FirebaseServices _firebaseServices = FirebaseServices();

  Future getData(String collection) async {
    QuerySnapshot snapshot = await _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection(collection)
        .get();
    return snapshot.docs;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

class Address extends StatelessWidget {
  String address;

  Address({this.address});

  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Address",
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
          child: GetBuilder<AddressController>(
            init: AddressController(),
            builder: (value) {
              return FutureBuilder(
            future: value.getData('Address'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10),
                                    child: Text(
                                      "Tên Người nhận: " +
                                          snapshot.data[index]
                                              .data()['Nguoinhan'],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10),
                                    child: Text(
                                      "Số điện thoại: " +
                                          snapshot.data[index].data()['Sdt'],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10),
                                    child: Text(
                                      "Địa chỉ: " +
                                          snapshot.data[index].data()['Tinh'] +
                                          ", " +
                                          snapshot.data[index].data()['Quan'] +
                                          ", " +
                                          snapshot.data[index].data()['Huyen'] +
                                          ", " +
                                          snapshot.data[index]
                                              .data()['Chitiet'],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      maxLines: 2,
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
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                _firebaseServices.usersRef
                                    .doc(_firebaseServices.getUserId())
                                    .collection("Address")
                                    .doc()
                                    .update({
                                  "default": true,
                                }).whenComplete(() => Get.back());
                                print("${snapshot.data[index].data()['id']}");
                              },
                              child: Icon(EvaIcons.edit2Outline,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddressOrder());
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
