import 'package:appecommerce/constants.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:appecommerce/src/models/review.dart';

class Review extends StatefulWidget {
  String productid;
  Review({this.productid});
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  String productid;
  FirebaseServices _firebaseServices = FirebaseServices();
  final _formKey = GlobalKey<FormState>();
  double _rating;
  double _userRating = 3.0;
  int _ratingBarMode = 1;
  bool _isVertical = false;
  String comment;
  IconData _selectedIcon;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    final CollectionReference _productsRef =
    FirebaseFirestore.instance.collection("Products");
    setState(() {
      productid=widget.productid;
    });
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Review",
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
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        width: 300,
                        height: 300,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10,),
                            Center(
                              child: Text("Review",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                            ),
                            Center(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(height: 50,),
                                    _ratingBar(_ratingBarMode),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (value){
                                          comment = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 40,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          RaisedButton(
                                            child: Text("Submit"),
                                            onPressed: () {
                                  setState(() {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                    }
                                    List yourItemList = [];
                                    for (int i = 0; i < 2; i++)
                                      yourItemList.add({
                                        "comment": comment,
                                        "rating": _rating,
                                      });
                                    _firebaseServices.productsRef
                                        .doc(widget.productid)
                                        .update({
                                      "Review": FieldValue.arrayUnion(yourItemList),
                                    }).whenComplete(() => Get.back());
                                    review = [];
                                    getData();
                                  });
                                            },
                                          ),
                                          RaisedButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            icon: Icon(EvaIcons.plusOutline),
            iconSize: 28,
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(productid).get(),
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
                return documentData['Review'].length ==0 ?Text("Chua co danh gia "): ListView(
                  physics: BouncingScrollPhysics(),
                  children: new List.generate(documentData['Review'].length, (index) => new CustomReview(comment: documentData['Review'][index]['comment'], rating: documentData['Review'][index]['rating'].toDouble(),)),
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
  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 35.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      default:
        return Container();
    }
  }
}

class CustomReview extends StatelessWidget {
  String comment;
  double rating;

  CustomReview({this.comment, this.rating});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 60,
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
                        "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png",
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
                    "Name: Nguoi danh gia",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16),
                    maxLines: 2,
                  ),
                  SizedBox(height: 10),
                  Text(
                    rating.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16),
                    maxLines: 2,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80.0),
            child: Text(comment),
          )
        ],
      ),
    );
  }
}

