import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';

class OtpTextField extends StatefulWidget {
  final bool next;

  OtpTextField({required this.next});
  @override
  _OtpTextFieldState createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: TextFormField(
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          fillColor: backgrountbutton.withOpacity(0.2),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: backgrountbutton.withOpacity(1), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: backgrountbutton.withOpacity(0.1), width: 0)),
        ),
        keyboardType: TextInputType.number,
        textInputAction:
            widget.next ? TextInputAction.next : TextInputAction.done,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 40,
            color: maincolor,
            fontFamily: 'Roboto-Regular.ttf',
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
