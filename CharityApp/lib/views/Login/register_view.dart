import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Component/password_input.dart';
import 'package:charityapp/views/Component/text_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 0, 30),
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
              'Register',
              style: TextStyle(
                  color: maincolor,
                  fontSize: 40,
                  fontFamily: 'Roboto-Regular.ttf',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Create your new account',
              style: TextStyle(
                  color: notetextcolor,
                  fontSize: 20,
                  fontFamily: 'Roboto_Regular'),
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextInput(
                    icon: Icons.people,
                    background: backgrountbutton.withOpacity(0.2),
                    boder: backgrountbutton.withOpacity(0.1),
                    hint: 'Email/Phone number',
                    labeltext: '',)),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: PassWordInput(
                  hint: 'Password',
                  background: backgrountbutton,
                  boder: backgrountbutton,
                  securitytext: false,
                  ispass: true,),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: PassWordInput(
                  hint: 'Confirm password',
                  background: backgrountbutton,
                  boder: backgrountbutton,
                  securitytext: true,
                  ispass: true,),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'By signing you agree to our',
                    style: TextStyle(color: icon),
                  ),
                  Text(
                    ' Team of use',
                    style: TextStyle(color: maincolor),
                  ),
                  Text(
                    ' and',
                    style: TextStyle(color: icon),
                  ),
                ]),
            Text(
              'privacy notice',
              style: TextStyle(color: maincolor),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: CustomButton(
                onPressed: () => {},
                textInput: 'REGISTER',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Already have account?',
                    style: TextStyle(
                      color: icon,
                      fontSize: 16,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(' Login!',
                    style: TextStyle(
                        color: red, fontSize: 17, fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      ),
    );
  }
}
