import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';

class splash1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Color(0xFFA8E0B4)
      ),
      child: 
      Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'asset/logo.png',
                width: 220,
              ),
              Text(
                'MEER',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lobster',
                    fontSize: 65,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none),
              ),
              SizedBox(
                height: 100,
              )
            ]),
      ),
    );
  }
}
