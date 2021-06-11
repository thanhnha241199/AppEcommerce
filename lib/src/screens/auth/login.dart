import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/signin/custom_btn.dart';
import 'package:appecommerce/signin/custom_input.dart';
import 'package:appecommerce/src/services/auth_controller.dart';
import 'package:appecommerce/src/services/sign_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginPage extends StatelessWidget {
  final AuthController authController = AuthController.to;
  String _loginEmail = "";
  String _loginPassword = "";
  FocusNode _passwordFocusNode;
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
                          controller: authController.emailController,
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
                          controller: authController.passwordController,
                          hintText: "Password...",
                          onChanged: (value) {
                            _loginPassword = value;
                          },
                          focusNode: _passwordFocusNode,
                          isPasswordField: true,
                          onSubmitted: (value) {
                           // _submitForm();
                          },
                        ),
                        CustomBtn(
                          text: "Login",
                          onPressed: () {
                            //_submitForm();
                          },

                          //isLoading: _loginFormLoading,
                        )
                      ],
                    ),
                    FlatButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ForgetPass()));
                      },
                      child: Text("Forge1t password?"),
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => RegisterPage()),
                          // );
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
                          onPressed: () {
                            authController.handleSignIn(SignInType.GOOGLE);
                            },
                          child: Text("Google"),
                        ),
                        FlatButton(
                          onPressed: () {
                            // facebookSignInMethod();
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