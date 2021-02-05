import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gonotter_app/core/app_theme.dart';
import 'package:gonotter_app/core/request_status.dart';
import 'package:gonotter_app/pages/login/bloc/login_page_bloc.dart';

import 'bloc/login_page_event.dart';
import 'bloc/login_page_state.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _navigator = GetIt.I<FluroRouter>();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        _navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return BlocBuilder<LoginPageBloc, LoginPageState>(
        buildWhen: (previous, current) {
      if (title == "Username") {
        return previous.username != current.username;
      } else if (title == "Password") {
        return previous.password != current.password;
      } else {
        return false;
      }
    }, builder: (context, state) {
      return TextFormField(
        obscureText: isPassword,
        onChanged: (text) {
          if (title == "Username") {
            context.read<LoginPageBloc>().add(UsernameChanged(text));
          } else if (title == "Password") {
          context.read<LoginPageBloc>().add(PasswordChanged(text));
          }
        },
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(),
        ),
      );
    });
  }

  Widget _submitButton() {
    return BlocBuilder<LoginPageBloc, LoginPageState>(
        builder: (context, state) {
      return InkWell(
        onTap: () {
          context.read<LoginPageBloc>().add(const LoginSubmitted());
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: darkTheme.toggleableActiveColor,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFFFB300), darkTheme.accentColor])),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    });
  }

  Widget _noAccountLabel() {
    return InkWell(
      onTap: () {
        _navigator.navigateTo(context, "/register");
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have account?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: darkTheme.accentColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: 'GO',
          style: TextStyle(
              shadows: [
                Shadow(
                  offset: Offset(3.0, 3.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
              color: lightTheme.primaryColor,
              fontSize: 90,
              fontWeight: FontWeight.w900),
        ),
        TextSpan(
          text: 'Notter',
          style: TextStyle(
              shadows: [
                Shadow(
                  offset: Offset(3.0, 3.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
              color: darkTheme.accentColor,
              fontSize: 45,
              letterSpacing: -3,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900),
        ),
      ]),
    );
  }

  Widget _inputWidget() {
    return Column(
      children: [
        _entryField("Username"),
        SizedBox(height: 25),
        _entryField("Password", isPassword: true),
      ],
    );
  }

  Widget _mainContainer() {
    final height = MediaQuery.of(context).size.height;

    return BlocListener<LoginPageBloc, LoginPageState>(
      listener: (context, state) {
        switch (state.status.state) {
          case RequestState.error:
            Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: darkTheme.accentColor,
                content: Text((state.status.error as DioError).response.data)));

            Navigator.of(context).pop();
            context.read<LoginPageBloc>().add(const Finish());
            break;
          case RequestState.notStarted:
            break;
          case RequestState.loading:
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Loading"),
                    content: Container(alignment: Alignment.center, child: CircularProgressIndicator()),
                  );
                });
            break;
          case RequestState.ok:
            Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.black12,
                content: Text("Logged in")));

            _navigator.navigateTo(context, "/notes", clearStack: true);
            break;
        }
      },
      child: Scaffold(
          body: Container(
        height: height,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(height: 50),
                    _inputWidget(),
                    SizedBox(height: 20),
                    _submitButton(),
                    _noAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginPageBloc(),
      child: _mainContainer(),
    );
  }
}
