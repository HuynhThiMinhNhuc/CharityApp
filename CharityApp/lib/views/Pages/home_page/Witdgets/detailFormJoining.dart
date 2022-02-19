import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/form_register.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/home_page/form_view.dart';
import 'package:charityapp/views/Pages/profile_page/Widgets/information_profile_view.dart';
import 'package:charityapp/views/Pages/profile_page/profile_other.dart';
import 'package:charityapp/views/bloc/form_bloc/form.dart' as bloc;
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

enum mode { Joiner, Pending_approval }

class DetailFormJoinings extends StatefulWidget {
  final UserProfile userProfile;
  final FormRegister formDetail;
  const DetailFormJoinings(
      {Key? key, required this.userProfile, required this.formDetail})
      : super(key: key);

  @override
  _DetailFormJoiningsState createState() => _DetailFormJoiningsState();
}

class _DetailFormJoiningsState extends State<DetailFormJoinings> {
  List<TextEditingController> listTextController = [];

  @override
  void initState() {
    super.initState();
    listTextController.add(TextEditingController(text: widget.formDetail.name));
    listTextController
        .add(TextEditingController(text: widget.formDetail.phone));
    listTextController
        .add(TextEditingController(text: widget.formDetail.email));

    for (int i = 0; i < widget.formDetail.questions.length; i++) {
      listTextController
          .add(TextEditingController(text: widget.formDetail.questions[i]));
    }
  }

  @override
  void dispose() {
    listTextController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 60) / 2;
    BuildContext detailFormContext = context;
    return BlocListener<bloc.FormBloc, bloc.FormState>(
      listener: (context, state) {
        if (state is bloc.FormSuccess) {
          Navigator.of(context).popUntil(ModalRoute.withName(AppRoutes.eventPage));
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundBottomTab,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Đang chờ duyệt",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: JoinerOverview(widget.userProfile,
                        mode.Pending_approval, width, detailFormContext),
                  ),
                  Divider(
                    color: Colors.black54,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Câu trả lời form",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  getbody(widget.userProfile)
                ],
              ),
            ),
          )),
    );
  }

  Column JoinerOverview(UserProfile joinerProfile, mode modeJoiner,
      double width, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            //Avatar widget
            InkWell(
              child: Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: activecolor)),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (joinerProfile.avatarUri != ""&& joinerProfile.avatarUri != null)
                          ? NetworkImage(joinerProfile.avatarUri!)
                              as ImageProvider
                          : AssetImage('asset/avatar.png'),
                    ),
                  ),
                ),
              ),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => OverViewUserBloc(),
                              child:
                                  ProfileOtherPage(creator: joinerProfile),
                            )))
              },
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InformationProfileView(joinerProfile.numberPost, "Bài viết"),
                  InformationProfileView(
                      joinerProfile.numberFollower, "Theo dõi"),
                  InformationProfileView(
                      joinerProfile.numberFollowing, "Đang theo dõi"),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: RichText(
            text: TextSpan(style: myStyle(), children: <TextSpan>[
              TextSpan(
                text: 'Họ và tên: ',
                style: myStyle(isBold: true),
              ),
              TextSpan(
                text: joinerProfile.name,
              ),
            ]),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: RichText(
            text: TextSpan(style: myStyle(), children: <TextSpan>[
              TextSpan(
                text: 'Ngày sinh: ',
                style: myStyle(isBold: true),
              ),
              TextSpan(
                text: DateFormat("dd/MM/yyyy")
                    .format(joinerProfile.birthDay as DateTime),
              )
            ]),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          child: Text(
            joinerProfile.description as String,
            style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontFamily: 'Roboto_Regular',
                color: textColor),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: modeJoiner == mode.Joiner
              ? ElevatedButton(
                  onPressed: () => {setState(() {})},
                  child: Text(
                    'Loại khỏi sự kiện',
                    style: TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontFamily: 'Roboto_Regular',
                        fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(redcolor)),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: width,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<bloc.FormBloc>(context).add(bloc.ConfirmForm(
                              eventId: widget.formDetail.eventId,
                              userId: widget.formDetail.creatorId,
                              isConfirm: true));
                        },
                        child: Text(
                          'Chấp nhận',
                          style: TextStyle(
                              fontSize: 13,
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto_Regular',
                              fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(90, 164, 105, 1.0))),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<bloc.FormBloc>(context).add(bloc.ConfirmForm(
                              eventId: widget.formDetail.eventId,
                              userId: widget.formDetail.creatorId,
                              isConfirm: false));
                        },
                        child: Text(
                          'Từ chối',
                          style: TextStyle(
                              fontSize: 13,
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto_Regular',
                              fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(redcolor)),
                      ),
                    )
                  ],
                ),
        ),
      ],
    );
  }

  Widget getbody(UserProfile joiner) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: FormBody(
          listController: listTextController,
          isReadonly: true,
        ),
      ),
    );
  }

  TextStyle myStyle({bool isBold = false}) {
    return TextStyle(
        color: textColor,
        fontSize: 15,
        decoration: TextDecoration.none,
        fontFamily: 'Roboto_Regular',
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal);
  }
}
