import 'package:appecommerce/login/blocs/authentication_bloc.dart';
import 'package:appecommerce/login/blocs/register_bloc.dart';
import 'package:appecommerce/login/events/authentication_event.dart';
import 'package:appecommerce/login/events/register_event.dart';
import 'package:appecommerce/login/pages/buttons/loading_dialog.dart';
import 'package:appecommerce/login/pages/buttons/msg_dilog.dart';
import 'package:appecommerce/login/repositories/user_repository.dart';
import 'package:appecommerce/login/states/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'buttons/register_button.dart';

class RegisterPage extends StatefulWidget {
  final UserRepository _userRepository;

  RegisterPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  UserRepository get _userRepository => widget._userRepository;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isValidEmailAndPassword && isPopulated
        && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(() {
      //when email is changed,this function is called !
      _registerBloc.add(RegisterEventEmailChanged(email: _emailController.text));
    });
    _passwordController.addListener(() {
      //when password is changed,this function is called !
      _registerBloc
          .add(
          RegisterEventPasswordChanged(password: _passwordController.text));
    });
    BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, registerState) {
          if (registerState.isFailure) {
            LoadingDialog.hideLoadingDialog(context);
            // MsgDialog.showMsgDialog(context, "Sign in","Login Failed");
            Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text('Login fail!'),
            ));
            super.initState();
          } else if (registerState.isSubmitting) {
            print('Registration in progress...');
            LoadingDialog.showLoadingDialog(context, "Submitting......");
          } else if (registerState.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationEventRegister());
            LoadingDialog.hideLoadingDialog(context);
          }});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(userRepository: _userRepository),
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, registerState) {
            if (registerState.isFailure) {
              LoadingDialog.hideLoadingDialog(context);
             // MsgDialog.showMsgDialog(context, "Sign in","Login Failed");
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: new Text('Login fail!'),
              ));
            } else if (registerState.isSubmitting) {
              print('Registration in progress...');
              LoadingDialog.showLoadingDialog(context, "Submitting......");
            } else if (registerState.isSuccess) {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationEventRegister());
              LoadingDialog.hideLoadingDialog(context);
            }
            return Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !registerState.isValidEmail
                            ? 'Invalid Email'
                            : null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !registerState.isValidPassword
                            ? 'Invalid Password'
                            : null;
                      },
                    ),
                    TextFormField(
                      controller: _confirmpasswordController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Confirm Password',
                      ),
                      obscureText: true,
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !registerState.isValidPassword
                            ? 'Invalid Password'
                            : null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    RegisterButton(
                        onPressed: isRegisterButtonEnabled(registerState)
                            ? _onRegisterEmailAndPassword
                            : null
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  void _onRegisterEmailAndPassword() {
    _registerBloc.add(RegisterEventPressed(
        email: _emailController.text, password: _passwordController.text));
    LoadingDialog.showLoadingDialog(context, "Loading......");
  }
}
