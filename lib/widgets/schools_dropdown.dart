import 'package:flutter/material.dart';
import 'package:School_Dashboard/constants/style.dart';
import 'package:School_Dashboard/data/school_data.dart';

class SchoolsDropdownButton extends StatefulWidget {
  @override
  State<SchoolsDropdownButton> createState() => _SchoolsDropdownButtonState();
}

class _SchoolsDropdownButtonState extends State<SchoolsDropdownButton> {
  @override
  void initState() {
    super.initState();
  }

  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    Future getFirstItem() async {
      await Future.wait(
          [isSuperuser ? getSchoolsList() : getUserSchool(userID)]);
      dropdownValue = schoolsList.first;
      final results = await Future.wait([
        getTotalStudents(schoolsList.first),
        getTotalParents(schoolsList.first),
        getDismissalAverage(schoolsList.first),
        getDismissalMedian(schoolsList.first),
        getGradeList(schoolsList.first)
      ]);

      // update dashboard values
      setState(() {
        // info cards values for the selected school
        totalStudents.value = results[0];
        totalParents.value = results[1];
        dismissalAverage.value = results[2];
        dismissalMedian.value = results[3];
        // students per grade values for the selected school
        gradeList.value = results[4];
      });
    }

    if (schoolsList.isEmpty) {
      getFirstItem();
    }
    return FutureBuilder(
        future: isSuperuser ? getSchoolsList() : getUserSchool(userID),
        builder: (context, snapshot) {
          return DropdownButton<String>(
            value: dropdownValue,
            dropdownColor: Active,
            icon: Icon(isSuperuser ? Icons.arrow_drop_down : Icons.arrow_right),
            iconEnabledColor: white,
            elevation: 8,
            style: TextStyle(color: white),
            underline: Container(),
            onChanged: isSuperuser
                ? (String newValue) {
                    Future _fetchData() async {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = newValue;
                      });

                      final results = await Future.wait([
                        getTotalStudents(newValue),
                        getTotalParents(newValue),
                        getDismissalAverage(newValue),
                        getDismissalMedian(newValue),
                        getGradeList(newValue)
                      ]);

                      // update dashboard values
                      setState(() {
                        // info cards values for the selected school
                        totalStudents.value = results[0];
                        totalParents.value = results[1];
                        dismissalAverage.value = results[2];
                        dismissalMedian.value = results[3];
                        // students per grade values for the selected school
                        gradeList.value = results[4];
                      });
                    }

                    _fetchData();
                  }
                : null,
            items: schoolsList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        });
  }
}
