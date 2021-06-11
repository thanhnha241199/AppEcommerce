
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/signin/custom_btn.dart';
import 'package:appecommerce/signin/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final SnackBar _snackBarRegister = SnackBar(
    content: Text("Product added to card"),
  );
  // Build an alert dialog to display some errors.
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

  // Create a new user account
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      await _firebaseServices.usersRef
          .doc(_firebaseServices.getUserId())
         .set({
        "name": _registerName,
        "phone": _registerPhone,
      });
      return null;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    // Set the form to loading state
    setState(() {
      _registerFormLoading = true;
    });

    // Run the create account method
    String _createAccountFeedback = await _createAccount();

    // If the string is not null, we got error while create account.
    if(_createAccountFeedback != null && _registerName!= null && _registerPhone!=null) {
      _alertDialogBuilder(_createAccountFeedback);

      // Set the form to regular state [not loading].
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      // The String was null, user is logged in.
      Navigator.pop(context);
    }
  }

  // Default Form Loading State
  bool _registerFormLoading = false;

  // Form Input Field Values
  String _registerEmail = "";
  String _registerPassword = "";
  String _registerName = "";
  String _registerPhone = "";

  // Focus Node for input fields
  FocusNode _passwordFocusNode;
  FocusNode _nameFocusNode;
  FocusNode _phoneFocusNode;
  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }
  FirebaseServices _firebaseServices = FirebaseServices();
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
                  "Create A New Account",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
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
                            _registerEmail = value;
                          },
                          onSubmitted: (value) {
                            _passwordFocusNode.requestFocus();
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        CustomInput(
                          hintText: "Password...",
                          onChanged: (value) {
                            _registerPassword = value;
                          },
                          focusNode: _passwordFocusNode,
                          isPasswordField: true,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomInput(
                          hintText: "Name...",
                          onChanged: (value) {
                            _registerName = value;
                          },
                          focusNode: _nameFocusNode,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomInput(
                          hintText: "Phone...",
                          onChanged: (value) {
                            _registerPhone = value;
                          },
                          focusNode: _phoneFocusNode,
                          textInputType: TextInputType.number,
                          onSubmitted: (value) {
                            _submitForm();
                          },
                        ),
                        CustomBtn(
                          text: "Create New Account",
                          onPressed: () async {
                            Scaffold.of(context).showSnackBar(_snackBarRegister);
                            _submitForm();
                          },
                          isLoading: _registerFormLoading,
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10.0,
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
