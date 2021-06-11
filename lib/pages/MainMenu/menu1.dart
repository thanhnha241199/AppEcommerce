import 'package:appecommerce/constants.dart';
import 'package:appecommerce/pages/BottomNavigation.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/pages/Search.dart';
import 'package:appecommerce/signin/ReviewProduct.dart';
import 'package:appecommerce/signin/cart_page.dart';
import 'package:appecommerce/signin/login_page.dart';
import 'package:appecommerce/size_config.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Menu1 extends StatefulWidget {
  @override
  _Menu1State createState() => _Menu1State();
}

class _Menu1State extends State<Menu1> {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");
  static String routeName = "/Menu1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Deal Gần Bạn - Chỉ 1K",
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
            },
            icon: Icon(EvaIcons.search),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _productsRef.get(),
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
                  return GridView.count(
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 1 / 1.25,
                    children: snapshot.data.docs.map((document) {
                      return Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: FadeInImage(
                                      height: 125,
                                      width: 125,
                                      fit: BoxFit.scaleDown,
                                      image: NetworkImage(
                                        document.data()['images'][0],
                                      ),
                                      placeholder: AssetImage(
                                        'assets/shared/loading.gif',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    document.data()['name'],
                                  ),
                                  Text(
                                    "\$${document.data()['price']}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductPage(productId: document.id),
                                    ));
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
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Loading(),
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

class ProductCard extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;

  ProductCard(
      {this.onPressed, this.imageUrl, this.title, this.price, this.productId});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 1 / 1.25,
      children: [
        Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.hardEdge,
                        child: Center(
                          child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loading.gif',
                              image: "$imageUrl"),
                        ),
                      ),
                    ),
                    Text(
                      title,
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(productId: productId),
                      ));
                },
              ),
            )
          ],
        )
      ],
    );
    //   GestureDetector(
    //   onTap: () {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => ProductPage(productId: productId),
    //         ));
    //   },
    //   child: Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(12.0),
    //     ),
    //     height: 350.0,
    //     margin: EdgeInsets.symmetric(
    //       vertical: 12.0,
    //       horizontal: 24.0,
    //     ),
    //     child: Stack(
    //       children: [
    //         Container(
    //           height: 350.0,
    //           child: ClipRRect(
    //             borderRadius: BorderRadius.circular(12.0),
    //             child: FadeInImage(
    //               fit: BoxFit.cover,
    //               image: NetworkImage(
    //                 "$imageUrl",
    //               ),
    //               placeholder: AssetImage(
    //                 'assets/shared/loading.gif',
    //               ),
    //             ),
    //             // child:
    //           ),
    //         ),
    //         Positioned(
    //           bottom: 0,
    //           left: 0,
    //           right: 0,
    //           child: Padding(
    //             padding: const EdgeInsets.all(24.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text(
    //                   title,
    //                   style: Constants.regularHeading,
    //                 ),
    //                 Text(
    //                   price,
    //                   style: TextStyle(
    //                       fontSize: 18.0,
    //                       color: Theme.of(context).accentColor,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}

class Constants {
  static const regularHeading = TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const boldHeading = TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const regularDarkText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black);
}

class ProductPage extends StatefulWidget {
  final String productId;
  final String cartId;
  final String saveId;

  ProductPage({this.productId, this.cartId, this.saveId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _selectedProductSize = "0";
  int _quantity = 1;
  int selectedImage = 0;
  String productid;
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  void showFloatingFlushbar(BuildContext context, String text) {
    Flushbar(
      message: text,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      borderRadius: 8,
    )..show(context);
  }
  List review = [];
  Future<dynamic> getData() async {

    final DocumentReference document =   FirebaseFirestore.instance.collection("Products").doc(productid);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        review.addAll(snapshot.data()['Review']);
        print(review);
      });
    });
  }
  int _n = 1;
  String firstHalf;

  String secondHalf;
  bool flag = true;
  int notic;
  List<String> productName = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();
  }
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    //getData();
  }

  Stack _buildIconButton({
    VoidCallback onPressed,
    IconData icon,
    int notification = 0,
  }) =>
      Stack(
        children: <Widget>[
          IconButton(
            iconSize: 30,
            onPressed: onPressed,
            icon: Icon(icon),
            color: Colors.black,
          ),
          notification == 0
              ? SizedBox()
              : Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.white),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      '$notification',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    setState(() {
      productid=widget.productId;
    });
    notic = 0;
    _quantity = _n;
    int price;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Chi tiết sản phẩm",
          style: TextStyle(color: Colors.black),
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
          Stack(
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
                  // Collection Data ready to display
                  if (snapshot.connectionState == ConnectionState.done) {
                    // Display the data inside a list view
                    return snapshot.data.size > 0
                        ? Stack(
                            children: snapshot.data.docs.map((document) {
                              //print("${document.id}");
                              notic = notic + document.data()['quantity'];
                              return Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _buildIconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CartPage()));
                                      },
                                      icon: EvaIcons.shoppingBagOutline,
                                      notification: notic,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Search()));
                                      },
                                      icon: Icon(EvaIcons.searchOutline),
                                      iconSize: 28,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          )
                        : Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _buildIconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CartPage()));
                                      },
                                      icon: EvaIcons.shoppingBagOutline,
                                      notification: 0,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Search()));
                                      },
                                      icon: Icon(EvaIcons.searchOutline),
                                      iconSize: 28,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                  }
                  return Text("");
                },
              ),
            ],
          )
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data.data();
                List productSizes = documentData['size'];
                _selectedProductSize = productSizes[0];

                if (documentData['desc'].toString().length > 50) {
                  firstHalf = documentData['desc'].substring(0, 50);
                  secondHalf = documentData['desc']
                      .substring(50, documentData['desc'].toString().length);
                } else {
                  firstHalf = documentData['desc'].toString();
                  secondHalf = "";
                }
                return ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Wrap(
                      children: [
                        SizedBox(
                          width: getProportionateScreenWidth(280),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Hero(
                              tag: Text(
                                "${documentData['name']}",
                                style: Constants.boldHeading,
                              ),
                              child: FadeInImage(
                                height: getProportionateScreenHeight(280),
                                fit: BoxFit.scaleDown,
                                image: NetworkImage(
                                  "${documentData['images'][selectedImage]}",
                                ),
                                placeholder: AssetImage(
                                  'assets/shared/loading.gif',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (var index = 0;
                                  index < documentData['images'].length;
                                  index++)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedImage = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: defaultDuration,
                                    margin: EdgeInsets.only(right: 15),
                                    padding: EdgeInsets.all(8),
                                    height: getProportionateScreenHeight(48),
                                    width: getProportionateScreenWidth(48),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.red.withOpacity(
                                              selectedImage == index ? 1 : 0)),
                                    ),
                                    child: FadeInImage(
                                      fit: BoxFit.scaleDown,
                                      image: NetworkImage(
                                        "${documentData['images'][index]}",
                                      ),
                                      placeholder: AssetImage(
                                        'assets/shared/loading.gif',
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 14.0,
                        left: 24.0,
                        right: 24.0,
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                "${documentData['rating']}/5.0",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              SvgPicture.asset(
                                "assets/icons/Star Icon.svg",
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 6.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 4.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${documentData['name']}",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$${documentData['price']}",
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            child: Text(
                              "Quantity: ",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              _n != 0
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _n--;
                                        });
                                      },
                                      child: Container(
                                        width: 25.0,
                                        height: 25.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFDCDCDC),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 4.0,
                                        ),
                                        child: Icon(
                                          EvaIcons.minusOutline,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "$_n",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _n++;
                                      });
                                    },
                                    child: Container(
                                      width: 25.0,
                                      height: 25.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFDCDCDC),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      child: Icon(
                                        EvaIcons.plusOutline,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "Select Size:",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ProductSize(
                      productSizes: productSizes,
                      onSelected: (size) {
                        _selectedProductSize = size;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Description: ",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          secondHalf.isEmpty
                              ? new Text(firstHalf)
                              : new Column(
                                  children: <Widget>[
                                    new Text(
                                      flag
                                          ? (firstHalf + "...")
                                          : (firstHalf + secondHalf),
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    new InkWell(
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: new Text(
                                              flag ? "Show all" : "Show less",
                                              style: new TextStyle(
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          flag = !flag;
                                        });
                                      },
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:24,vertical: 10.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Review: ",
                                style: TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.to(Review(productid: widget.productId,));
                                },
                                child: Text(
                                  "Show all",
                                  style: TextStyle(
                                      fontSize: 20.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                         Wrap(
                          children: List.generate( documentData['Review'].length > 3 ? 3 : documentData['Review'].length ==2 ? 2 : documentData['Review'].length ==1 ? 1 : 0, (index) => new CustomReview(comment: documentData['Review'][index]['comment'], rating: documentData['Review'][index]['rating'].toDouble(),)),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await _firebaseServices.usersRef
                                  .doc(_firebaseServices.getUserId())
                                  .collection("Saved")
                                  .get()
                                  .then((querySnapshot) {
                                if (querySnapshot.size == 0) {
                                  _firebaseServices.usersRef
                                      .doc(_firebaseServices.getUserId())
                                      .collection("Saved")
                                      .doc(widget.saveId)
                                      .set({
                                    "id": widget.productId,
                                    "name": documentData['name'],
                                  });
                                  showFloatingFlushbar(
                                      context, "Product add to save");
                                } else if (querySnapshot.size != 0) {
                                  querySnapshot.docs
                                      .asMap()
                                      .forEach((index, result) {
                                    productName
                                        .add(querySnapshot.docs[index]["id"]);
                                  });
                                }
                              });
                              print(productName
                                  .where((i) => i == widget.productId));
                              if (productName
                                  .where((i) => i == widget.productId)
                                  .isEmpty) {
                                _firebaseServices.usersRef
                                    .doc(_firebaseServices.getUserId())
                                    .collection("Saved")
                                    .doc(widget.saveId)
                                    .set({
                                  "id": widget.productId,
                                  "name": documentData['name'],
                                });
                                showFloatingFlushbar(
                                    context, "Product add to save");
                              } else {
                                showFloatingFlushbar(
                                    context, "Product existed!!!");
                              }
                              productName = [];
                            },
                            child: Container(
                              width: 65.0,
                              height: 65.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage(
                                  "assets/images/tab_saved.png",
                                ),
                                height: 22.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                print("${documentData['quantity']}");
                                await _firebaseServices.usersRef
                                    .doc(_firebaseServices.getUserId())
                                    .collection("Cart")
                                    .get()
                                    .then((querySnapshot) {
                                  if (querySnapshot.size == 0) {
                                    _firebaseServices.usersRef
                                        .doc(_firebaseServices.getUserId())
                                        .collection("Cart")
                                        .doc(widget.cartId)
                                        .set({
                                      "id": widget.productId,
                                      "name": documentData['name'],
                                      "size": _selectedProductSize,
                                      "quantity": _quantity,
                                      "price": documentData['price'],
                                      "images": documentData['images'][0]
                                    });
                                    showFloatingFlushbar(
                                        context, "Add to cart!!!");
                                  } else if (querySnapshot.size != 0) {
                                    List<String> a = [];
                                    a.addAll(
                                        querySnapshot.docs.map((e) => e.id));
                                    print(a);
                                    querySnapshot.docs
                                        .asMap()
                                        .forEach((index, result) {
                                      productName.add(querySnapshot.docs[index]
                                              ["id"] +
                                          querySnapshot.docs[index]["size"]);
                                    });
                                    print(productName);
                                    print(
                                        "${widget.productId + _selectedProductSize.toString()}");
                                    print(productName
                                        .where((i) =>
                                            i ==
                                            widget.productId +
                                                _selectedProductSize.toString())
                                        .isEmpty);
                                    if (productName
                                        .where((i) =>
                                            i ==
                                            widget.productId +
                                                _selectedProductSize.toString())
                                        .isEmpty) {
                                      setState(() {
                                        _quantity = _n;
                                      });
                                      _firebaseServices.usersRef
                                          .doc(_firebaseServices.getUserId())
                                          .collection("Cart")
                                          .doc(widget.cartId)
                                          .set({
                                        "id": widget.productId,
                                        "name": documentData['name'],
                                        "size": _selectedProductSize,
                                        "quantity": _quantity,
                                        "price": documentData['price']
                                      });
                                      showFloatingFlushbar(
                                          context, "Add to cart!!!");
                                    } else if (productName
                                            .where((i) =>
                                                i ==
                                                widget.productId +
                                                    _selectedProductSize
                                                        .toString())
                                            .isEmpty ==
                                        false) {
                                      querySnapshot.docs.forEach((element) {
                                        setState(() {
                                          _quantity = _n + element['quantity'];
                                        });
                                        _firebaseServices.usersRef
                                            .doc(_firebaseServices.getUserId())
                                            .collection("Cart")
                                            .doc(element.id)
                                            .update({
                                          "quantity": _quantity,
                                        });
                                      });
                                      showFloatingFlushbar(
                                          context, "Update product!!!");
                                    }
                                    productName = [];
                                    a = [];
                                  }
                                });
                              },
                              child: Container(
                                height: 65.0,
                                margin: EdgeInsets.only(
                                  left: 16.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add To Cart",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                      child: Container(
                        color: Color(0xFFf5f6f7),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 20),
                      child: Text(
                        "Similar Product",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Container(
                      child: Stack(
                        children: [
                          FutureBuilder<QuerySnapshot>(
                            future: _productsRef.where("price", isGreaterThan: price).get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Scaffold(
                                  body: Center(
                                    child: Text("Error: ${snapshot.error}"),
                                  ),
                                );
                              }
                              // Collection Data ready to display
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                // Display the data inside a list view
                                return GridView.count(
                                  physics: BouncingScrollPhysics(),
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  childAspectRatio: 1 / 1.25,
                                  children: snapshot.data.docs.map((document) {
                                      print(document.data()['price']);
                                    return Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(20),
                                                  child: FadeInImage(
                                                    height: 125,
                                                    width: 125,
                                                    fit: BoxFit.scaleDown,
                                                    image: NetworkImage(
                                                      document.data()['images']
                                                          [0],
                                                    ),
                                                    placeholder: AssetImage(
                                                      'assets/shared/loading.gif',
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  document.data()['name'],
                                                ),
                                                Text(
                                                  "\$${document.data()['price']}",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductPage(
                                                            productId:
                                                                document.id),
                                                  ));
                                            },
                                          ),
                                        )
                                      ],
                                    );
                                  }).toList(),
                                );
                              }
                              return Text("");
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }

              // Loading State
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Loading(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProductSize extends StatefulWidget {
  final List productSizes;
  final Function(String) onSelected;

  ProductSize({this.productSizes, this.onSelected});

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSizes.length; i++)
            GestureDetector(
              onTap: () {
                widget.onSelected("${widget.productSizes[i]}");
                setState(() {
                  _selected = i;
                });
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: _selected == i
                      ? Theme.of(context).accentColor
                      : Color(0xFFDCDCDC),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Text(
                  "${widget.productSizes[i]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _selected == i ? Colors.white : Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}


