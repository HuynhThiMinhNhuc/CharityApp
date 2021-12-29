import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PassWordInput extends StatefulWidget {
  final bool securitytext;
  final Color background;
  final Color boder;
  final String hint;
  final bool ispass;
  final TextEditingController textcontroller;
  final TextInputType textInputType;

  PassWordInput(
      {required this.securitytext,
      required this.background,
      required this.boder,
      required this.hint,
      required this.ispass,
      required this.textcontroller,
      required this.textInputType});

  @override
  _PassWordInputState createState() => _PassWordInputState();
}

class _PassWordInputState extends State<PassWordInput> {
  bool securi = true;

  @override
  void initState() {
    securi = widget.securitytext;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      controller: widget.textcontroller,
      decoration: InputDecoration(
          prefixIcon: Icon(
            widget.ispass ? Icons.lock : Icons.cake_rounded,
            color: maincolor,
            size: 23,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: widget.boder.withOpacity(1), width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: widget.boder.withOpacity(1), width: 1)),
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: hinttextcolor,
              fontSize: 15,
              fontFamily: 'Roboto-Thin.tff'),
          fillColor: widget.background.withOpacity(0.2),
          filled: true,
          suffixIcon: IconButton(
            icon: widget.ispass
                ? securi
                    ? FaIcon(FontAwesomeIcons.eyeSlash, size: 22)
                    : Icon(Icons.remove_red_eye_outlined, size: 25)
                : FaIcon(
                    FontAwesomeIcons.calendar,
                    color: maincolor,
                  ),
            color: icon,
            onPressed: () {
              widget.ispass
                  ? setState(() {
                      securi = !securi;
                    })
                  : showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101));
            },
            splashRadius: 25,
          )),
      obscureText: widget.ispass ? securi : false,
    );
  }
}
