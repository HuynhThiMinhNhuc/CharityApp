import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/add_event_page/Witgets/event_card_view.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class ChossesEventView extends StatelessWidget {
  const ChossesEventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            state as PostsLoadOverviewSuccess;
            final events = state.eventsOverview;
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: events.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: EventCardView(
                              eventOverviewPaticipants: events[index]),
                          onTap: () => Navigator.of(context).pop(events[index]),
                        );
                      },
                    ),
                    if (state.isLoading) SketonChosseEvent()
                  ],
                ),
              ),
            );
          },
        ));
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: backgroundBottomTab,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: textColor, //change your color here
      ),
      title: Text(
        "Chọn sự kiện",
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto_Regular',
            fontSize: 19,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

class SketonChosseEvent extends StatelessWidget {
  const SketonChosseEvent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SkeletonLoader(
        builder: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                Row(children: [
                  Container(
                    width: 90,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                        child: Container(
                          width: MediaQuery.of(context).size.width - 150,
                          height: 15,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                          height: 15,
                          width: MediaQuery.of(context).size.width - 300,
                          color: Colors.white)
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
                          child: CircleAvatar(radius: 15),
                        ),
                        Positioned(right: 10, child: CircleAvatar(radius: 15)),
                        Positioned(right: 20, child: CircleAvatar(radius: 15)),
                        Positioned(
                            right: 30,
                            child: CircleAvatar(
                              radius: 15,
                            )),
                      ]),
                    )
                  ],
                )
              ],
            )),
        items: 6,
        period: Duration(seconds: 2),
        highlightColor: Color(0x505AA469),
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}
