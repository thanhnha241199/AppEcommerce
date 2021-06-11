//Library
import 'package:flutter/material.dart';

//Package
import 'package:appecommerce/size_config.dart';

class SmallBanner extends StatefulWidget {
  @override
  _SmallBannerState createState() => _SmallBannerState();
}

class _SmallBannerState extends State<SmallBanner> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              "assets/images/banners/smallbanners/smallbanner1.jpg",
              height: getProportionateScreenHeight(100.0),
              fit: BoxFit.scaleDown,),
          Image.asset(
              "assets/images/banners/smallbanners/smallbanner2.jpg",
              height: getProportionateScreenHeight(120.0),
              fit: BoxFit.scaleDown),
          Image.asset(
              "assets/images/banners/smallbanners/smallbanner3.jpg",
              height: getProportionateScreenHeight(100.0),
              fit: BoxFit.scaleDown),
        ],
      ),
    );
  }
}
