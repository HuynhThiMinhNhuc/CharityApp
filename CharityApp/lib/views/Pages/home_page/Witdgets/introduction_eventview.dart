import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/domain/entities/event_detail.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroductionEventView extends StatelessWidget {
  final EventDetail detail;
  IntroductionEventView({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80.w,
                  child: Text(
                    "Thông tin chung",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kText18BoldBlack,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Icon(Icons.people_outline),
                SizedBox(
                  width: 5.w,
                ),
                Text.rich(TextSpan(
                    text: " " + '${detail.creator.name}',
                    style: kText15RegularBlue,
                    children: [
                      TextSpan(
                          text: " đã tạo sự kiện này",
                          style: kText15RegularBlack),
                    ]))
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Icon(Icons.add_task_outlined),
                SizedBox(
                  width: 5.h,
                ),
                Text(
                  " " +
                      "${detail.numberMember.toString()} người đã tham gia sự kiện này",
                  style: kText15RegularBlack,
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Icon(Icons.lock_clock_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  " Ngày tổ chức: " +
                      (detail.timeCreate != null
                          ? 'Không có'
                          : '${DateFormat('dd/MM/yyyy').format(detail.timeCreate!)}'),
                  style: kText15RegularBlack,
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  detail.tags.length,
                  (index) => Padding(
                    padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
                    child: Chip(label: Text(detail.tags[index].name)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Câu chuyện",
              style: kText18BoldBlack,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              detail.description ?? 'Không có câu chuyện',
              style: kText15RegularBlack,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Thời gian, địa điểm",
              style: kText18BoldBlack,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text.rich(
              TextSpan(text: 'Thời gian: ', style: kText15BoldBlack, children: [
                TextSpan(
                    text: detail.timeStart != null
                        ? DateFormat('dd/MM/yyyy').format(detail.timeStart!)
                        : 'Chưa xác định',
                    style: kText15RegularBlack)
              ]),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text.rich(
              TextSpan(text: 'Địa điểm: ', style: kText15BoldBlack, children: [
                TextSpan(
                    text: detail.location ?? 'Không có địa điểm',
                    style: kText15RegularBlack)
              ]),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   "Yêu cầu",
            //   style: TextStyle(
            //       fontFamily: 'Roboto_Regular',
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //       color: textcolor),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   detail.description ?? 'Không có câu chuyện',
            //   style: TextStyle(
            //       fontFamily: 'Roboto_Regular', fontSize: 15, color: textcolor),
            // ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Thông tin liên hệ",
              style: kText18BoldBlack,
            ),
            SizedBox(
              height: 10,
            ),
            Text.rich(
              TextSpan(text: 'Email: ', style: kText15BoldBlack, children: [
                TextSpan(
                    text: Authenticator.profile.email,
                    style: kText15RegularBlack)
              ]),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text.rich(
              TextSpan(
                  text: 'Số điện thoại: ',
                  style: kText15BoldBlack,
                  children: [
                    TextSpan(
                        text: Authenticator.profile.phone,
                        style: kText15RegularBlack)
                  ]),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            // Text.rich(
            //   TextSpan(
            //       text: 'Facebook: ',
            //       style: TextStyle(
            //           fontFamily: 'Roboto_Regular',
            //           fontSize: 15,
            //           fontWeight: FontWeight.bold,
            //           color: textcolor),
            //       children: [
            //         TextSpan(
            //             text: '',
            //             style: TextStyle(
            //                 fontFamily: 'Roboto_Regular',
            //                 fontSize: 18,
            //                 fontWeight: FontWeight.bold,
            //                 color: textcolor))
            //       ]),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
          ],
        ),
      ),
    );
  }
}
