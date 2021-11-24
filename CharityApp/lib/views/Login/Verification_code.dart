import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/ButtonCustom.dart';
import 'package:charityapp/views/Component/Otp_textfeld.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class verification_otp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<verification_otp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 0, 50),
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
              'Verification code',
              style: TextStyle(
                  color: maincolor,
                  fontSize: 40,
                  fontFamily: 'Roboto-Regular.ttf',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Enter the OTP has been sent to',
              style: TextStyle(
                  color: notetextcolor,
                  fontSize: 20,
                  fontFamily: 'Roboto_Regular'),
            ),
            Text(
              '******1034',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontFamily: 'Roboto-Regular.ttf',
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 70, 30, 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    otpTextfeld(next: true),
                    otpTextfeld(next: true),
                    otpTextfeld(next: true),
                    otpTextfeld(next: false)
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Don’t receive OTP?',
                    style: TextStyle(
                      color: icon,
                      fontSize: 16,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(' RESENT OTP (112)',
                    style: TextStyle(
                        color: maincolor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold))
              ],
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 70, 30, 10),
                child: CustomButton(onPressed: () => {}, textInput: 'VERIFY'))
          ],
        ),
      ),
    );
  }
}
