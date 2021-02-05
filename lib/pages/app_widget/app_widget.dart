import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gonotter_app/core/app_theme.dart';
import 'package:gonotter_app/core/gonotter_app.dart';
import 'package:gonotter_app/pages/app_widget/bloc/app_widget_bloc.dart';
import 'package:gonotter_app/pages/app_widget/bloc/app_widget_event.dart';
import 'package:gonotter_app/pages/app_widget/bloc/app_widget_state.dart';
import 'package:gonotter_app/pages/home/home_page.dart';
import 'package:gonotter_app/pages/notes/notes_page.dart';
import 'package:logger/logger.dart';

class AppWidget extends StatefulWidget {
  final GoNotterApp _app;

  AppWidget(this._app);

  @override
  _AppWidgetState createState() => _AppWidgetState(_app);
}

class _AppWidgetState extends State<AppWidget> {
  final GoNotterApp _app;
  _AppWidgetState(this._app);

  var logger = GetIt.I<Logger>();
  var navigation = GetIt.I<FluroRouter>();

  @override
  void dispose() async {
    logger.d('dispose');
    super.dispose();
    _app.onTerminate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppWidgetBloc()..add(AppLoaded()),
        child: MaterialApp(
          title: "Test name",
          home: BlocBuilder<AppWidgetBloc, AppWidgetState>(
            builder: (context, state) {
              if (state is AuthenticationState) {
                if(state.status == AuthenticationStatus.authenticated){
                  navigation.navigateTo(context, "/notes");
                }else if(state.status == AuthenticationStatus.unauthenticated){
                  Container();
                }else{
                  return HomePage();
                }
              }
              return Container();
            },
          ),
          builder: (context, child) {
            return Scaffold(
              body: GestureDetector(
                onTap: () {
                  hideKeyboard(context);
                },
                child: child,
              ),
            );
          },
          theme: lightTheme,
          darkTheme: darkTheme,
          onGenerateRoute: navigation.generator,
        ));
  }
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}