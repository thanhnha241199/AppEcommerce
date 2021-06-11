import 'package:appecommerce/admin/adminpage.dart';
import 'package:appecommerce/pages/BottomNavigation.dart';
import 'package:appecommerce/pages/HomePage.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/signin/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${streamSnapshot.error}"),
                  ),
                );
              }


              if (streamSnapshot.connectionState == ConnectionState.active) {
                User _user = streamSnapshot.data;
                if (_user == null) {
                  return BottomNav(user: null);
                } else if(FirebaseAuth.instance.currentUser.uid == "zjgaClsqF0VAJOQwaaDQMDJYTe33") {
                  return AdminPage();
                } else if(FirebaseAuth.instance.currentUser.uid != "zjgaClsqF0VAJOQwaaDQMDJYTe33"){
                  return BottomNav(user: FirebaseAuth.instance.currentUser.uid);
                }
              }

              // Checking the auth state - Loading
              return Center(
                  // child: Text(
                  //   "Checking Authentication...",
                  //   style: Constants.regularHeading,
                  // ),
                );
            },
          );
        }

        // Connecting to Firebase - Loading
        return Center(
            // child: Text(
            //   "Initialization App...",
            //   style: Constants.regularHeading,
            // ),
          );
      },
    );
  }
}