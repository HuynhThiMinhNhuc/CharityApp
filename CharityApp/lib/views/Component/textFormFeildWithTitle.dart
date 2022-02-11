import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class textFormFieldWithTitle extends StatelessWidget {
  final String title;
  final String text;
  final Icon? iconData;
  final TextInputType type;
  final TextEditingController controller;
  final Function()? onClickIcon;
  const textFormFieldWithTitle({
    Key? key,
    required this.title,
    required this.text,
    required this.iconData,
    required this.type,
    required this.controller,
    this.onClickIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: kText15Bold80Black,
          ),
          TextFormField(
            controller: controller,
            cursorColor: maincolor,
            style: kText15RegularBlack,
            keyboardType: type,
            decoration: new InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: maincolor),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: maincolor,
                  ),
                ),
                suffixIcon: iconData != null
                    ? IconButton(
                        onPressed: () => onClickIcon?.call(),
                        icon: iconData!,
                        iconSize: 20.w,
                      )
                    : null,
                label: null),
          ),
          SizedBox(height: 7)
        ],
      ),
    );
  }
}
