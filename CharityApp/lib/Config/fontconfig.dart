import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colorconfig.dart';

const fontFamily = "Roboto-Regular.ttf";

/// cách đặt tên kText[$font_size]_[$style]_[$Color]

var kTextConfig = TextStyle(
    fontSize: ScreenUtil().setSp(20.sp),
    fontWeight: FontWeight.normal,
    color: cwColorBlack,
    fontFamily: fontFamily);

var kText24BoldBlack = kTextConfig.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: ScreenUtil().setSp(24.sp),
);
var kText24RegularBlack = kTextConfig.copyWith(
  fontSize: ScreenUtil().setSp(24.sp),
);
var kText18RegularGreyNoteText = kTextConfig.copyWith(
  fontSize: ScreenUtil().setSp(18.sp),
  color: cwColorGreyNoteText,
);
var kText14BoldMainColor = kTextConfig.copyWith(
    color: cwColorMain, fontSize: 14.sp, fontWeight: FontWeight.w600);
var kText18BoldWhite = kTextConfig.copyWith(
    color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600);
var kText15RegularGreyText =
    kTextConfig.copyWith(color: cwColorGreyText, fontSize: 15.sp);
var kText15RegularBlack =
    kTextConfig.copyWith(color: cwColorBlack, fontSize: 15.sp);
var kText15RegularMain =
    kTextConfig.copyWith(color: cwColorMain, fontSize: 15.sp);
var kText16RegularGreyText =
    kTextConfig.copyWith(color: cwColorGreyText, fontSize: 16.sp);
var kText17RegularRed =
    kTextConfig.copyWith(fontSize: 17.sp, color: cwColorRed);
var kText17RegularBlack =
    kTextConfig.copyWith(fontSize: 17.sp, color: cwColorBlack);
var kText17BoldBlack = kTextConfig.copyWith(
    fontSize: 17.sp, color: cwColorBlack, fontWeight: FontWeight.bold);
var kText18BoldBlack = kTextConfig.copyWith(
  fontSize: 18.sp,
  color: cwColorBlack,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.bold,
  overflow: TextOverflow.ellipsis,
);
var kText18BoldMain = kTextConfig.copyWith(
  fontSize: 18.sp,
  color: cwColorMain,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.bold,
  overflow: TextOverflow.ellipsis,
);
var kText28BoldGreyNoteText = kTextConfig.copyWith(
  fontSize: 24.sp,
  color: cwColorGreyNoteText,
  decoration: TextDecoration.none,
  overflow: TextOverflow.ellipsis,
);
var kText12RegularBlack = kTextConfig.copyWith(
  fontSize: 12.sp,
  color: cwColorBlack,
  decoration: TextDecoration.none,
  overflow: TextOverflow.ellipsis,
);

var kText38BoldMain = kTextConfig.copyWith(
  fontSize: 38.sp,
  color: cwColorMain,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.bold,
);
var kText15BoldGreyHintText = kTextConfig.copyWith(
  fontSize: 15.sp,
  color: cwColorGreyHintText,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
);
var kText15Bold80Black = kTextConfig.copyWith(
  fontSize: 15.sp,
  color: cwColor80Black,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w600,
);
var kText40BoldMain = kTextConfig.copyWith(
  fontSize: 40.sp,
  color: cwColorMain,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.bold,
);
var kText15BoldMain = kTextConfig.copyWith(
    color: cwColorMain, fontSize: 15.sp, fontWeight: FontWeight.w500);
var kText15BoldBlack = kTextConfig.copyWith(
    color: cwColorBlack, fontSize: 15.sp, fontWeight: FontWeight.w500);
var kText15BoldRed = kTextConfig.copyWith(
    color: cwColorRed, fontSize: 15.sp, fontWeight: FontWeight.w500);
var kText16BoldBlack = kTextConfig.copyWith(
    color: cwColorBlack, fontSize: 16.sp, fontWeight: FontWeight.w600);
var kText13BoldBlack = kTextConfig.copyWith(
    fontSize: 13.sp, color: cwColorBlack, fontWeight: FontWeight.w600);
var kText13RegularBlack =
    kTextConfig.copyWith(fontSize: 13.sp, color: cwColorBlack);
var kText13RegularRed =
    kTextConfig.copyWith(fontSize: 13.sp, color: cwColorRed);
var kText13BoldWhite = kTextConfig.copyWith(
    fontSize: 13.sp, color: cwColorWhite, fontWeight: FontWeight.w600);
var kText20BoldBlack = kTextConfig.copyWith(
    fontSize: 20.sp, color: cwColorBlack, fontWeight: FontWeight.w600);
var kText20RegularBlack =
    kTextConfig.copyWith(fontSize: 20.sp, color: cwColorBlack);
var kText13RegularGreyText =
    kTextConfig.copyWith(fontSize: 13.sp, color: cwColorGreyText);
var kText15RegularBlue = kTextConfig.copyWith(
    color: Color(0xFF124ADA),
    decoration: TextDecoration.underline,
    fontSize: 15);
