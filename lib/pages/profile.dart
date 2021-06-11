import 'package:appecommerce/login/blocs/authentication_bloc.dart';
import 'package:appecommerce/login/blocs/login_bloc.dart';
import 'package:appecommerce/login/events/authentication_event.dart';
import 'package:appecommerce/login/pages/buttons/loading_dialog.dart';
import 'package:appecommerce/login/pages/buttons/msg_dilog.dart';
import 'package:appecommerce/login/pages/login_page.dart';
import 'package:appecommerce/login/pages/splash_page.dart';
import 'package:appecommerce/login/repositories/user_repository.dart';
import 'package:appecommerce/login/states/authentication_state.dart';
import 'package:appecommerce/pages/BottomNavigation.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserRepository _userRepository = UserRepository();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.purple, Colors.deepPurple])),
              ),
              Padding(
                padding: EdgeInsets.only(top: 64.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 2.0)),
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTbGIzdUTffa34zTcGWSl0QDk5C3uVt5b1Oag&usqp=CAU"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "Shinichi Kudo",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    ),
                    Text(
                      "Member since 2017",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    MaterialButton(
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(AuthenticationEventLoggedOut());
                      },
                      color: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Share account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment(1.4, -1.1),
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white30),
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 350),
                decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 250),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: GridView.builder(
                      itemCount: 8,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) => Card(
                            child: Container(
                              margin: EdgeInsets.all(4.0),
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      // MsgDialog.showMsgDialog(
                                      //     context, "Sign in", "Login Failed");
                                      //LoadingDialog.showLoadingDialog(context, "Loading......");
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) =>
                                              BlocProvider(
                                                create: (context) =>
                                                AuthenticationBloc(userRepository: _userRepository)
                                                  ..add(AuthenticationEventStarted()),
                                                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                                                  builder: (context, authenticationState) {
                                                    if (authenticationState is AuthenticationStateSuccess) {
                                                      return BottomNav();
                                                    } else if (authenticationState is AuthenticationStateFailure) {
                                                      return BlocProvider<LoginBloc>(
                                                          create: (context) =>
                                                              LoginBloc(userRepository: _userRepository),
                                                          child: LoginPage(
                                                            userRepository: _userRepository,
                                                          ) //LoginPage,
                                                      );
                                                    }
                                                    return BlocProvider<LoginBloc>(
                                                        create: (context) =>
                                                        LoginBloc(userRepository: _userRepository),
                                                    child: LoginPage(
                                                    userRepository: _userRepository,
                                                    ));
                                                  },
                                                ),
                                              )
                                          )
                                      );
                                    },
                                    icon: Icon(
                                      EvaIcons.settings,
                                      size: 60,
                                    ),
                                  ),
                                  Text(
                                    "Setting",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  VoidCallback _BottomNav() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => BottomNav()));
  }
}
