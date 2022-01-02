import 'package:charityapp/Constant/user_json.dart';
import 'package:charityapp/domain/entities/event_detail.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IntroductionEventView extends StatelessWidget {
  final EventDetail detail;
  IntroductionEventView({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thông tin chung",
              style: TextStyle(
                  fontFamily: 'Roboto_Regular',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: textcolor),
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
                Text(
                  '${detail.creator.name} đã tạo sự kiện này',
                  style: TextStyle(
                      fontFamily: 'Roboto_Regular',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: textcolor),)
              ],
            ),
            Row(
              children: [
                Icon(Icons.add_task_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "${detail.numberMember.toString()} người đã tham gia sự kiện này",
                  style: TextStyle(
                      fontFamily: 'Roboto_Regular',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: textcolor),)
              ],
            ),
            Row(
              children: [
                Icon(Icons.lock_clock_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                    "Sự kiện sẽ diễn ra vào ngày ${DateFormat('dd/MM/yyyy').format(detail.timeStart!)}",
                    style: TextStyle(
                      fontFamily: 'Roboto_Regular',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: textcolor),)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: null,
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
              ),
              child: Text(
                'Trẻ em',
                style: TextStyle(
                  fontFamily: 'Roboto_Regular',
                  fontSize: 12,
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
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: textcolor),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              detail.description ?? 'Không có câu chuyện',
              style: TextStyle(
                  fontFamily: 'Roboto_Regular',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: textcolor),
            )
          ],
        ),
      ),
    );
  }
}
