import 'package:flutter/material.dart';
import 'package:School_Dashboard/constants/style.dart';
import 'package:School_Dashboard/widgets/custom_text.dart';

class InfoCardSmall extends StatelessWidget {
  final String title;
  final String value;
  final bool isActive;
  final Function onTap;

  const InfoCardSmall(
      {Key key,
      @required this.title,
      @required this.value,
      this.isActive = false,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Active,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isActive ? white : white, width: .5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: title,
                  size: 20,
                  weight: FontWeight.bold,
                  color: isActive ? white : white,
                ),
                CustomText(
                  text: value,
                  size: 20,
                  weight: FontWeight.bold,
                  color: isActive ? contrast1 : contrast1,
                )
              ],
            )),
      ),
    );
  }
}
