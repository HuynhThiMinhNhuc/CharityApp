import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCardView extends StatelessWidget {
  final EventOverviewPaticipants eventOverviewPaticipants;
  const EventCardView({
    Key? key,
    required this.eventOverviewPaticipants,
  }) : super(key: key);

  final String image =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80";
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Card(
        child: Column(
          children: <Widget>[
            Row(children: [
              Container(
                width: 90.w,
                height: 70.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: (eventOverviewPaticipants.backgroundUri != null &&
                              eventOverviewPaticipants.backgroundUri != "")
                          ? NetworkImage(
                              eventOverviewPaticipants.backgroundUri ?? image)
                          : AssetImage("asset/background.png") as ImageProvider,
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: SizedBox(
                      width: _width - 150.w,
                      child: Text(eventOverviewPaticipants.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kText15BoldBlack),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  if (eventOverviewPaticipants.timeStart != null)
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: eventOverviewPaticipants.timeStart!.hour
                                  .toString() +
                              ":" +
                              eventOverviewPaticipants.timeStart!.minute
                                  .toString(),
                          style: kText13RegularRed),
                      TextSpan(
                        text: ", " +
                            eventOverviewPaticipants.timeStart!.day.toString() +
                            "/" +
                            eventOverviewPaticipants.timeStart!.month
                                .toString() +
                            "/" +
                            eventOverviewPaticipants.timeStart!.year.toString(),
                        style: kText13RegularGreyText,
                      )
                    ]))
                ],
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Người tham gia ",
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: kText13RegularGreyText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 8),
                  child: Stack(children: [
                    SizedBox(
                      width: 60.w,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(image), radius: 15.h),
                    ),
                    Positioned(
                        right: 10.w,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(image),
                            radius: 15.h)),
                    Positioned(
                        right: 20.w,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(image),
                            radius: 15.h)),
                    Positioned(
                        right: 30.w,
                        child: CircleAvatar(
                            radius: 15.h,
                            backgroundColor: maincolor,
                            child: Text(
                              "+" + eventOverviewPaticipants.number.toString(),
                              style: kText13BoldWhite,
                            ))),
                  ]),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
