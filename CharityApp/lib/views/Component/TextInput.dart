import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color boder;
  final String hint;

  TextInput(
      {required this.icon,
      required this.background,
      required this.boder,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: maincolor,
            size: 23,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: boder.withOpacity(1), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: background.withOpacity(0.1), width: 0)),
          hintText: hint,
          hintStyle: TextStyle(
              color: hinttextcolor,
              fontSize: 15,
              fontFamily: 'Roboto-Thin.tff'),
          fillColor: backgrountbutton.withOpacity(0.2),
          filled: true),
    );
  }
}
