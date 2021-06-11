import 'package:flutter/material.dart';

class Voucher extends StatefulWidget {
  @override
  _VoucherState createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Voucher",
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
      body: Wrap(
        children: [
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
      ),
    );
  }
}
