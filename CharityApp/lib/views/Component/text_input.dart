import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInput extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color boder;
  final String hint;
  final String labeltext;
  final Function? onTextChange = () => {};
  final TextEditingController textEditingController;
  TextInputType textInputType = TextInputType.text;

  TextInput(
      {required this.icon,
      required this.background,
      required this.boder,
      required this.hint,
      required this.labeltext,
      required this.textEditingController,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: maincolor,
          size: 23.h,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: boder.withOpacity(1), width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: boder.withOpacity(1), width: 1)),
        hintText: hint,
        hintStyle: kText15BoldGreyHintText,
        fillColor: background.withOpacity(0.2),
        filled: true,
      ),
    );
  }
}
