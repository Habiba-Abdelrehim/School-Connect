import 'package:School_Dashboard/constants/style.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:School_Dashboard/data/school_data.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: gradeList,
        builder:
            (BuildContext context, List<String> newGradeList, Widget child) {
          return charts.BarChart(
            _createSampleData(),
            animate: animate,
          );
        });
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<StudentsPerGrade, String>> _createSampleData() {
    List<String> charList = [];
    if (gradeList.value.contains("--")) {
      charList = List.filled(12, "0");
    } else {
      charList = gradeList.value;
    }

    final data = [
      new StudentsPerGrade('1', int.tryParse(charList[0])),
      new StudentsPerGrade('2', int.tryParse(charList[1])),
      new StudentsPerGrade('3', int.tryParse(charList[2])),
      new StudentsPerGrade('4', int.tryParse(charList[3])),
      new StudentsPerGrade('5', int.tryParse(charList[4])),
      new StudentsPerGrade('6', int.tryParse(charList[5])),
      new StudentsPerGrade('7', int.tryParse(charList[6])),
      new StudentsPerGrade('8', int.tryParse(charList[7])),
      new StudentsPerGrade('9', int.tryParse(charList[8])),
      new StudentsPerGrade('10', int.tryParse(charList[9])),
      new StudentsPerGrade('11', int.tryParse(charList[10])),
      new StudentsPerGrade('12', int.tryParse(charList[11])),
    ];

    return [
      new charts.Series<StudentsPerGrade, String>(
          id: 'Grade',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(contrast1),
          domainFn: (StudentsPerGrade grade, _) => grade.grade,
          measureFn: (StudentsPerGrade grade, _) => grade.num_students,
          data: data)
    ];
  }
}

/// Sample ordinal data type.
class StudentsPerGrade {
  final String grade;
  final int num_students;

  StudentsPerGrade(this.grade, this.num_students);
}
