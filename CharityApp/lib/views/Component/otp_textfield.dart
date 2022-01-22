import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpTextField extends StatefulWidget {
  final bool next;
  final TextEditingController textEditingController;

  OtpTextField({required this.next, required this.textEditingController});
  @override
  _OtpTextFieldState createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.sp,
      child: TextFormField(
        controller: widget.textEditingController,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          fillColor: backgrountbutton.withOpacity(0.2),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: maincolor, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: maincolor, width: 0)),
        ),
        keyboardType: TextInputType.number,
        textInputAction:
            widget.next ? TextInputAction.next : TextInputAction.done,
        textAlign: TextAlign.center,
        style: kText40BoldMain,
      ),
    );
  }
}
