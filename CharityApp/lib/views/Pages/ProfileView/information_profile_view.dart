import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/cupertino.dart';

class InformationProfileView extends StatelessWidget {
  int number;
  String text;

  InformationProfileView(this.number, this.text) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(this.number.toString(),
            style: TextStyle(
                color: textcolor,
                fontSize: 15,
                decoration: TextDecoration.none,
                fontFamily: 'Roboto_Regular',
                fontWeight: FontWeight.bold)),
        Text(text,
            style: TextStyle(
                color: textcolor,
                fontSize: 14,
                decoration: TextDecoration.none,
                fontFamily: 'Roboto_Regular',
                fontWeight: FontWeight.normal)),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}
