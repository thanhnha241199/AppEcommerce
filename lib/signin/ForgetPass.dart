import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/signin/custom_btn.dart';
import 'package:appecommerce/signin/custom_input.dart';
import 'package:appecommerce/signin/login_page.dart';
import 'package:appecommerce/widgets/default_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: 260.0,
              height: 230.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          // padding: new EdgeInsets.all(10.0),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              'Login Error',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // dialog centre
                  new Expanded(
                    child: Center(
                        child: Text(error,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        )),
                    flex: 2,
                  ),
                  new Expanded(
                    child: new Container(
                      padding: new EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: new Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  // Default Form Loading State

  bool _ForgetLoading = false;
  FocusNode _forgetFocusNode;
  // Form Input Field Values
  String _forgetEmail = "";
  @override
  void initState() {
    _forgetFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _forgetFocusNode.dispose();
    super.dispose();
  }
  @override
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 60.0,
                ),
                child: Text(
                  "Welcome User,\nYour Forget Password",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -15),
                      blurRadius: 20,
                      color: Color(0xFFDADADA).withOpacity(0.15),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        CustomInput(
                          hintText: "Email...",
                          onChanged: (value) {
                            _forgetEmail = value;
                            if(_forgetEmail.isEmpty){
                              _alertDialogBuilder("Nhap email");
                            }
                          },
                          onSubmitted: (value) {
                            _forgetFocusNode.requestFocus();
                            if(value.isEmpty){
                              _alertDialogBuilder("Nhap email");
                            }
                          },
                        ),
                        CustomBtn(
                          text: "Login",
                          onPressed: (){
                            if(_forgetEmail.isEmpty){
                              _alertDialogBuilder("Nhap email");
                            } else{
                              setState(() {
                                resetPassword(_forgetEmail);
                                _ForgetLoading=true;
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SuccessEmail()));
                              });
                            }
                          },
                          isLoading: _ForgetLoading,
                        )
                      ],
                    ),
                    SizedBox(height: 100,),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16.0,
                      ),
                      child: CustomBtn(
                        text: "Back To Login",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        outlineBtn: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class SuccessEmail extends StatefulWidget {
  @override
  _SuccessEmailState createState() => _SuccessEmailState();
}

class _SuccessEmailState extends State<SuccessEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration:
                    BoxDecoration(color: Colors.white),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 70,
                          child: Container(
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 350,
                          child: Image.asset(
                            "assets/images/success.png",
                            height: 350,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: Container(
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                "Check your email!",
                                style: TextStyle(
                                  color: Color(0xFF67778E),
                                  fontFamily:
                                  'Roboto-Light.ttf',
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.all(20.0),
                                child: SizedBox(
                                  width: 190,
                                  child: DefaultButton(
                                    text: "Login",
                                    press: () {
                                      Navigator.pop(context);
                                      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => LoginPage()));
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ))
              ]),
        )
    );
  }
}