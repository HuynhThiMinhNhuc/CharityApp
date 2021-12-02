import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Component/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 0, 50),
            child: Row(children: [
              IconButton(
                  onPressed: () => {},
                  icon: FaIcon(
                    FontAwesomeIcons.chevronCircleLeft,
                    color: notetextcolor,
                    size: 40,
                  )),
            ]),
          ),
          Text(
            'Forgot password',
            style: TextStyle(
                color: maincolor,
                fontSize: 40,
                fontFamily: 'Roboto-Regular.ttf',
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text(
              'Enter the Email/Phone number associated with your account and we’ll send an email with instruction to reset your password',
              style: TextStyle(
                  color: notetextcolor,
                  fontSize: 18,
                  fontFamily: 'Roboto_Regular'),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
              child: Text(
                'Email/ Phone number',
                style: TextStyle(
                    color: maincolor,
                    fontFamily: 'Roboto-Regular.tff',
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ]),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextInput(
                icon: Icons.people,
                background: Colors.white,
                boder: maincolor,
                hint: '',
                labeltext: '',
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: CustomButton(onPressed: () => {}, textInput: 'SEND OTP'))
        ],
      ),
    );
  }
}
