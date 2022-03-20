import 'package:flutter/material.dart';
import 'package:stdbook/app.dart';
import 'package:stdbook/locator.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(App());
}
