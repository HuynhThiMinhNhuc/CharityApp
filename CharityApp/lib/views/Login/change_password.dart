import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Component/password_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      new TextEditingController();
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
            ' Change Password',
            style: TextStyle(
                color: maincolor,
                fontSize: 40,
                fontFamily: 'Roboto-Regular.ttf',
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
            child: Text(
              'New password must be different from previous used passwords',
              style: TextStyle(
                  color: notetextcolor,
                  fontSize: 20,
                  fontFamily: 'Roboto_Regular'),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
              child: Text(
                'New Password',
                style: TextStyle(
                    color: maincolor,
                    fontFamily: 'Roboto-Regular.tff',
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: PassWordInput(
              securitytext: false,
              background: Colors.white,
              boder: maincolor,
              hint: '',
              ispass: true,
              textcontroller: passwordcontroller,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
              child: Text(
                'Confirm Password',
                style: TextStyle(
                    color: maincolor,
                    fontFamily: 'Roboto-Regular.tff',
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: PassWordInput(
              securitytext: true,
              background: Colors.white,
              boder: maincolor,
              hint: '',
              ispass: true,
              textcontroller: confirmpasswordcontroller,
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: CustomButton(
                  onPressed: () => {}, textInput: 'CHANGE PASSWORD'))
        ],
      ),
    );
  }
}
