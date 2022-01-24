import 'dart:io';

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
  BaseEvent? chooseEvent;
  final List<File> images = [];

  @override
  void initState() {
    super.initState();
    _titleTextController = TextEditingController();
    _descriptionTextControlelr = TextEditingController();
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _descriptionTextControlelr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: () async {
                    BlocProvider.of<PostBloc>(context).add(
                      LoadOverViewEventsPaticipant(
                          creatorId: Authenticator.Id,
                          startIndex: 0,
                          number: 10),
                    );
                    chooseEvent = await Navigator.of(context).pushNamed(
                      AppRoutes.chooseEvent,
                    ) as BaseEvent?;
                    setState(() => {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chooseEvent == null
                            ? "Chọn sự kiện"
                            : chooseEvent!.name,
                        style: kText15BoldBlack,
                      ),
                      IconButton(
                        icon: Icon(Icons.navigate_next,
                            size: 20, color: textcolor),
                        splashRadius: 20,
                        onPressed: null,
                      )
                    ],
                  )),
              Divider(color: Colors.grey[800], height: 1),
              SizedBox(
                height: 10.h,
              ),
              textFormFieldWithTitle(
                title: "Tiêu đề",
                text: "",
                iconData: null,
                type: TextInputType.text,
                controller: _titleTextController,
              ),
              SizedBox(height: 10.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Thêm ảnh",
                  style: kText15Bold80Black,
                ),
                Text(
                  "Tối đa 10 ảnh",
                  style: kText13RegularGreyText,
                )
              ]),
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        // Container(
                        //   height: 150,
                        //   width: 120,
                        //   child: IconButton(
                        //       onPressed: () => {

                        //       },
                        //       icon: Icon(Icons.add_photo_alternate_outlined,
                        //           color: maincolor, size: 25)),
                        //   decoration: BoxDecoration(
                        //       color: backgroundbottomtab,
                        //       borderRadius: BorderRadius.circular(10)),
                        //   margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
                        // ),
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
              TextFormField(
                cursorColor: maincolor,
                keyboardType: TextInputType.name,
                minLines: 3,
                maxLines: 10,
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
    );
  }

  AppBar getAppBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: textcolor, //change your color here
      ),
      backgroundColor: backgroundbottomtab,
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
