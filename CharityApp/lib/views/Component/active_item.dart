import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveItem extends StatelessWidget {
  final String imgUrl;
  final String imgName;
  const ActiveItem({Key? key, required this.imgUrl, required this.imgName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: Column(
        children: <Widget>[
          Container(
            width: 61.h,
            height: 61.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: activecolor)),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                width: 60.h,
                height: 60.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  image: DecorationImage(
                      // ignore: unnecessary_null_comparison
                      image: imgUrl == ""
                          ? AssetImage('asset/avatar.png') as ImageProvider
                          : NetworkImage(imgUrl),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 70.h,
            child: Text(imgName,
                textAlign: TextAlign.center, style: kText12RegularBlack),
          )
        ],
      ),
    );
  }
}
