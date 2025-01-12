import 'package:School_Dashboard/constants/style.dart';
import 'package:School_Dashboard/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:School_Dashboard/constants/controllers.dart';
import 'package:School_Dashboard/helpers/responsiveness.dart';
import 'package:School_Dashboard/pages/overview/widgets/overview_cards_large.dart';
import 'package:School_Dashboard/pages/overview/widgets/overview_cards_medium.dart';
import 'package:School_Dashboard/pages/overview/widgets/overview_cards_small.dart';
import 'package:School_Dashboard/pages/overview/widgets/grade_section_large.dart';
import 'package:School_Dashboard/pages/overview/widgets/grade_section_small.dart';
import 'package:School_Dashboard/pages/overview/widgets/grade_table.dart';

class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          if (ResponsiveWidget.isSmallScreen(context)) Obx(
            () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                      top: 56, bottom: 15),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                      color: Active,
                    )),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              if (ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isMediumScreen(context))
                if (ResponsiveWidget.isCustomScreen(context))
                  OverviewCardsMediumScreen()
                else
                  OverviewCardsLargeScreen()
              else
                OverviewCardsSmallScreen(),
              if (!ResponsiveWidget.isSmallScreen(context))
                GradeSectionLarge()
              else
                GradeSectionSmall(),
               if (ResponsiveWidget.isSmallScreen(context)) Container(
                  padding: EdgeInsets.all(24),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 6),
                    color: Colors.grey.withOpacity(.1),
                    blurRadius: 12)
              ],
              border: Border.all(color: Colors.grey, width: .5),
            ), child: GradeTable() )
            ],
          ))
        ],
      ),
    );
  }
}
