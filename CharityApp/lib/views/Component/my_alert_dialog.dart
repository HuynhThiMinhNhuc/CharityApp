import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String pathImage;
  final String title;
  final String content;
  const MyAlertDialog(
      {Key? key,
      required this.content,
      required this.pathImage,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Image.asset(pathImage,
                width: 250, height: 200, fit: BoxFit.fill),
          ),
          Text(title),
        ],
      ),
      content: Text(content),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Đồng ý'),
          child: const Text(
            'Đồng ý',
            style: TextStyle(color: maincolor, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
