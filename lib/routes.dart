import 'package:flutter/cupertino.dart';
import 'package:stdbook/constants/route_constants.dart';
import 'package:stdbook/screens/book/book_screen.dart';
import 'package:stdbook/screens/stadium/stadium_screen.dart';

final Map<String, WidgetBuilder> routes = {
  RouteConstants.stadium_screen: (BuildContext context) => StadiumScreen(),
  RouteConstants.book_screen: (BuildContext context) => BookScreen()
};
