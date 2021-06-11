import 'file:///D:/Flutter/appecommerce/lib/admin/Product/product.dart';
import 'package:appecommerce/admin/User/AddUser.dart';
import 'package:appecommerce/admin/User/EditUser.dart';
import 'package:appecommerce/login/shared/constant.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserAdmin extends StatefulWidget {
  final String uid;
  UserAdmin({this.uid});
  @override
  _UserAdminState createState() => _UserAdminState();
}

class _UserAdminState extends State<UserAdmin> {
  FirebaseServices _firebaseServices = FirebaseServices();
  final CollectionReference _productsRef =
  FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User",
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
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef
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
                  print("${snapshot.data.size}");
                  // Display the data inside a list view
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data.docs.map((document) {
                      print("${document.id}");
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${document.id.substring(0,20)}....",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        maxLines: 2,
                                      ),
                                      SizedBox(height: 10),
                                      Text.rich(
                                        TextSpan(
                                          text: "${document.data()['name']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: kPrimaryColor),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text.rich(
                                        TextSpan(
                                          text:
                                          "${document.data()['phone']}",
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
                                                EditUser()));
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
                                      _firebaseServices.usersRef
                                          .doc(_firebaseServices.getUserId())
                                          .collection("Cart")
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddUser()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
