import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShortInforCard extends StatefulWidget {
  final UserOverview userOverview;
  final bool isFollow;
  const ShortInforCard(
      {Key? key, required this.userOverview, required this.isFollow})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ShortInforCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Container(
          child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: activecolor)),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: widget.userOverview.avatarUri == null
                        ? AssetImage('asset/avatar.png') as ImageProvider
                        : NetworkImage(widget.userOverview.avatarUri!)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userOverview.name,
                  style: TextStyle(
                    color: textcolor,
                    fontSize: 15,
                  ),
                ),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  widget.isFollow
                      ? TextSpan(
                          text: "Đang theo dõi - ",
                          style: TextStyle(
                            color: maincolor,
                            fontSize: 15,
                          ))
                      : TextSpan(),
                  TextSpan(
                      text: widget.userOverview.address,
                      style: TextStyle(color: Color(0x40000000), fontSize: 13))
                ]))
              ],
            ),
          )
        ],
      )),
    );
  }
}
