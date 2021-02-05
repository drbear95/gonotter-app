import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gonotter_app/core/app_theme.dart';
import 'package:gonotter_app/pages/application_page.dart';
import 'package:gonotter_app/core/extension.dart';

class HomePage extends ApplicationPage {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return WillPopScope(
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
                      SizedBox(height: height * .15),
                      _title(),
                      SizedBox(height: 100),
                      _button(context, "LOGIN", () {
                        navigator.navigateTo(context, "/login");
                      }),
                      SizedBox(height: 25),
                      _button(context, "REGISTER", () {
                        navigator.navigateTo(context, "/register");
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
        onWillPop: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Exit"),
                  content: Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("YES"),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                    FlatButton(
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          return Future.value(true);
        });
  }

  Widget _button(BuildContext context, String title, Function() action) {
    return InkWell(
      onTap: action,
      child: Ink(
        child: Container(
          width: context.screenWidth(),
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
            title,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
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
}
