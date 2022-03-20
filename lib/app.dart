import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stdbook/constants/app_constants.dart';
import 'package:stdbook/routes.dart';
import 'package:stdbook/screens/booked_requests/booked_requests_Screen.dart';
import 'package:stdbook/screens/create_std/create_std.dart';
import 'package:stdbook/screens/home_page.dart/home_page_screen.dart';
import 'package:stdbook/screens/login/login_bloc.dart';
import 'package:stdbook/screens/login/login_screen.dart';
import 'package:stdbook/screens/nav_bar.dart/nav_bar_screen.dart';

import 'locator.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String token;
  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      token = await getIt<FlutterSecureStorage>().read(key: AppConstants.token);
      getIt<LoginController>().tokenController.sink.add(token);
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: getIt<LoginController>().tokenController.stream,
        builder: (context, snapshot) {
          print(snapshot.data);
          return MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.green,
              ),
              routes: routes,
              home: snapshot.data == null ? LoginScreen() : HomePage());
        });
  }
}
