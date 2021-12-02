import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Component/password_input.dart';
import 'package:charityapp/views/Component/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 0, 20),
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
            ' Profile',
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
            'Enter your personal information',
            style: TextStyle(
                color: notetextcolor,
                fontSize: 20,
                fontFamily: 'Roboto_Regular'),
          ),
          SizedBox(
            height: 40,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
              child: Text(
                'Full Name',
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
                icon: FontAwesomeIcons.pen,
                background: Colors.white,
                boder: maincolor,
                hint: '',
                labeltext: '',
              )),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
              child: Text(
                'Birthday',
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
            child: PassWordInput(
              hint: '',
              background: Colors.white,
              boder: maincolor,
              securitytext: true,
              ispass: false,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
              child: Text(
                'Phone Number',
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
                icon: Icons.phone,
                background: Colors.white,
                boder: maincolor,
                hint: '',
                labeltext: '',
              )),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
              child: Text(
                'Gender',
                style: TextStyle(
                    color: maincolor,
                    fontFamily: 'Roboto-Regular.tff',
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    color: backgrountbutton.withOpacity(0.2),
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    child: TextButton.icon(
                        onPressed: () => {},
                        icon: Icon(
                          Icons.male,
                          color: maincolor,
                          size: 40,
                        ),
                        label: Text(
                          'Male',
                          style: TextStyle(
                              color: maincolor,
                              fontFamily: 'Roboto',
                              fontSize: 15),
                        ),
                        style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor: MaterialStateProperty.all<Color>(
                              backgrountbutton.withOpacity(0.2)),
                        )),
                  ),
                  Container(
                    color: backgrountbutton.withOpacity(0.2),
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    child: TextButton.icon(
                        onPressed: () => {},
                        icon: Icon(
                          Icons.female,
                          color: Colors.white,
                          size: 40,
                        ),
                        label: Text(
                          'Female',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 15),
                        ),
                        style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor:
                              MaterialStateProperty.all<Color>(maincolor),
                        )),
                  ),
                ]),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: CustomButton(onPressed: () => {}, textInput: 'SAVE'))
        ],
      ),
    );
  }
}
