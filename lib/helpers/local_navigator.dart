import 'package:School_Dashboard/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:School_Dashboard/constants/controllers.dart';
import 'package:School_Dashboard/routing/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      initialRoute: overviewPageDisplayName,
      onGenerateRoute: generateRoute,
    );
