import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:get/get.dart';
import 'package:appecommerce/widgets/default_button.dart';
import 'package:flutter/material.dart';

class AddressOrder extends StatefulWidget {
  String address;
  AddressOrder({this.address});
  @override
  _AddressOrderState createState() => _AddressOrderState();
}

class _AddressOrderState extends State<AddressOrder> {
  FirebaseServices _firebaseServices = FirebaseServices();
  Future _addToAddress() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Address")
        .doc(widget.address)
        .set({"Tinh": tinh,
      "Quan": quan,
      "Huyen":huyen,
      "Chitiet":chitiet,
      "Nguoinhan":namenguoinhan,
      "Sdt":sdt,
    });
  }
  String tinh;
  String quan;
  String huyen;
  String chitiet;
  String namenguoinhan;
  String sdt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Address",
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 24.0,
            ),
            decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(12.0)
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value){
                tinh=value;
              },
              decoration: InputDecoration(
                  hintMaxLines: 10,
                  border: InputBorder.none,
                  hintText: "Tỉnh/Thành Phố...",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 24.0,
            ),
            decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(12.0)
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value){
                quan=value;
              },
              decoration: InputDecoration(
                  hintMaxLines: 10,
                  border: InputBorder.none,
                  hintText: "Quận/Huyện...",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 24.0,
            ),
            decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(12.0)
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value){
                huyen=value;
              },
              decoration: InputDecoration(
                  hintMaxLines: 10,
                  border: InputBorder.none,
                  hintText: "Xã/Phường...",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 24.0,
            ),
            decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(12.0)
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value){
                chitiet=value;
              },
              decoration: InputDecoration(
                  hintMaxLines: 10,
                  border: InputBorder.none,
                  hintText: "Chi tiết: ...",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 24.0,
            ),
            decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(12.0)
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value){
                namenguoinhan=value;
              },
              decoration: InputDecoration(
                  hintMaxLines: 10,
                  border: InputBorder.none,
                  hintText: "Tên người nhận...",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 24.0,
            ),
            decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(12.0)
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value){
                sdt=value;
              },
              decoration: InputDecoration(
                  hintMaxLines: 10,
                  border: InputBorder.none,
                  hintText: "Số điện thoại...",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  )
              ),
            ),
          ),
          SizedBox(
            width: 190,
            child: DefaultButton(
              text: "Nhập",
              press: () {
                _addToAddress().whenComplete(() => Get.back());
              },
            ),
          ),
        ],
      ),
    );
  }
}
