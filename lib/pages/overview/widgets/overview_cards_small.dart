import 'package:flutter/material.dart';
import 'info_card_small.dart';
import 'package:School_Dashboard/data/school_data.dart';


class OverviewCardsSmallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      height: 400,
      child: Column(
        children: [
         ValueListenableBuilder(valueListenable: totalStudents, builder: (BuildContext context, String newTotalStudents,
        Widget child){ 
          return InfoCardSmall(
          title: "Students",
          value: newTotalStudents,
          onTap: () {},
        );}),
          SizedBox(
            height: _width / 64,
          ),
          ValueListenableBuilder(valueListenable: totalParents, builder: (BuildContext context, String newTotalParents,
        Widget child){ 
          return InfoCardSmall(
          title: "Parents",
          value: newTotalParents,
          onTap: () {},
        );}),
          SizedBox(
            height: _width / 64,
          ),
          ValueListenableBuilder(valueListenable: dismissalAverage, builder: (BuildContext context, String newDismissalAverage,
        Widget child){ 
          return InfoCardSmall(
          title: "Dismissal Average (mins)",
          value: newDismissalAverage,
          onTap: () {},
        );}),
          SizedBox(
            height: _width / 64,
          ),
          ValueListenableBuilder(valueListenable: dismissalMedian, builder: (BuildContext context, String newDismissalMedian,
        Widget child){ 
          return InfoCardSmall(
          title: "Dismissal Median (mins)",
          value: newDismissalMedian,
          onTap: () {},
        );}),
        ],
      ),
    );
  }
}
