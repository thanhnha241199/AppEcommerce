import 'package:appecommerce/pages/BottomNavigation.dart';
import 'package:appecommerce/pages/HomePage.dart';
import 'package:appecommerce/signin/cart_page.dart';
import 'package:appecommerce/signin/login_page.dart';
import 'package:appecommerce/signin/register_page.dart';
import 'package:appecommerce/src/screens/intoscreen.dart';
import 'package:appecommerce/src/screens/landingpage.dart';
import 'package:appecommerce/src/screens/splashscreen.dart';
import 'package:get/get.dart';

routes() => [
  GetPage(name: "/", page: () => Splash()),
  GetPage(name: "/CartPage", page: () => CartPage()),
  GetPage(name: "/HomePage", page: () => HomePage()),
  GetPage(name: "/LandingPage", page: () => LandingPage()),
  GetPage(name: "/Onbroarding", page: () => OnboardingScreen()),
  GetPage(name: "/BottomNav", page: () => BottomNav()),
  GetPage(name: "/Login", page: () => LoginPage()),
  GetPage(name: "/Register", page: () => RegisterPage()),
  GetPage(name: "/CartPage", page: () => CartPage()),
  GetPage(name: "/CartPage", page: () => CartPage()),
  GetPage(name: "/CartPage", page: () => CartPage()),
  GetPage(name: "/CartPage", page: () => CartPage()),
];
