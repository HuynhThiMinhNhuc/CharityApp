import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class buttoncustom extends StatefulWidget {
  final String textButton;
  final Function() onpress;

  buttoncustom({required this.textButton, required this.onpress});
  @override
  _buttoncustomState createState() => _buttoncustomState();
}

class _buttoncustomState extends State<buttoncustom> {
  get onpress => onpress;
  String get textbutton => textbutton;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: onpress,
          child: Text(
            textbutton,
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              primary: maincolor,
              fixedSize: Size(MediaQuery.of(context).size.width, 63),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
        ),
      ),
    );
  }
}
