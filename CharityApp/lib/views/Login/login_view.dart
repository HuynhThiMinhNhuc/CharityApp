
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/password_input.dart';
import 'package:charityapp/views/Component/text_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool securtytext = false;
  final IconData eye = Icons.remove_red_eye_outlined;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image(
            image: AssetImage('asset/Login.png'),
            height: 280,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Welcome',
            style: TextStyle(
                color: maincolor,
                fontSize: 40,
                fontFamily: 'Roboto_Regular',
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Login to your account',
            style: TextStyle(
                color: notetextcolor,
                fontSize: 20,
                fontFamily: 'Roboto_Regular'),
          ),
          SizedBox(
            height: 30,
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
                securitytext: true,
                ispass: true,
              ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    onPressed: () => {},
                    icon: Icon(
                      Icons.check_circle,
                      color: maincolor,
                      size: 20,
                    ),
                    label: Text(
                      'Remember me',
                      style: TextStyle(color: icon),
                    )),
                Text(
                  'Forgot password?',
                  style: TextStyle(
                      color: maincolor,
                      fontFamily: 'Roboto-Regular.ttf',
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: ElevatedButton(
              onPressed: () => {},
              child: Text(
                'LOGIN',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  primary: maincolor,
                  fixedSize: Size(MediaQuery.of(context).size.width, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'or joint with',
            style: TextStyle(
                color: notetextcolor,
                fontSize: 15,
                fontFamily: 'Roboto-Regular.ttf'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () => {},
                icon: FaIcon(FontAwesomeIcons.google),
                iconSize: 35,
              ),
              IconButton(
                onPressed: () => {},
                icon: FaIcon(FontAwesomeIcons.facebookF),
                iconSize: 35,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Don’t have an account?',
                  style: TextStyle(
                    color: icon,
                    fontSize: 16,
                  )),
              SizedBox(
                height: 20,
              ),
              Text(' Sign up!',
                  style: TextStyle(
                      color: red, fontSize: 17, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }
}
