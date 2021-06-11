import 'package:appecommerce/admin/adminpage.dart';
import 'package:appecommerce/src/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:appecommerce/src/pages/main/main_page.dart';
import 'package:get/get.dart';

import '../route.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //initialRoute: "/BottomNav",
      //getPages: routes(),
      home: Text("aaaa"),
    );
  }
}
