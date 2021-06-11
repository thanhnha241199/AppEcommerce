import 'package:appecommerce/cart/cart_screen.dart';
import 'package:appecommerce/pages/DetailProfile.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/pages/QuanLyDonHang.dart';
import 'package:appecommerce/pages/Search.dart';
import 'package:appecommerce/signin/blurdialog.dart';
import 'package:appecommerce/signin/login_page.dart';
import 'package:appecommerce/signin/saved_tab.dart';
import 'package:appecommerce/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
class UserProfile extends StatefulWidget {
  String user ;
  UserProfile({this.user});
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => CartScreen()));
            },
            icon: Icon(EvaIcons.settingsOutline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            widget.user==null?  GestureDetector(
              onTap: () {
                Get.offAllNamed("/Login");
              },
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0),
                title: Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Login/Register",
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundImage:
                    AssetImage('assets/mainmenu/icon2.png'),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ): GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage()));
              },
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0),
                title: Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(widget.user,
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundImage:
                    AssetImage('assets/mainmenu/icon2.png'),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                    height: 60,
                    child: Stack(children: <Widget>[
                      GestureDetector(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8),
                            title: Text("Quan ly don hang"),
                            leading: Icon(
                              EvaIcons.archiveOutline,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ManageOrder()));
                          }),
                      SizedBox(
                        height: getProportionateScreenHeight(10.0),
                        child: Container(
                          color: Color(0xFFf5f6f7),
                        ),
                      ),
                      //replyNotification(),
                    ])),
                Container(
                    height: 60,
                    child: Stack(children: <Widget>[
                      GestureDetector(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8),
                            title: Text("Don the nap"),
                            leading: Icon(
                              EvaIcons.browserOutline,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          onTap: () {}),
                      Divider(),
                      //replyNotification(),
                    ])),
                Container(
                    height: 60,
                    child: Stack(children: <Widget>[
                      GestureDetector(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8),
                            title: Text("Mua lan nua"),
                            leading: Icon(
                              EvaIcons.flip2Outline,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          onTap: () {}),
                      SizedBox(
                        height: getProportionateScreenHeight(10.0),
                        child: Container(
                          color: Color(0xFFf5f6f7),
                        ),
                      ),
                      //replyNotification(),
                    ])),
                Container(
                    height: 60,
                    child: Stack(children: <Widget>[
                      GestureDetector(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8),
                            title: Text("Da thich"),
                            leading: Icon(
                              EvaIcons.heartOutline,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SavedTab()));
                          }),
                      Divider(),
                      //replyNotification(),
                    ])),
                Container(
                    height: 60,
                    child: Stack(children: <Widget>[
                      GestureDetector(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8),
                            title: Text("Vua xem"),
                            leading: Icon(
                              EvaIcons.loaderOutline,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          onTap: () {}),
                      Divider(),
                      //replyNotification(),
                    ])),
                Container(
                    height: 60,
                    child: Stack(children: <Widget>[
                      GestureDetector(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8),
                            title: Text("Vi airpay"),
                            leading: Icon(
                              EvaIcons.toggleRightOutline,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          onTap: () {}),
                      Divider(),
                      //replyNotification(),
                    ])),
                Container(
                    height: 60,
                    child: Stack(children: <Widget>[
                      GestureDetector(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8),
                            title: Text("Change Password"),
                            leading: Icon(
                              EvaIcons.toggleLeftOutline,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          onTap: () {}),
                      Divider(),
                      //replyNotification(),
                    ])),
                    widget.user==null ?Text(""): Container(
                    height: 60,
                    child: Stack(children: <Widget>[
                      GestureDetector(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8),
                            title: Text("Logout"),
                            leading: Icon(
                              EvaIcons.logOut,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          onTap: () {
                            _showDialog(context);
                          }),
                      SizedBox(
                        height: getProportionateScreenHeight(10.0),
                        child: Container(
                          color: Color(0xFFf5f6f7),
                        ),
                      ),
                    ])),
              ],
            )
          ],
        ),
      ),
    );
  }
  void test(){
    setState(() {
      FirebaseAuth.instance.signOut();
      final gooleSignIn = GoogleSignIn();
      gooleSignIn.signOut();
      Get.snackbar("Logout!!!!!!", "Loading",
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(milliseconds: 3000));
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
  }
  _showDialog(BuildContext context)
  {

    VoidCallback continueCallBack = ()  =>{
      test(),
    };
    BlurryDialog  alert = BlurryDialog("Abort","Are you sure you want to abort this operation?",continueCallBack);


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
