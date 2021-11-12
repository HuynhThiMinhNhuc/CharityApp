import 'package:flutter/cupertino.dart';

class InformationProfileView extends StatelessWidget {
  int number;
  String text;

  InformationProfileView(this.number, this.text) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(this.number.toString(), style: myTextStyle()),
        Text(text, style: myTextStyle()),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  TextStyle myTextStyle() {
    return TextStyle(fontSize: 12);
  }
}
