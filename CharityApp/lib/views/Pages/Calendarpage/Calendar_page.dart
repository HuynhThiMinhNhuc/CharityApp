import 'package:flutter/cupertino.dart';

class calendar_page extends StatefulWidget {
  const calendar_page({ Key? key }) : super(key: key);

  @override
  _calendar_pageState createState() => _calendar_pageState();
}

class _calendar_pageState extends State<calendar_page> {
  @override
  Widget build(BuildContext context) {
    return getbody();
  }

  Widget getbody(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: (
        Column(
          children: <Widget>[
            
    
          ],
        )
      ),
    );
  }
}