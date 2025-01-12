import 'package:flutter/material.dart';
import 'package:School_Dashboard/routing/routes.dart';
import 'package:School_Dashboard/pages/overview/overview.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageDisplayName:
      return _getPageRoute(OverviewPage());
    default:
      return _getPageRoute(OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
