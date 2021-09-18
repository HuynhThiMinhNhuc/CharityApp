import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color boder;
  final String hint;
  final String labeltext;

  TextInput(
      {required this.icon,
      required this.background,
      required this.boder,
      required this.hint,
      required this.labeltext});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: maincolor,
            size: 23,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: boder.withOpacity(1), width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: boder.withOpacity(1), width: 1)),
          hintText: hint,
          hintStyle: TextStyle(
              color: hinttextcolor,
              fontSize: 15,
              fontFamily: 'Roboto-Thin.tff'),
          fillColor: background.withOpacity(0.2),
          filled: true,
        ),
      ),
    ]);
  }
}
