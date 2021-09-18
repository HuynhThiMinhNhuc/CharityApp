import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PassInput extends StatefulWidget {
  final bool securitytext;
  final Color background;
  final Color boder;
  final String hint;

  PassInput(
      {required this.securitytext,
      required this.background,
      required this.boder,
      required this.hint});

  @override
  _PassInputState createState() => _PassInputState();
}

class _PassInputState extends State<PassInput> {
  bool securi = true;

  @override
  void initState() {
    securi = widget.securitytext;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: maincolor,
            size: 23,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: widget.boder.withOpacity(1), width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: widget.background.withOpacity(0.1), width: 0)),
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: hinttextcolor,
              fontSize: 15,
              fontFamily: 'Roboto-Thin.tff'),
          fillColor: backgrountbutton.withOpacity(0.2),
          filled: true,
          suffixIcon: IconButton(
            icon: securi
                ? FaIcon(FontAwesomeIcons.eyeSlash)
                : Icon(Icons.remove_red_eye_outlined),
            color: icon,
            onPressed: () {
              setState(() {
                securi = !securi;
              });
            },
          )),
      obscureText: securi,
    );
  }
}
