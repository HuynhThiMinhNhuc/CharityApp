import 'package:charityapp/Config/colorconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ModeDialog { warning, anounce }

class DialogWithCircleAbove extends StatelessWidget {
  final String title;
  final String content;
  final ModeDialog mode;

  DialogWithCircleAbove(
      {Key? key,
      required this.title,
      required this.content,
      required this.mode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 200,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.w, 70.h, 10.w, 10.h),
                child: Column(
                  children: [
                    Text(
                      this.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.sp),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      this.content,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            this.mode == ModeDialog.warning
                                ? cwColorRed
                                : cwColorMain),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Đồng ý',
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: -50,
                child: CircleAvatar(
                  backgroundColor: this.mode == ModeDialog.warning
                      ? cwColorRed
                      : cwColorMain,
                  radius: 60.h,
                  child: Icon(
                    this.mode == ModeDialog.warning
                        ? Icons.warning
                        : Icons.announcement,
                    color: Colors.white,
                    size: 50.h,
                  ),
                )),
          ],
        ));
  }
}
