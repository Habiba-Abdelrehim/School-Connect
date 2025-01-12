import 'package:School_Dashboard/helpers/responsiveness.dart';
import 'package:School_Dashboard/widgets/large_screen.dart';
import 'package:School_Dashboard/widgets/small_screen.dart';
import 'package:School_Dashboard/widgets/top_nav.dart';
import 'package:flutter/material.dart';
import 'package:School_Dashboard/widgets/side_menu.dart';
import 'package:School_Dashboard/helpers/local_navigator.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(
          largeScreen: LargeScreen(),
          smallScreen: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: localNavigator(),
          )),
    );
  }
}
