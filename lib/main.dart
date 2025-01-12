import 'package:School_Dashboard/controllers/menu_controller.dart' as menu_controller;
import 'package:School_Dashboard/controllers/navigation_controller.dart';
import 'package:School_Dashboard/layout.dart';
import 'package:School_Dashboard/pages/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:School_Dashboard/constants/style.dart';
import 'package:School_Dashboard/data/school_data.dart';

void main() {
  Get.put(menu_controller.MenuController());
  Get.put(NavigationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Dashboard',
      theme: ThemeData(
          disabledColor: white,
          scaffoldBackgroundColor: white,
          fontFamily: "Poppins",
          textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: darkActive),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          }),
          primaryColor: Active),
      home: AuthenticationPage(),
    );
  }
}
