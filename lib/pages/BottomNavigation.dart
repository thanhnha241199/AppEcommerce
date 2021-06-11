import 'package:appecommerce/pages/HomePage.dart';
import 'package:appecommerce/pages/Notification.dart';
import 'package:appecommerce/pages/Search.dart';
import 'package:appecommerce/pages/UserProfile.dart';
import 'package:appecommerce/pages/morecategories.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

class BottomNav extends StatefulWidget {
//  BottomNav({Key key}) : super(key: key);

  String user;
  BottomNav({this.user,});
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.w700, fontFamily: 'CM Sans Serif',height: 1.5);
  // static List<Widget> _widgetOptions = <Widget>[
  //   HomePage(),
  //   MoreCategories(),
  //   Search(),
  //   Noctics(),
  //   UserProfile(),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     _showItemDialog(message);
    //   },
    //   onBackgroundMessage: myBackgroundMessageHandler,
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     _navigateToItemDetail(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     _navigateToItemDetail(message);
    //   },
    // );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(
    //         sound: true, badge: true, alert: true, provisional: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });
    // _firebaseMessaging.getToken().then((String token) {
    //   assert(token != null);
    //   print("Push Messaging token: $token");
    // });
    // _firebaseMessaging.subscribeToTopic("matchscore");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: <Widget>[
          HomePage(),
          MoreCategories(),
          Search(),
          Noctics(),
          UserProfile(user: widget.user,),
        ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: BottomNavigationBar(
            unselectedItemColor: Colors.black87,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.homeOutline),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.gridOutline),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.bookmarkOutline),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.bellOutline),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.personOutline),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
