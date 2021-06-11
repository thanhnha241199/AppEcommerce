import 'package:appecommerce/login/blocs/authentication_bloc.dart';
import 'package:appecommerce/login/blocs/login_bloc.dart';
import 'package:appecommerce/login/events/authentication_event.dart';
import 'package:appecommerce/login/events/login_event.dart';
import 'package:appecommerce/login/pages/buttons/google_login_button.dart';
import 'package:appecommerce/login/pages/buttons/loading_dialog.dart';
import 'package:appecommerce/login/pages/buttons/login_button.dart';
import 'package:appecommerce/login/pages/buttons/msg_dilog.dart';
import 'package:appecommerce/login/pages/buttons/register_user_button.dart';
import 'package:appecommerce/login/repositories/user_repository.dart';
import 'package:appecommerce/login/states/authentication_state.dart';
import 'package:appecommerce/login/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:appecommerce/login/pages/buttons/msg_dilog.dart';

class LoginPage extends StatefulWidget {
  final UserRepository _userRepository;
  //constructor
  LoginPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwodController = TextEditingController();
  LoginBloc _loginBloc;
  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(() {
      //when email is changed,this function is called !
      _loginBloc.add(LoginEventEmailChanged(email: _emailController.text));
    });
    _passwodController.addListener(() {
      //when password is changed,this function is called !
      _loginBloc
          .add(LoginEventPasswordChanged(password: _passwodController.text));
    });
    BlocBuilder<LoginBloc, LoginState>(
        builder: (context, loginState) {
    if (loginState.isFailure) {
    LoadingDialog.hideLoadingDialog(context);
    MsgDialog.showMsgDialog(context, "Sign in","Login Failed");
    print('Login failed');
    super.initState();
    } else if (loginState.isSubmitting) {
    LoadingDialog.showLoadingDialog(context, "Submitting......");
    print('Logging in');
    } else if (loginState.isSuccess) {
    //add event: AuthenticationEventLoggedIn ?
    BlocProvider.of<AuthenticationBloc>(context)
        .add(AuthenticationEventLoggedIn());
    LoadingDialog.hideLoadingDialog(context);
    }
    });
  }
  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwodController.text.isNotEmpty;
  bool isLoginButtonEnabled(LoginState loginState) =>
      loginState.isValidEmailAndPassword && isPopulated &&
          !loginState.isSubmitting;
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, loginState) {
          if (loginState.isFailure) {
            LoadingDialog.hideLoadingDialog(context);
            print('Login failed');
          } else if (loginState.isSubmitting) {
            print('Logging in');
          } else if (loginState.isSuccess) {
            //add event: AuthenticationEventLoggedIn ?
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationEventLoggedIn());
            LoadingDialog.hideLoadingDialog(context);
          }
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Form(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                    ),
                    Center(
                      child: Text("Login", style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30
                      ),),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.email),
                          labelText: 'Enter your email'),
                      keyboardType: TextInputType.emailAddress,
                      autovalidate: true,
                      autocorrect: false,
                      validator: (_) {
                        return loginState.isValidEmail
                            ? null
                            : 'Invalid email format';
                      },
                    ),
                    TextFormField(
                        controller: _passwodController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Enter password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme
                                  .of(context)
                                  .primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !_passwordVisible,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return loginState.isValidEmail
                              ? null
                              : 'Invalid password format';
                        }),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          LoginButton(
                            onPressed: isLoginButtonEnabled(loginState)
                              ? _onLoginEmailAndPassword
                              : null,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          GoogleLoginButton(),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          RegisterUserButton(
                            userRepository: _userRepository,
                          )
                        ],
                      ), // a login button here
                    ),
                    //Add "register" button here, to "navigate" to "Register Page"
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onLoginEmailAndPassword() {
    _loginBloc.add(LoginEventWithEmailAndPasswordPressed(
        email: _emailController.text, password: _passwodController.text));
    LoadingDialog.showLoadingDialog(context, "Loading......");
  }
}