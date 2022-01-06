import 'package:charityapp/Constant/post_jason.dart';
import 'package:charityapp/core/model/event_page_state.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/my_alert_dialog.dart';
import 'package:charityapp/views/Component/my_alert_dialog_2.dart';
import 'package:charityapp/views/Pages/home_page/event_page.dart';
import 'package:charityapp/views/bloc/activeuser_bloc/activeuser_bloc.dart';
import 'package:charityapp/views/bloc/editprofile_bloc/bloc/editprofile_bloc.dart';
import 'package:charityapp/views/bloc/event_bloc/event.dart';
import 'package:charityapp/views/bloc/form_bloc/form.dart';
import 'package:charityapp/views/bloc/friend_bloc/friend_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/tab_bloc/tab_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Root_App.dart';

class EventOverviewCard extends StatelessWidget {
  final String eventId;

  EventOverviewCard({required this.eventId});

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;

    return BlocBuilder<EventTitleCubit, EventTitleSuccess>(
      builder: (context, state) {
        bool isJoin() {
          return state.permission == EventPermission.admin ||
              state.permission == EventPermission.joined;
        }

        return Container(
          child: Column(
            children: [
              Stack(clipBehavior: Clip.none, children: [
                Container(
                  height: 210,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            state.event.backgroundUri ?? post[0]['postImage']),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  left: 10,
                  top: 30,
                ),
                Positioned(
                  bottom: -65,
                  left: 5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: activecolor),
                        ),
                        child: Container(
                          width: 86,
                          height: 86,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            image: DecorationImage(
                                alignment: Alignment(0, -0.8),
                                image: NetworkImage(
                                    state.event.avatarUri ?? post[0]['avatar']),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: c_width - 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 35,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                state.event.name,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Roboto_Regular',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: textcolor),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
              SizedBox(height: 65),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconOverview(Icons.people, state.event.numberMember),
                  IconOverview(Icons.post_add, state.event.numberPost),
                  SizedBox(width: 10),

                  //If not a admin, show button register
                  if (state.permission != EventPermission.admin) ...[
                    ElevatedButton(
                        onPressed: () {
                          if (!isJoin()) {
                            //Open form to register
                            if (state.permission ==
                                EventPermission.notPaticipant) {
                              Navigator.pushNamed(
                                  context, AppRoutes.formRegister,
                                  arguments: state.event);
                            } else {
                              //Unregist form
                              showUnRegisterForm(context,
                                  'Bạn có chắc hủy đăng ký form?');
                            }
                          } else {
                            //Out event
                            showUnRegisterForm(context,
                                'Bạn có chắc thoát khỏi sự kiện này?');
                          }
                        },
                        child: Text(
                          isJoin()
                              ? "Hủy tham gia"
                              : state.permission == EventPermission.pending
                                  ? "Đang đợi"
                                  : "Tham gia",
                          style: TextStyle(
                              fontFamily: 'Roboto_Regular',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          fixedSize: Size(150, 30),
                          primary: !isJoin() ? maincolor : Colors.red,
                        )),
                    SizedBox(
                      width: 20,
                    )
                  ]
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),
                child: Divider(
                  color: const Color(0xFFDDDDDD),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  dynamic showUnRegisterForm(BuildContext context, String content) {
    return showDialog(
      context: context,
      builder: (builder) => MyAlertDialog2(
        content: content,
        title: 'Thông báo',
        onTabYes: () {
          //Unregist form
          BlocProvider.of<FormBloc>(context)
              .add(UnRegisterForm(eventId: eventId, userId: Authenticator.Id));

          BlocProvider.of<EventTitleCubit>(context).load(eventId);
          Navigator.of(context).pop();
        },
        onTabNo: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget IconOverview(IconData icon, int number) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: maincolor,
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 5),
        Text(
          number.toString(),
          style: TextStyle(
              fontFamily: 'Roboto_Regular',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: textcolor),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
