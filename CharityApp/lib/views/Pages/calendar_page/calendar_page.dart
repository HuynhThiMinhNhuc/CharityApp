import 'package:flutter/cupertino.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({ Key? key }) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
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