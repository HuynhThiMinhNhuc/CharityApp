import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.onPressed, required this.textInput});
  final GestureTapCallback onPressed;
  final String textInput;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        textInput,
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          primary: maincolor,
          fixedSize: Size(MediaQuery.of(context).size.width, 60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
    );
  }
}
