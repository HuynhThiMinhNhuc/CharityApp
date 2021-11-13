import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActiveItem extends StatelessWidget {
  final String imgUrl;
  final String imgName;
  const ActiveItem({
    Key? key, required this.imgUrl, required this.imgName

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: Column(
        children: <Widget>[
          Container(
            width: 61,
            height: 61,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: activecolor)),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  image: DecorationImage(
                      image: NetworkImage(imgUrl),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 70,
            child: Text(
              imgName,
              textAlign: TextAlign.center,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: textcolor,
                fontSize: 12,
                decoration: TextDecoration.none,
                fontFamily: 'Roboto_Regular',
              ),
            ),
          )
        ],
      ),
    );
  }
}
