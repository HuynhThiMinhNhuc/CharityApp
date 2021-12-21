import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          TextButton.icon(
              onPressed: () => {},
              icon: FaIcon(
                FontAwesomeIcons.checkCircle,
                color: maincolor,
                size: 36,
              ),
              label: Text(
                'Registration Successful',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto-Regular.ttf',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            'Welcome to Charity',
            style: TextStyle(
                color: maincolor,
                fontSize: 35,
                fontFamily: 'Roboto_Regular',
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
                ' To abandon or ignore something, such as a project, company, plan, etc., because it is expected to fail or is not important enough to succeed. The noun or pronoun can also come after I am worried that this glitch will cause investors to give up our company for dead.We tried our best to get into the smartphone racket, but after we failed to gain any real traction in the market, app developers gave our new operating system up for dead after just six months',
                maxLines: 4,
                style: TextStyle(
                  color: notetextcolor,
                  fontFamily: 'Roboto-Regular.tff',
                  fontSize: 18,
                )),
          ),
          Image(
            image: AssetImage('asset/welcome.png'),
            width: 450,
          ),
          SizedBox(
            height: 20,
          ),
          CustomButton(onPressed: () => {}, textInput: 'GET STARTED')
        ],
      ),
    );
  }
}
