import 'package:School_Dashboard/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:School_Dashboard/pages/overview/widgets/info_card.dart';
import 'package:School_Dashboard/data/school_data.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SizedBox(
              width: _width / 64,
            ),
            ValueListenableBuilder(valueListenable: totalStudents, builder: (BuildContext context, String newTotalStudents,
        Widget child){ 
          return InfoCard(
          title: "Students",
          value: newTotalStudents,
          topColor: Active,
          onTap: () {},
        );}),
            SizedBox(
              width: _width / 64,
            ),
          ValueListenableBuilder(valueListenable: totalParents, builder: (BuildContext context, String newTotalParents,
        Widget child){ 
          return InfoCard(
          title: "Parents",
          value: newTotalParents,
          topColor: contrast1,
          onTap: () {},
        );}),
            SizedBox(
              width: _width / 64,
            ),
          ],
        ),
        SizedBox(
          height: _width / 64,
        ),
        Row(
          children: [
            SizedBox(
              width: _width / 64,
            ),
            ValueListenableBuilder(valueListenable: dismissalAverage, builder: (BuildContext context, String newDismissalAverage,
        Widget child){ 
          return InfoCard(
          title: "Dismissal Average (mins)",
          value: newDismissalAverage,
          topColor: contrast2,
          onTap: () {},
        );}),
            SizedBox(
              width: _width / 64,
            ),
            ValueListenableBuilder(valueListenable: dismissalMedian, builder: (BuildContext context, String newDismissalMedian,
        Widget child){ 
          return InfoCard(
          title: "Dismissal Median (mins)",
          value: newDismissalMedian,
          topColor: darkActive,
          onTap: () {},
        );}),
            SizedBox(
              width: _width / 64,
            ),
          ],
        ),
      ],
    );
  }
}
