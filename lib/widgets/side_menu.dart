import 'package:School_Dashboard/constants/style.dart';
import 'package:School_Dashboard/controllers/navigation_controller.dart';
import 'package:School_Dashboard/pages/authentication/authentication.dart';
import 'package:School_Dashboard/widgets/schools_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:School_Dashboard/constants/controllers.dart';
import 'package:School_Dashboard/constants/style.dart';
import 'package:School_Dashboard/helpers/responsiveness.dart';
import 'package:School_Dashboard/routing/routes.dart';
import 'package:School_Dashboard/widgets/custom_text.dart';
import 'package:School_Dashboard/widgets/side_menu_item.dart';
import 'package:School_Dashboard/data/school_data.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      color: Active,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: _width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset(
                        "assets/icons/logo.png",
                        width: 28,
                      ),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "School Dashboard",
                        size: 20,
                        weight: FontWeight.bold,
                        color: white,
                      ),
                    ),
                    SizedBox(width: _width / 48),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          Divider(
            color: lightActive.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map((itemName) => SideMenuItem(
                    itemName: itemName == authenticationPageDisplayName
                        ? "Log Out"
                        : itemName,
                    onTap: () {
                      if (itemName == authenticationPageDisplayName) {
                        // logout and go to autherntication page
                        logout();
                      }
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
