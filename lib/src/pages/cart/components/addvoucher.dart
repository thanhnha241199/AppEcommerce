import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:appecommerce/src/widgets/default_button.dart';

class Addvoucher extends StatefulWidget {
  @override
  _AddvoucherState createState() => _AddvoucherState();
}

class _AddvoucherState extends State<Addvoucher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                press: () {},
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
                          child: Text("Chọn sản phẩm trong giỏ trước khi chọn áp dụng voucher nhé!",style: TextStyle(
                            fontSize: 16
                          ),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Voucher chưa thể áp dụng",style: TextStyle(
                          fontSize: 16
                      ),),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void supportcode(context) {
    showModalBottomSheet(context: context, builder: (BuildContext bc) {
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
                  child: Text("Hỗ trợ",style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Cách Sử Dụng Voucher",style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Để có thể áp dụng mã Shopee voucher, bạn hãy chọn nút Lưu để lấy voucher về mục ví voucher của bạn nhé",style: TextStyle(
                      fontSize: 16
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Cách Tìm Voucher",style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Bạn có thể tìm thấy Shopee Voucher xuyên suốt trang shopee.vn và ứng dụng shopee. Mẹo riêng cho bạn nè, hãy bắt đầu với những trang chương trình khuyến mãi và trang chủ của shop nhé!",style: TextStyle(
                      fontSize: 16,
                  ),),
                )
              ],
            )
          ],
        ),
      );
    }
    );
  }
}
