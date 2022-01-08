import 'package:charityapp/Constant/user_json.dart';
import 'package:charityapp/domain/entities/event_detail.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class IntroductionEventView extends StatelessWidget {
  final EventDetail detail;
  IntroductionEventView({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isReadonly = true;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: Text(
                    "Thông tin chung",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: 'Roboto_Regular',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textcolor),
                  ),
                ),
                IconButton(onPressed: () => {}, icon: Icon(Icons.edit))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(Icons.people_outline),
                SizedBox(
                  width: 5,
                ),
                Text.rich(TextSpan(
                    text: " " + '${detail.creator.name}',
                    style: TextStyle(
                        color: Color(0xFF124ADA),
                        decoration: TextDecoration.underline,
                        fontSize: 15),
                    children: [
                      TextSpan(
                          text: " đã tạo sự kiện này",
                          style: TextStyle(
                              fontSize: 15,
                              color: textcolor,
                              decoration: TextDecoration.none)),
                    ]))
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(Icons.add_task_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  " " +
                      "${detail.numberMember.toString()} người đã tham gia sự kiện này",
                  style: TextStyle(
                      fontFamily: 'Roboto_Regular',
                      fontSize: 15,
                      color: textcolor),
                )
              ],
            ),
            SizedBox(
              height: 5,
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
                  style: TextStyle(
                      fontFamily: 'Roboto_Regular',
                      fontSize: 15,
                      color: textcolor),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  detail.tags.length,
                  (index) => Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Chip(label: Text(detail.tags[index].name)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Câu chuyện",
              style: TextStyle(
                  fontFamily: 'Roboto_Regular',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textcolor),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              detail.description ?? 'Không có câu chuyện',
              style: TextStyle(
                  fontFamily: 'Roboto_Regular', fontSize: 15, color: textcolor),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Thời gian, địa điểm",
              style: TextStyle(
                  fontFamily: 'Roboto_Regular',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textcolor),
            ),
            SizedBox(
              height: 10,
            ),
            Text.rich(
              TextSpan(
                  text: 'Thời gian: ',
                  style: TextStyle(
                      fontFamily: 'Roboto_Regular',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textcolor),
                  children: [
                    TextSpan(
                        text: detail.timeStart != null
                            ? DateFormat('dd/MM/yyyy').format(detail.timeStart!)
                            : 'Chưa xác định',
                        style: TextStyle(
                            fontFamily: 'Roboto_Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: textcolor))
                  ]),
            ),
            SizedBox(
              height: 5,
            ),
            Text.rich(
              TextSpan(
                  text: 'Địa điểm: ',
                  style: TextStyle(
                      fontFamily: 'Roboto_Regular',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textcolor),
                  children: [
                    TextSpan(
                        text: detail.location ?? 'Không có địa điểm',
                        style: TextStyle(
                            fontFamily: 'Roboto_Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: textcolor))
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
              style: TextStyle(
                  fontFamily: 'Roboto_Regular',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textcolor),
            ),
            SizedBox(
              height: 10,
            ),
            Text.rich(
              TextSpan(
                  text: 'Email: ',
                  style: TextStyle(
                      fontFamily: 'Roboto_Regular',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textcolor),
                  children: [
                    TextSpan(
                        text: Authenticator.profile.email,
                        style: TextStyle(
                            fontFamily: 'Roboto_Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: textcolor))
                  ]),
            ),
            SizedBox(
              height: 5,
            ),
            Text.rich(
              TextSpan(
                  text: 'Số điện thoại: ',
                  style: TextStyle(
                      fontFamily: 'Roboto_Regular',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textcolor),
                  children: [
                    TextSpan(
                        text: Authenticator.profile.phone,
                        style: TextStyle(
                            fontFamily: 'Roboto_Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: textcolor))
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
