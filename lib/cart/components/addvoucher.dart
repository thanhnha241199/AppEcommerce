import 'package:appecommerce/login/shared/constant.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/signin/checkout.dart';
import 'package:appecommerce/widgets/default_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Addvoucher extends StatefulWidget {
  @override
  _AddvoucherState createState() => _AddvoucherState();
}

class _AddvoucherState extends State<Addvoucher> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _voucherString;
  int tempt = 0;

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  void showFloatingFlushbar(BuildContext context, String text) {
    Flushbar(
      message: text,
      icon: Icon(
        EvaIcons.alertCircleOutline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      borderRadius: 8,
    )..show(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Thêm Voucher",
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
              onPressed: () {
                supportcode(context);
              },
              icon: Icon(EvaIcons.questionMarkCircleOutline),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _voucherString = value.toLowerCase();
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal)),
                                hintText: 'Enter your code',
                                prefixIcon: const Icon(
                                  Icons.card_giftcard,
                                ),
                              ),
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 120,
                              child: DefaultButton(
                                text: "Apply",
                                press: () async {
                                  tempt=0;
                                  await _firebaseServices.usersRef
                                      .doc(_firebaseServices.getUserId())
                                      .collection("Cart")
                                      .get()
                                      .then((querySnapshot) {
                                    querySnapshot.docs.forEach((result) {
                                      print(_voucherString);
                                      if(_voucherString.toUpperCase() =="EC150YL"){
                                        setState(() {
                                          print("Add thanh cong");
                                          tempt = tempt + result.data()['price']*result.data()['quantity'];
                                          Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckOut(tempt: tempt)));
                                          tempt = tempt - 150;
                                          showFloatingFlushbar(context, "Sản phẩm được giảm 150");
                                        });
                                      }else if(_voucherString.toUpperCase() == "EC300YL"){
                                        setState(() {
                                          print("Add thanh cong");
                                          tempt = tempt + result.data()['price']*result.data()['quantity'];
                                          Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckOut(tempt: tempt)));
                                          tempt = tempt - 300;
                                          showFloatingFlushbar(context, "Sản phẩm được giảm 300");
                                        });
                                      }else if(_voucherString.toUpperCase() == "EC50YL"){
                                        setState(() {
                                          print("Add thanh cong");
                                          tempt = tempt + result.data()['price']*result.data()['quantity'];
                                          Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckOut(tempt: tempt)));
                                          tempt = tempt - 50;
                                          showFloatingFlushbar(context, "Sản phẩm được giảm 50");
                                        });
                                      } else {
                                        showFloatingFlushbar(context, "Voucher không hợp lệ!!!");
                                      }
                                    });
                                  });

                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Scrollbar(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Color(0xFFf5f6f7),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Chọn sản phẩm trong giỏ trước khi chọn áp dụng voucher nhé!",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Voucher chưa thể áp dụng",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
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
                      width: 88,
                      child: AspectRatio(
                        aspectRatio: 0.88,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9)
                          ),
                          child: FadeInImage(
                            fit: BoxFit.scaleDown,
                            image: NetworkImage(
                              "https://cdn2.iconfinder.com/data/icons/shopping-352/1000/Mall-11-512.png",
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
                          "Giảm 50: EC50YL",
                          style: TextStyle(
                              color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tất cả sản phẩm",
                          style: TextStyle(
                              color: Colors.redAccent, fontSize: 12),
                          maxLines: 2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "HSD: 31.12.2020",
                          style: TextStyle(
                              color: Colors.black, fontSize: 16),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
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
                      width: 88,
                      child: AspectRatio(
                        aspectRatio: 0.88,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F6F9)
                          ),
                          child: FadeInImage(
                            fit: BoxFit.scaleDown,
                            image: NetworkImage(
                              "https://cdn2.iconfinder.com/data/icons/shopping-352/1000/Mall-11-512.png",
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
                          "Giảm 150: EC150YL",
                          style: TextStyle(
                              color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tất cả sản phẩm",
                          style: TextStyle(
                              color: Colors.redAccent, fontSize: 12),
                          maxLines: 2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "HSD: 31.12.2020",
                          style: TextStyle(
                              color: Colors.black, fontSize: 16),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
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
                      width: 88,
                      child: AspectRatio(
                        aspectRatio: 0.88,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9)
                          ),
                          child: FadeInImage(
                            fit: BoxFit.scaleDown,
                            image: NetworkImage(
                              "https://cdn2.iconfinder.com/data/icons/shopping-352/1000/Mall-11-512.png",
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
                          "Giảm 300: EC300YL",
                          style: TextStyle(
                              color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tất cả sản phẩm",
                          style: TextStyle(
                              color: Colors.redAccent, fontSize: 12),
                          maxLines: 2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "HSD: 31.12.2020",
                          style: TextStyle(
                              color: Colors.black, fontSize: 16),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void supportcode(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .60,
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.orange,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Hỗ trợ",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Cách Sử Dụng Voucher",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Để có thể áp dụng mã Shopee voucher, bạn hãy chọn nút Lưu để lấy voucher về mục ví voucher của bạn nhé",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Cách Tìm Voucher",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Bạn có thể tìm thấy Shopee Voucher xuyên suốt trang shopee.vn và ứng dụng shopee. Mẹo riêng cho bạn nè, hãy bắt đầu với những trang chương trình khuyến mãi và trang chủ của shop nhé!",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
