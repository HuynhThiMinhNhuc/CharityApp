import 'package:charityapp/Constant/active_json.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/ActiveItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return getbody();
  }

  getbody() {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 0, 15),
        child: SizedBox(
          width: double.infinity,
          child: Text("Hoạt động tích cực",
              textAlign: TextAlign.start,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: textcolor,
                  fontSize: 18,
                  decoration: TextDecoration.none,
                  fontFamily: 'Roboto_Regular',
                  fontWeight: FontWeight.bold)),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(actives.length, (index) {
          return ActiveItem( 
            img: actives[index]['img'],
            name: actives[index]['name']
           );
        })),
      )
    ]);
  }
}

