import 'package:appecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'CM Sans Serif',
  fontSize: getProportionateScreenWidth(26.0),
  height: getProportionateScreenWidth(1.2),
);

final kSubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: getProportionateScreenWidth(18.0),
  height: getProportionateScreenWidth(1.2),
);

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8.0)),
      height: getProportionateScreenHeight(8.0),
      width: isActive
          ? getProportionateScreenHeight(24.0)
          : getProportionateScreenHeight(16.0),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenWidth(40.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      Get.offNamed("/BottomNav");
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(20.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: getProportionateScreenHeight(600.0),
                  child: PageView(
                    physics: BouncingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding:
                        EdgeInsets.all(getProportionateScreenWidth(40.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding0.png',
                                ),
                                height: getProportionateScreenHeight(250.0),
                                width: getProportionateScreenWidth(250.0),
                              ),
                            ),
                            SizedBox(
                                height: getProportionateScreenHeight(30.0)),
                            Text(
                              'Connect people around\n the world',
                              style: kTitleStyle,
                            ),
                            SizedBox(
                                height: getProportionateScreenHeight(30.0)),
                            Text(
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.all(getProportionateScreenWidth(40.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding1.png',
                                ),
                                height: getProportionateScreenHeight(250.0),
                                width: getProportionateScreenWidth(250.0),
                              ),
                            ),
                            SizedBox(
                                height: getProportionateScreenHeight(30.0)),
                            Text(
                              'Live your life smarter\nwith us!',
                              style: kTitleStyle,
                            ),
                            SizedBox(
                                height: getProportionateScreenHeight(15.0)),
                            Text(
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.all(getProportionateScreenWidth(40.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding2.png',
                                ),
                                height: getProportionateScreenHeight(250.0),
                                width: getProportionateScreenWidth(250.0),
                              ),
                            ),
                            SizedBox(
                                height: getProportionateScreenHeight(30.0)),
                            Text(
                              'Get a new experience\nof imagination',
                              style: kTitleStyle,
                            ),
                            SizedBox(
                                height: getProportionateScreenHeight(15.0)),
                            Text(
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: getProportionateScreenWidth(20.0),
                            ),
                          ),
                          SizedBox(
                              width: getProportionateScreenWidth(10.0)),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: getProportionateScreenWidth(20),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
        height: getProportionateScreenHeight(85.0),
        width: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            Get.offNamed("/BottomNav");
          },
          child: Center(
            child: Text(
              'Get started',
              style: TextStyle(
                color: Color(0xFF5B16D0),
                fontSize: getProportionateScreenWidth(20.0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      )
          : Text(''),
    );
  }
}
