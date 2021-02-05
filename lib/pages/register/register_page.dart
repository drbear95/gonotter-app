import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gonotter_app/core/app_theme.dart';
import 'package:gonotter_app/core/request_status.dart';
import 'package:gonotter_app/pages/register/bloc/register_page_bloc.dart';
import 'package:gonotter_app/pages/register/bloc/register_page_event.dart';

import 'bloc/register_page_state.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    return BlocBuilder<RegisterPageBloc, RegisterPageState>(
        buildWhen: (previous, current) {
      if (title == "Username") {
        return previous.username != current.username;
      } else if (title == "Email") {
        return previous.email != current.email;
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
            context.read<RegisterPageBloc>().add(UsernameChanged(text));
          } else if (title == "Email") {
          context.read<RegisterPageBloc>().add(EmailChanged(text));
          } else if (title == "Password") {
          context.read<RegisterPageBloc>().add(PasswordChanged(text));
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
    return BlocBuilder<RegisterPageBloc, RegisterPageState>(
        builder: (context, state) {
      return InkWell(
        onTap: () {
          context.read<RegisterPageBloc>().add(const RegisterSubmitted());
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
            'Register',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    });
  }

  Widget _alreadyHaveAccountLabel() {
    return InkWell(
      onTap: () {
        _navigator.navigateTo(context, "/login");
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
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
        _entryField("Email"),
        SizedBox(height: 25),
        _entryField("Password", isPassword: true),
      ],
    );
  }

  Widget _mainContainer() {
    final height = MediaQuery.of(context).size.height;

    return BlocListener<RegisterPageBloc, RegisterPageState>(
      listener: (context, state) {
        switch (state.status.state) {
          case RequestState.error:
            Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: darkTheme.accentColor,
                content: Text((state.status.error as DioError).response.data)));

            Navigator.of(context).pop();
            context.read<RegisterPageBloc>().add(const Finish());
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
                content: Text("Register completed")));

            _navigator.navigateTo(context, "/");
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
                    _alreadyHaveAccountLabel(),
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
      create: (context) => RegisterPageBloc(),
      child: _mainContainer(),
    );
  }
}
