import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserModel {
  String uid;
  String displayName;
  String avatarUrl;

  UserModel(this.uid, {this.displayName, this.avatarUrl});
}

class ManageProfileInformationWidget extends StatefulWidget {
  final UserModel currentUser;

  ManageProfileInformationWidget({this.currentUser});

  @override
  _ManageProfileInformationWidgetState createState() =>
      _ManageProfileInformationWidgetState();
}

class _ManageProfileInformationWidgetState
    extends State<ManageProfileInformationWidget> {
  var _displayNameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _repeatPasswordController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  bool checkCurrentPasswordValid = true;

  @override
  void initState() {
    _displayNameController.text = widget.currentUser.displayName;
    super.initState();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Username"),
              controller: _displayNameController,
            ),
            SizedBox(height: 20.0),
            Flexible(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Manage Password",
                      style: Theme.of(context).textTheme.display1,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Password",
                        errorText: checkCurrentPasswordValid
                            ? null
                            : "Please double check your current password",
                      ),
                      controller: _passwordController,
                    ),
                    TextFormField(
                      decoration:
                      InputDecoration(hintText: "New Password"),
                      controller: _newPasswordController,
                      obscureText: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Repeat Password",
                      ),
                      obscureText: true,
                      controller: _repeatPasswordController,
                      validator: (value) {
                        return _newPasswordController.text == value
                            ? null
                            : "Please validate your entered password";
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () async {
                var userController = locator.get<UserController>();

                if (widget.currentUser.displayName !=
                    _displayNameController.text) {
                  var displayName = _displayNameController.text;
                }

                checkCurrentPasswordValid =
                await userController.validateCurrentPassword(
                    _passwordController.text);

                setState(() {});

                if (_formKey.currentState.validate() &&
                    checkCurrentPasswordValid) {
                  userController.updateUserPassword(
                      _newPasswordController.text);
                  Navigator.pop(context);
                }
              },
              child: Text("Save Profile"),
            )
          ],
        ),
      ),
    );
  }
}
final locator = GetIt.instance;

class UserController {
  UserModel _currentUser;
  AuthRepo _authRepo = locator.get<AuthRepo>();
  Future init;

  UserController() {
    init = initUser();
  }

  Future<UserModel> initUser() async {
    _currentUser = await _authRepo.getUser();
    return _currentUser;
  }

  UserModel get currentUser => _currentUser;

  Future<void> signInWithEmailAndPassword(
      {String email, String password}) async {
    _currentUser = await _authRepo.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<bool> validateCurrentPassword(String password) async {
    return await _authRepo.validatePassword(password);
  }

  void updateUserPassword(String password) {
    _authRepo.updatePassword(password);
  }
}
class AuthRepo {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthRepo();

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleUser =
    await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final AuthCredential credential =
    GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  Future<UserModel> signInWithEmailAndPassword(
      {String email, String password}) async {
    var authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return UserModel(authResult.user.uid,
        displayName: authResult.user.displayName);
  }

  Future<UserModel> getUser() async {
    var firebaseUser = await _auth.currentUser;
    return UserModel(firebaseUser?.uid,
        displayName: firebaseUser?.displayName);
  }


  Future<bool> validatePassword(String password) async {
    var firebaseUser = await _auth.currentUser;

    var authCredentials = EmailAuthProvider.getCredential(
        email: firebaseUser.email, password: password);
    try {
      var authResult = await firebaseUser
          .reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updatePassword(String password) async {
    var firebaseUser = await _auth.currentUser;
    firebaseUser.updatePassword(password);
  }
}

