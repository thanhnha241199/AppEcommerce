//Library
import 'package:flutter/material.dart';

//Package


class SmallBanner extends StatefulWidget {
  @override
  _SmallBannerState createState() => _SmallBannerState();
}

class _SmallBannerState extends State<SmallBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                "assets/images/smallbanners/smallbanner1.jpg",
                height: 80,),
            Image.asset(
                "assets/images/smallbanners/smallbanner2.jpg"),
            Image.asset(
                "assets/images/smallbanners/smallbanner3.jpg",
                height: 80),
          ],
        ),
      ),
    );
  }
}
