import 'package:School_Dashboard/helpers/responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:School_Dashboard/constants/style.dart';
import 'package:School_Dashboard/widgets/custom_text.dart';
import 'package:School_Dashboard/widgets/schools_dropdown.dart';
import 'package:School_Dashboard/data/school_data.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Image.asset(
                    "assets/icons/logo.png",
                    width: 28,
                  ),
                ),
              ],
            )
          : IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                key.currentState.openDrawer();
              }),
      elevation: 0,
      iconTheme: IconThemeData(color: Active),
      backgroundColor: white,
      title: Container(
        child: Row(
          children: [
            Visibility(
                visible: !ResponsiveWidget.isSmallScreen(context),
                child: CustomText(
                  text: "School Dashboard",
                  color: Active,
                  size: 24,
                  weight: FontWeight.bold,
                )),
            Expanded(child: Container()),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 40.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0), color: Active),
              child:
                  DropdownButtonHideUnderline(child: SchoolsDropdownButton()),
            ),
            Stack(
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 1,
              height: 22,
              color: lightActive,
            ),
            SizedBox(
              width: 24,
            ),
            CustomText(
              text: userName,
              color: Active,
            ),
            SizedBox(
              width: 16,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Active.withOpacity(.5),
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: white,
                  child: Icon(
                    Icons.person_outline,
                    color: Active,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
