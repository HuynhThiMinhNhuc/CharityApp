import 'dart:io';

import 'package:charityapp/Config/colorconfig.dart';
import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/image_card.dart';
import 'package:charityapp/views/Component/my_alert_dialog_2.dart';
import 'package:charityapp/views/Pages/add_event_page/add_event_page.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPostPage extends StatefulWidget {
  final Function(Post post, List<File> images)? onClickSubmit;
  AddPostPage({Key? key, this.onClickSubmit}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  late TextEditingController _titleTextController;
  late TextEditingController _descriptionTextControlelr;
  late TextEditingController _eventNameTextController;
  BaseEvent? chooseEvent;
  final List<File> images = [];

  @override
  void initState() {
    super.initState();
    _titleTextController = TextEditingController();
    _descriptionTextControlelr = TextEditingController();
    _eventNameTextController = TextEditingController();
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _descriptionTextControlelr.dispose();
    _eventNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cwColorBackground,
      appBar: getAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: cwColorWhite),
                child: ChoiceField(
                  title: "Chọn sự kiện",
                  icon: Icons.keyboard_arrow_right_outlined,
                  controller: _eventNameTextController,
                  onPress: () async {
                    BlocProvider.of<PostBloc>(context).add(
                      LoadOverViewEventsPaticipant(
                          events: [],
                          creatorId: Authenticator.Id,
                          startIndex: 0,
                          number: 10),
                    );
                    chooseEvent = await Navigator.of(context).pushNamed(
                      AppRoutes.chooseEvent,
                    ) as BaseEvent?;
                    setState(() => {
                          _eventNameTextController.text =
                              chooseEvent == null ? "" : chooseEvent!.name
                        });
                  },
                ),
              ),
              // TextButton(
              //     onPressed: () async {
              //       BlocProvider.of<PostBloc>(context).add(
              //         LoadOverViewEventsPaticipant(
              //             creatorId: Authenticator.Id,
              //             startIndex: 0,
              //             number: 10),
              //       );
              //       chooseEvent = await Navigator.of(context).pushNamed(
              //         AppRoutes.chooseEvent,
              //       ) as BaseEvent?;
              //       setState(() => {});
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           chooseEvent == null
              //               ? "Chọn sự kiện"
              //               : chooseEvent!.name,
              //           style: kText15BoldBlack,
              //         ),
              //         IconButton(
              //           icon: Icon(Icons.navigate_next,
              //               size: 20, color: textcolor),
              //           splashRadius: 20,
              //           onPressed: null,
              //         )
              //       ],
              //     )),
              // Divider(color: Colors.grey[800], height: 1),
              SizedBox(
                height: 10.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: cwColorWhite,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 15, 0),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hình ảnh",
                              style: kText15BoldBlack,
                            ),
                            Text(
                              "Tối đa 10 ảnh",
                              style: kText13RegularGreyText,
                            )
                          ]),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                ImageCard(
                                  icon: Icons.add_photo_alternate_outlined,
                                  onImageChanged: (imageFile) {
                                    setState(() {
                                      images.length == index
                                          ? images.add(imageFile)
                                          : images[index] = imageFile;
                                    });
                                  },
                                  onImageDeleted: () {
                                    setState(() {
                                      images.removeAt(index);
                                    });
                                  },
                                ),
                                SizedBox(width: 5.w),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: cwColorWhite,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleTextController,
                        style: kText17BoldBlack,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Thêm tiêu đề tại đây"),
                      ),
                      TextFormField(
                        cursorColor: maincolor,
                        keyboardType: TextInputType.name,
                        minLines: 20,
                        maxLines: 30,
                        style: kText15RegularBlack,
                        decoration: InputDecoration(
                            hintText: "Viết nội dung ở đây...",
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none),
                        controller: _descriptionTextControlelr,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: textColor, //change your color here
      ),
      backgroundColor: backgroundBottomTab,
      centerTitle: true,
      title: Text("Tạo bài viết", style: kText18BoldBlack),
      actions: [
        TextButton(
          onPressed: () {
            if (!onValidation()) return;
            final post = Post(
              title: _titleTextController.text,
              description: _descriptionTextControlelr.text,
              eventId: chooseEvent!.id!,
              creator: Authenticator.profile,
            );

            widget.onClickSubmit?.call(post, images);
          },
          child: Text(
            "Đăng ",
            style: kText18BoldMain,
          ),
        ),
      ],
    );
  }

  bool onValidation() {
    if (chooseEvent == null) {
      showDialog(
          context: context,
          builder: (context) => MyAlertDialog2(
              content: 'Vui lòng chọn sự kiện', title: 'Thông báo'));
      return false;
    }
    if (_titleTextController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => MyAlertDialog2(
              content: 'Vui lòng nhập tiêu đề', title: 'Thông báo'));
      return false;
    }

    return true;
  }
}
