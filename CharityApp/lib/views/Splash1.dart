import 'package:flutter/material.dart';

class splash1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('asset/splash1.PNG'),
        fit: BoxFit.fill,
      )),
      child: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'asset/logo.png',
                width: 250,
              ),
              Text(
                'Charity app',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lobster',
                    fontSize: 65,
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
