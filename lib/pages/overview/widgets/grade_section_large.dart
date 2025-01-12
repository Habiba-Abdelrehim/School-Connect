import 'package:School_Dashboard/pages/overview/widgets/grade_table.dart';
import 'package:flutter/material.dart';
import 'package:School_Dashboard/constants/style.dart';
import 'package:School_Dashboard/pages/overview/widgets/bar_chart.dart';
import 'package:School_Dashboard/pages/overview/widgets/grade_info.dart';
import 'package:School_Dashboard/widgets/custom_text.dart';

class GradeSectionLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Enrolled Students per Grade",
                  size: 20,
                  weight: FontWeight.bold,
                  color: Colors.grey,
                ),
                Container(
                    width: 600,
                    height: 300,
                    child: SimpleBarChart.withSampleData()),
                SizedBox(height: 300,)
              
              ],
            ),
          ),
          Container(
            width: 5,
            height: 120,
            color: Colors.white,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ 
                Container(
                    width: 600,
                    height: 650, 
                    child:GradeTable())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
