import 'dart:io';

import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/image_card.dart';
import 'package:charityapp/views/Pages/add_event_page/add_event_page.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: () async {
                    BlocProvider.of<PostBloc>(context).add(
                      LoadOverViewEventsPaticipant(
                          creatorId: '1G0aTSj46pSsvP8eBYb5'),
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
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto_Regular',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.navigate_next,
                            size: 20, color: textcolor),
                        splashRadius: 20,
                        // onPressed: () {
                        //   Navigator.pushNamed(
                        //     context,
                        //     AppRoutes.chooseEvent,
                        //   );
                        // },
                        onPressed: null,
                      )
                    ],
                  )),
              Divider(color: Colors.grey[800], height: 1),
              SizedBox(
                height: 10,
              ),
              textFormFieldWithTitle(
                title: "Tiêu đề",
                text: "",
                iconData: null,
                type: TextInputType.text,
                controller: _titleTextController,
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Thêm ảnh",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto_Regular',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Tối đa 10 ảnh",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontFamily: 'Roboto_Regular',
                    fontSize: 13,
                  ),
                )
              ]),
              SizedBox(
                height: 200,
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
                        SizedBox(width: 5),
                      ],
                    );
                  },
                ),
              ),
              TextFormField(
                cursorColor: maincolor,
                keyboardType: TextInputType.name,
                minLines: 3,
                maxLines: 5,
                style:
                    TextStyle(fontFamily: 'Roboto-Regular.ttf', fontSize: 15),
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
      title: Text("Tạo bài viết",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto_Regular',
              fontSize: 19,
              fontWeight: FontWeight.w600)),
      actions: [
        TextButton(
          onPressed: () {
            //TODO: fix creator here
            final post = Post(
              title: _titleTextController.text,
              description: _descriptionTextControlelr.text,
              eventId: chooseEvent!.id!,
              creator: UserOverview(
                  name: 'khong co',
                  avatarUri: null,
                  id: '7hKHP4tpuIyeTJ44IdJe'),
            );

            widget.onClickSubmit?.call(post, images);
          },
          child: Text(
            "Đăng ",
            style: TextStyle(
                color: maincolor,
                fontFamily: 'Roboto_Regular',
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
