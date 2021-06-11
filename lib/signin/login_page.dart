import 'package:appecommerce/pages/BottomNavigation.dart';
import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/pages/UserProfile.dart';
import 'package:appecommerce/signin/ForgetPass.dart';
import 'package:appecommerce/signin/custom_btn.dart';
import 'package:appecommerce/signin/custom_input.dart';
import 'package:appecommerce/signin/register_page.dart';
import 'package:appecommerce/src/screens/landingpage.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FacebookLogin _facebookLogin = FacebookLogin();
  FirebaseAuth _auth = FirebaseAuth.instance;
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
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
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
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // dialog centre
                  new Expanded(
                    child: Center(
                        child: Text(
                      error,
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
                          borderRadius: BorderRadius.circular(20)),
                      child: GestureDetector(
                        onTap: () {
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
        });
  }
  // void saveUser(UserCredential user) async {
  //   await FireStoreUser().addUserToFireStore(UserModel(
  //     userId: user.user.uid,
  //     email: user.user.email,
  //     name: name == null ? user.user.displayName : name,
  //     pic: '',
  //   ));
  // }
  void facebookSignInMethod() async {
    FacebookLoginResult result = await _facebookLogin.logIn(['email']);

    final accessToken = result.accessToken.token;

    if (result.status == FacebookLoginStatus.loggedIn) {
      final faceCredential = FacebookAuthProvider.credential(accessToken);
      Get.snackbar("Signing Up", "Loading",
          //progressIndicatorBackgroundColor: Colors.black,
          backgroundColor: Colors.white,
          showProgressIndicator: true,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(minutes: 2));
      await _auth.signInWithCredential(faceCredential).whenComplete(() => Get.offAllNamed("/LandingPage"));
      //     .then((user) async {
      //    //saveUser(user);
      // });
    }
  }
  // Create a new user account
  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
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
      _loginFormLoading = true;
    });

    // Run the create account method
    String _loginFeedback = await _loginAccount().whenComplete(() => Get.offAllNamed("/LandingPage"));

    // If the string is not null, we got error while create account.
    if (_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);

      // Set the form to regular state [not loading].
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  // Default Form Loading State
  bool _loginFormLoading = false;

  // Form Input Field Values
  String _loginEmail = "";
  String _loginPassword = "";

  // Focus Node for input fields
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
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
                  top: 50.0,
                  bottom: 10
                ),
                child: Text(
                  "Welcome User,\nLogin to your account",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
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
                            _loginEmail = value;
                          },
                          onSubmitted: (value) {
                            _passwordFocusNode.requestFocus();
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        CustomInput(
                          hintText: "Password...",
                          onChanged: (value) {
                            _loginPassword = value;
                          },
                          focusNode: _passwordFocusNode,
                          isPasswordField: true,
                          onSubmitted: (value) {
                            _submitForm();
                          },
                        ),
                        CustomBtn(
                          text: "Login",
                          onPressed: () {
                            _submitForm();
                          },

                          isLoading: _loginFormLoading,
                        )
                      ],
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetPass()));
                      },
                      child: Text("Forget password?"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: CustomBtn(
                        text: "Create New Account",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        },
                        outlineBtn: true,
                      ),
                    ),
                    Text("Or"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () => googleSignIn().whenComplete(() async {
                            GoogleSignInAccount _currentUser;
                            Get.offAllNamed("/LandingPage");
                          }),
                          child: Text("Google"),
                        ),
                        FlatButton(
                          onPressed: () {
                            facebookSignInMethod();
                          },
                          child: Text("Facebook"),
                        ),
                      ],
                    )
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
FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();

// a simple sialog to be visible everytime some error occurs
showErrDialog(BuildContext context, String err) {
  // to hide the keyboard, if it is still p
  FocusScope.of(context).requestFocus(new FocusNode());
  return showDialog(
    context: context,
    child: AlertDialog(
      title: Text("Error"),
      content: Text(err),
      actions: <Widget>[
        OutlineButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ],
    ),
  );
}

// many unhandled google error exist
// will push them soon
Future<bool> googleSignIn() async {
  GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    GoogleAuthCredential  credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    Get.snackbar("Signing Up", "Loading",
        //progressIndicatorBackgroundColor: Colors.black,
        backgroundColor: Colors.white,
        showProgressIndicator: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(minutes: 2));
    UserCredential result = await auth.signInWithCredential(credential);

    User user = await auth.currentUser;
    print(user.uid);

    return Future.value(true);
  }
}

// instead of returning true or false
// returning user to directly access UserID
Future<User> signin(
    String email, String password, BuildContext context) async {
  try {
    UserCredential result =
    await auth.signInWithEmailAndPassword(email: email, password: email);
    User user = result.user;
    // return Future.value(true);
    return Future.value(user);
  } catch (e) {
    // simply passing error code as a message
    print(e.code);
    switch (e.code) {
      case 'ERROR_INVALID_EMAIL':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_WRONG_PASSWORD':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_USER_NOT_FOUND':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_USER_DISABLED':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        showErrDialog(context, e.code);
        break;
    }
    // since we are not actually continuing after displaying errors
    // the false value will not be returned
    // hence we don't have to check the valur returned in from the signin function
    // whenever we call it anywhere
    return Future.value(null);
  }
}

// change to Future<FirebaseUser> for returning a user
Future<User> signUp(
    String email, String password, BuildContext context) async {
  try {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: email);
    User user = result.user;
    return Future.value(user);
    // return Future.value(true);
  } catch (error) {
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        showErrDialog(context, "Email Already Exists");
        break;
      case 'ERROR_INVALID_EMAIL':
        showErrDialog(context, "Invalid Email Address");
        break;
      case 'ERROR_WEAK_PASSWORD':
        showErrDialog(context, "Please Choose a stronger password");
        break;
    }
    return Future.value(null);
  }
}

Future<bool> signOutUser() async {
  User user = await auth.currentUser;
  print(user.providerData[1].providerId);
  if (user.providerData[1].providerId == 'google.com') {
    await gooleSignIn.disconnect();
  }
  await auth.signOut();
  return Future.value(true);
}
