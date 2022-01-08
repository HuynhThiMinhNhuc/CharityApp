import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';

class MyAlertDialog2 extends StatelessWidget {
  final String? pathImage;
  final void Function()? onTabYes;
  final void Function()? onTabNo;
  final String title;
  final String content;
  final bool isTwoActions;

  const MyAlertDialog2({
    Key? key,
    required this.content,
    this.pathImage,
    required this.title,
    this.onTabYes,
    this.onTabNo,
    this.isTwoActions = true,
  }) : super(key: key);

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
          if (pathImage != null)
            Image.asset(
              pathImage!,
              fit: BoxFit.fill,
              height: 280,
              width: 300,
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

        if (isTwoActions) Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
          child: _getButton(context, 'Hủy', onTabNo),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
          child: _getButton(context, 'Đồng ý', onTabYes)
        ),
      ],
    );
  }

  OutlinedButton _getButton(BuildContext context, String name, Function()? onClick) {
    return OutlinedButton(
          onPressed: onClick ?? () => Navigator.of(context).pop(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
            child: Text(
              name,
              style: const TextStyle(color: maincolor, fontSize: 15),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(width: 1, color: maincolor),
            )),
          ),
        );
  }
}
