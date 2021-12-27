import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/add_event_page/Witgets/event_card_view.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChossesEventView extends StatelessWidget {
  final Function(EventOverview event)? onClick;
  const ChossesEventView({Key? key, this.onClick}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostsLoadOverviewSuccess) {
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
                              eventOverviewPaticipants: events[index],
                            ),
                            onTap: () {
                              Navigator.of(context).pop(events[index]);
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            } else if (state is PostsLoadInProgress) {
              return Text('Loading...');
            }
            return Text('Load fail');
          },
        ));
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: backgroundbottomtab,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: textcolor, //change your color here
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
