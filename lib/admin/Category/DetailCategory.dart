import 'package:appecommerce/admin/Category/EditCategory.dart';
import 'file:///D:/Flutter/appecommerce/lib/admin/Product/product.dart';
import 'package:appecommerce/login/shared/constant.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DetailCategory extends StatefulWidget {
  final String CateID;
  DetailCategory({this.CateID});
  @override
  _DetailCategoryState createState() => _DetailCategoryState();
}

class _DetailCategoryState extends State<DetailCategory> {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Detail Category",
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
              onPressed: () {},
              icon: Icon(EvaIcons.search),
            ),
          ],
        ),
        body: Container(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.cateRef
                  .orderBy('id', descending: true)
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
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data.docs.map((document) {
                      return GestureDetector(
                        onTap: () {
                        },
                        child: Padding(
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
                                          color: Color(0xFFF5F6F9),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: FadeInImage(
                                          fit: BoxFit.scaleDown,
                                          image: NetworkImage(
                                            "${document.data()['img']}",
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
                                        "ID: ${document.data()['id']}",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        maxLines: 2,
                                      ),
                                      SizedBox(height: 10),
                                      Text.rich(
                                        TextSpan(
                                          text:
                                          "${document.data()['content']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: kPrimaryColor),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditCategory(CateID: document.id)));
                                  },
                                  child: Icon(EvaIcons.edit2Outline, color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _firebaseServices.cateRef
                                          .doc(document.id)
                                          .delete();
                                    });
                                  },
                                  child: Icon(EvaIcons.trash2Outline, color: Colors.white),
                                ),
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
