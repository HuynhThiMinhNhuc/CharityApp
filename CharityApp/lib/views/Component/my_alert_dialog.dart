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
      contentPadding: EdgeInsets.zero,
      //backgroundColor: Color(0xFFE5F1E8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Image.asset(
              pathImage,
              fit: BoxFit.fill,
              height: 300,
              width: 300,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF295632)),
          ),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF295632)),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        OutlinedButton(
          onPressed: () => Navigator.pop(context, 'Đồng ý'),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
            child: const Text(
              'Đồng ý',
              style: TextStyle(color: maincolor, fontSize: 20),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(width: 2, color: maincolor),
            )),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
