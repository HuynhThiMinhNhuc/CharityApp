import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';

class AlerDialog extends StatelessWidget {
  final String title;
  final String description;
  final bool ok = true;
  final bool cancel = false;
  final bool no = true;
  final imagepath;
  final Function onCancel = () => {};
  final Function onOk = () => {};
  final Function onNo = () => {};

  AlerDialog(
      {Key? key,
      required this.description,
      required this.title,
      this.imagepath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 350,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  imagepath,
                  height: 120,
                  width: 120,
                ),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Text(
                  description,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  (cancel == no && no == false)
                      ? TextButton(
                          onPressed: () {
                            onOk.call();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Đồng ý",
                            style: TextStyle(
                                color: maincolor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto_Regular",
                                fontSize: 20),
                          ),
                        )
                      : (cancel == no && no == true)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    onOk.call();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Đồng ý",
                                    style: TextStyle(
                                        color: maincolor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto_Regular",
                                        fontSize: 20),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    onNo.call();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Từ chối",
                                    style: TextStyle(
                                        color: redcolor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto_Regular",
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    onOk.call();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Đồng ý",
                                    style: TextStyle(
                                        color: maincolor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto_Regular",
                                        fontSize: 20),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    onCancel.call();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Hủy",
                                    style: TextStyle(
                                        color: maincolor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto_Regular",
                                        fontSize: 20),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    onNo.call();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Từ chối",
                                    style: TextStyle(
                                        color: red,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto_Regular",
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            )
                ],
              ),
            )
          ],
        ),
      );
}
