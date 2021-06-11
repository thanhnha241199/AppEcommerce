import 'package:appecommerce/constants.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/signin/addaddress.dart';
import 'package:appecommerce/signin/address.dart';
import 'package:appecommerce/widgets/default_button.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckOutController extends GetxController{
  FirebaseServices _firebaseServices = FirebaseServices();
  Future getData(String collection) async {
    QuerySnapshot snapshot = await _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection(collection)
        .limit(1)
        //.where('default', isEqualTo: true)
        .get();
    return snapshot.docs;
  }
  List address= [];
  List l = [];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  //   getDocs();
  // getAddress();
  }
  Future getAddress() async {
    QuerySnapshot querySnapshot = await _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Address")
        .where("default",isEqualTo: true)
        .get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      List temp = [];
      temp.add({
               "name": querySnapshot.docs[i]['nguoinhan'],
            "sdt": querySnapshot.docs[i]['sdt'],
            "chitiet": querySnapshot.docs[i]['chitiet'] + querySnapshot.docs[i]['huyen'] + querySnapshot.docs[i]['quan'] +querySnapshot.docs[i]['tinh'],
      });
      l.addAll(temp);
      print(l);
    }
  }
  Future getDocs() async {
    QuerySnapshot querySnapshot = await _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      List temp = [];
      temp.add({
  "name": querySnapshot.docs[i]['name'],
                "quantity": querySnapshot.docs[i]['quantity'],
                "id": querySnapshot.docs[i]['id'],
                "size": querySnapshot.docs[i]['size']

      });
      address.addAll(temp);
      print(querySnapshot.docs[i].id);
    }
  }
  Future deletecart() async {
    QuerySnapshot querySnapshot = await _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      _firebaseServices.usersRef
          .doc(_firebaseServices.getUserId())
          .collection("Cart").doc(querySnapshot.docs[i].id)
          .delete();
    }
  }
  Future _addToOrder(String orderid, double price,List address, List l) {
    return _firebaseServices.orderRef
        .doc(orderid)
        .set({
      "price": price,
      "uid": _firebaseServices.getUserId(),
      "product": FieldValue.arrayUnion(l),
      "address": FieldValue.arrayUnion(address),
      "hinh thuc thanh toan": select
    });
  }
}

class CheckOut extends StatelessWidget {
  final String orderId;
  final int tempt;
  CheckOut({this.orderId, this.tempt});
  FirebaseServices _firebaseServices = FirebaseServices();
  String DocumentID = "";
  int sum = 0;
  String _selectedProductSize = "0";
  int _quantity = 1;

  Future<dynamic> getData() async {
    QuerySnapshot querySnapshot = await _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart").get();
    var list = querySnapshot.docs;
    print(list);
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CheckOutController(),
        builder: (controller){
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Check Out",
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
                  GetBuilder<CheckOutController>(
                    init: CheckOutController(),
                    builder: (value) {
                      return FutureBuilder(
                        future: value.getData('Address'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return snapshot.data.length == 0 ? GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> Address()));
                              },
                              child: ListTile(
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                                title: Text(
                                  "Chua co dia chi",
                                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,color: Colors.black),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Icon(Icons.keyboard_arrow_right),
                                ),
                              ),
                            ) : ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return  GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Address()));
                                  },
                                  child: ListTile(
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                                    title: Column(mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Người nhận: "+snapshot.data[index].data()['Nguoinhan'],
                                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.black),
                                        ),
                                        Text(
                                          "Số điện thoại: " + snapshot.data[index].data()['Sdt'],
                                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    subtitle: Text("Địa chỉ: "+ snapshot.data[index].data()['Chitiet'] + ", " + snapshot.data[index].data()['Huyen'] + ", " +
                                        snapshot.data[index].data()['Quan'] + ", "+ snapshot.data[index].data()['Tinh'],
                                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Icon(Icons.keyboard_arrow_right),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 110),
                    child: FutureBuilder<QuerySnapshot>(
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
                          return ListView(
                            physics: BouncingScrollPhysics(),
                            children: snapshot.data.docs.map((document) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductPage(productId: document.id),
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
                                          DocumentID =  document.data()['id'];
                                          Map _productMap = productSnap.data.data();
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16.0,
                                              horizontal: 24.0,
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
                                                      "${_productMap['name']}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                      maxLines: 2,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text.rich(
                                                      TextSpan(
                                                        text:
                                                        "\$${_productMap['price']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            color: kPrimaryColor),
                                                        children: [
                                                          TextSpan(
                                                              text:
                                                              " x${document.data()['quantity']}",
                                                              style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1),
                                                        ],
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
                                          );
                                        }
                                        return Container();
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          );
                        }

                        // Loading State
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Loading(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
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
                        return Stack(
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
                                    .doc( document.data()['id'])
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
                                    _quantity=document.data()['quantity'];
                                    _selectedProductSize=document.data()['size'];
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
                                                      EvaIcons.creditCardOutline,
                                                      color: Colors.deepOrange,)
                                                ),
                                                Spacer(),
                                                DropDown(),
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
                                                    children: [
                                                      TextSpan(
                                                        text: "\$${tempt}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                            Colors.black,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 190,
                                                  child: DefaultButton(
                                                    text: "Order",
                                                    press: () async {
                                                      List address =[];
                                                      List product =[];
                                                        await _firebaseServices.usersRef
                                                            .doc(_firebaseServices.getUserId())
                                                            .collection("Address")
                                                            .where("default",isEqualTo: true)
                                                            .get()
                                                            .then((querySnapshot) {
                                                              print(querySnapshot.docs.map((e) {
                                                                List temp = [];
                                                                temp.add({
                                                                  "name": e['Nguoinhan'],
                                                                  "sdt" : e["Sdt"],
                                                                  "chitiet": e['Chitiet']+ ", "+e['Huyen']+ ", "+e['Quan']+ ", "+e['Tinh']
                                                                });
                                                                address.addAll(temp);
                                                                print(address);
                                                                return address;
                                                              } ));
                                                        });
                                                      await _firebaseServices.usersRef
                                                          .doc(_firebaseServices.getUserId())
                                                            .collection("Cart")
                                                            .get()
                                                          .then((querySnapshot) {
                                                        print(querySnapshot.docs.map((e) {
                                                          print(e['images']);
                                                          List temp1 = [];
                                                          temp1.add({
                                                            "name": e['name'],
                                                            "quantity": e['quantity'],
                                                            "id": e['id'],
                                                            "size": e['size'],
                                                            "images":e['images']
                                                          });
                                                          product.addAll(temp1);
                                                          print(product);
                                                          return product;
                                                        } ));
                                                      });
                                                      //controller.getDocs();
                                                     // controller.getAddress();
                                                     // controller._to
                                                      await _firebaseServices.orderRef
                                                          .doc(this.orderId)
                                                          .set({
                                                        "price": this.tempt.toDouble(),
                                                        "uid": _firebaseServices.getUserId(),
                                                        "product": FieldValue.arrayUnion(product),
                                                        "address": FieldValue.arrayUnion(address),
                                                        "hinh thuc thanh toan": select,
                                                        "trang thai": "Chưa xác nhận",
                                                        "gioigian": DateTime.now(),
                                                      });
                                                      controller.deletecart();
                                                      print("click");
                                                      Get.offAll(OrderSuccess());
                                                      //getData();

                                                      //createRecord();
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
                                  return Container();
                                },
                              ),
                            );
                          }).toList(),
                        );
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
          );
    });
  }
}

String select;
class DropDown extends StatefulWidget {
  DropDown() : super();

  final String title = "DropDown Demo";

  @override
  DropDownState createState() => DropDownState();
}
class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Hình thức thanh toán'),
      Company(2, 'Tiền mặt'),
      Company(3, 'Thanh toán qua trước'),
    ];
  }
}
class DropDownState extends State<DropDown> {
  //
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name, textAlign: TextAlign.center,),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: DropdownButton(
          value: _selectedCompany,
          icon: Icon(EvaIcons.arrowDownOutline),
          iconDisabledColor: Colors.red,
          underline: SizedBox(),
          items: _dropdownMenuItems,
          onChanged: onChangeDropdownItem,
          onTap: (){
            setState(() {
              select = _selectedCompany.name;
            });
            print(select);
          },
        ),
      ),
    );
  }
}
class OrderSuccess extends StatefulWidget {
  @override
  _OrderSuccessState createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                        SizedBox(
                          height: 70,
                          child: Container(
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 350,
                          child: Image.asset(
                            "assets/images/success.png",
                            height: 350,
                            width: double.infinity,
                            fit: BoxFit.cover,
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
                                "Order successfulll!",
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
                                    text: "Tiếp tục mua hàng",
                                    press: () {
                                      Get.offAllNamed("/BottomNav");
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ))
              ]),
        )
    );
  }
}
