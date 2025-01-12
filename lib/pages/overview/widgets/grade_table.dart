import 'package:School_Dashboard/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:School_Dashboard/widgets/custom_text.dart';
import 'package:School_Dashboard/data/school_data.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class GradeTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: gradeList,
        builder:
            (BuildContext context, List<String> newGradeList, Widget child) {
              return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Expanded(
            child: CustomText(
                text: 'Grade', weight: FontWeight.bold, color: darkActive),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: CustomText(
                text: 'Students', weight: FontWeight.bold, color: darkActive),
          ),
        ),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Grade 1')),
            DataCell(Text(newGradeList[0])),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Grade 2')),
            DataCell(Text(newGradeList[1])),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Grade 3')),
            DataCell(Text(newGradeList[2])),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Grade 4')),
            DataCell(Text(newGradeList[3])),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Grade 5')),
            DataCell(Text(newGradeList[4])),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Grade 6')),
            DataCell(Text(newGradeList[5])),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Grade 7')),
            DataCell(Text(newGradeList[6])),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Grade 8')),
            DataCell(Text(newGradeList[7])),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Grade 9')),
            DataCell(Text(newGradeList[8])),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Grade 10')),
            DataCell(Text(newGradeList[9])),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Grade 11')),
            DataCell(Text(newGradeList[10])),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Grade 12')),
            DataCell(Text(newGradeList[11])),
          ],
        ),
      ],
    );
            });
  }
}
