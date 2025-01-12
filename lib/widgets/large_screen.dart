import 'package:School_Dashboard/helpers/local_navigator.dart';
import 'package:flutter/material.dart';
import 'package:School_Dashboard/widgets/side_menu.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SideMenu()),
        Expanded(flex: 5, child: localNavigator())
      ],
    );
  }
}
