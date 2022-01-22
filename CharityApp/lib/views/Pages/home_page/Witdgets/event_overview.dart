import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/core/model/event_page_state.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/my_alert_dialog_2.dart';
import 'package:charityapp/views/bloc/event_bloc/event.dart';
import 'package:charityapp/views/bloc/form_bloc/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  height: 210.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: (state.event.backgroundUri == "" ||
                                state.event.backgroundUri == null)
                            ? AssetImage("asset/background.png")
                                as ImageProvider
                            : NetworkImage(state.event.backgroundUri!),
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
                  left: 10.w,
                  top: 30.h,
                ),
                Positioned(
                  bottom: -65.h,
                  left: 5.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 90.h,
                        height: 90.h,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: activecolor),
                        ),
                        child: Container(
                          width: 86.h,
                          height: 86.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            image: DecorationImage(
                                alignment: Alignment(0, -0.8.h),
                                image: (state.event.avatarUri != "" &&
                                        state.event.avatarUri != null)
                                    ? NetworkImage(state.event.avatarUri!)
                                    : AssetImage('asset/avatar.png')
                                        as ImageProvider,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                        width: c_width - 110.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 35.h,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                state.event.name,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: kText20BoldBlack,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
              SizedBox(height: 65.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconOverview(Icons.people, state.event.numberMember),
                  IconOverview(Icons.post_add, state.event.numberPost),
                  SizedBox(width: 10.w),

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
                              showUnRegisterForm(
                                  context, 'Bạn có chắc hủy đăng ký form?');
                            }
                          } else {
                            //Out event
                            showUnRegisterForm(
                                context, 'Bạn có chắc thoát khỏi sự kiện này?');
                          }
                        },
                        child: Text(
                          isJoin()
                              ? "Hủy tham gia"
                              : state.permission == EventPermission.pending
                                  ? "Đang đợi"
                                  : "Tham gia",
                          style: kText13BoldWhite,
                        ),
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          fixedSize: Size(130.w, 30.h),
                          primary: !isJoin() ? maincolor : Colors.red,
                        )),
                    SizedBox(
                      width: 20.w,
                    )
                  ]
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20.w, right: 20.w, top: 0, bottom: 0),
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
          width: 30.h,
          height: 30.h,
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
          style: kText13BoldBlack,
        ),
        SizedBox(
          width: 15.w,
        ),
      ],
    );
  }
}
