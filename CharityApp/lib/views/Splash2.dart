import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';

class splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('asset/splash2.PNG'),
        fit: BoxFit.fill,
      )),
      child: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 170,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                  'If love means anything at all it means extending your hand to the unlovable',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w100,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Quentin Crisp      .',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.none,
                    fontFamily: 'Roboto_thin',
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      primary: maincolor,
                      fixedSize: Size(MediaQuery.of(context).size.width, 63),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              )
            ]),
      ),
    );
  }
}
