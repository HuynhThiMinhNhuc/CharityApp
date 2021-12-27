import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Card(
        child: Column(
          children: <Widget>[
            Row(children: [
              Container(
                width: 90,
                height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(eventOverviewPaticipants.backgroundUri ?? image), fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      width: _width - 150,
                      child: Text(eventOverviewPaticipants.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Roboto-Regular.ttf',
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(height: 5),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: eventOverviewPaticipants.timeStart.hour.toString() +
                            ":" +
                            eventOverviewPaticipants.timeStart.minute.toString(),
                        style: TextStyle(
                          fontFamily: 'Roboto-Regular.ttf',
                          fontSize: 13,
                          color: Colors.red,
                        )),
                    TextSpan(
                      text: ", " +
                          eventOverviewPaticipants.timeStart.day.toString() +
                          "/" +
                          eventOverviewPaticipants.timeStart.month.toString() +
                          "/" +
                          eventOverviewPaticipants.timeStart.year.toString(),
                      style: TextStyle(
                        fontFamily: 'Roboto-Regular.ttf',
                        fontSize: 13,
                        color: Colors.grey,
                      ),
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
                    style: TextStyle(
                        fontFamily: 'Roboto-Regular.ttf',
                        fontSize: 13,
                        color: Color(0xFFA6A6AA)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 8),
                  child: Stack(children: [
                    SizedBox(
                      width: 60,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(image), radius: 15),
                    ),
                    Positioned(
                        right: 10,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(image), radius: 15)),
                    Positioned(
                        right: 20,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(image), radius: 15)),
                    Positioned(
                        right: 30,
                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor: maincolor,
                            child: Text(
                              "+" + eventOverviewPaticipants.number.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
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
