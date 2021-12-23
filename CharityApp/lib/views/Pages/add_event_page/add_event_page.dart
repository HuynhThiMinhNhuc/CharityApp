import 'dart:io';

import 'package:charityapp/core/model/keys.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/image_card.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  final Function(
    EventInfor event, {
    File? avatarImage,
    File? backgroundImage,
  })? onClickSubmit;

  const AddEventPage({Key? key, this.onClickSubmit})
      : super(key: key ?? AppKeys.addEventScreen);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  late TextEditingController _nameTextController;
  late TextEditingController _dateTextController;
  late TextEditingController _locationTextController;
  late TextEditingController _descriptionTextController;
  File? avatarImage;
  File? backgroundImage;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _dateTextController = TextEditingController();
    _locationTextController = TextEditingController();
    _descriptionTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _dateTextController.dispose();
    _locationTextController.dispose();
    _descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: textcolor, //change your color here
        ),
        centerTitle: true,
        backgroundColor: backgroundbottomtab,
        title: Text(
          "Tạo sự kiện",
          style: TextStyle(
              color: textcolor,
              fontFamily: 'Roboto_Regular',
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final _event = EventInfor(
                name: _nameTextController.text,
                creator: BaseUser(name: 'Thạch'),
                description: _descriptionTextController.text == ""
                    ? null
                    : _descriptionTextController.text,
                timeStart: _dateTextController.text == ""
                    ? null
                    : _dateTextController.text,
              );
              widget.onClickSubmit?.call(
                _event,
                avatarImage: avatarImage,
                backgroundImage: backgroundImage,
              );
            },
            child: Text(
              "Đăng",
              style: TextStyle(
                  color: maincolor,
                  fontFamily: 'Roboto_Regular',
                  fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    textFormFieldWithTitle(
                      iconData: null,
                      text: '',
                      title: 'Tên sự kiện',
                      type: TextInputType.text,
                      controller: _nameTextController,
                    ),
                    textFormFieldWithTitle(
                      iconData: Icon(
                        Icons.calendar_today_outlined,
                        color: maincolor,
                        size: 25,
                      ),
                      text: '',
                      title: 'Thời gian',
                      type: TextInputType.datetime,
                      controller: _dateTextController,
                    ),
                    textFormFieldWithTitle(
                      iconData: Icon(
                        Icons.location_on_outlined,
                        color: Colors.red[400],
                        size: 25,
                      ),
                      text: '',
                      title: 'Địa điểm',
                      type: TextInputType.text,
                      controller: _locationTextController,
                    ),
                    Text(
                      "Thêm ảnh",
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular.ttf',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.grey[600]),
                    ),
                    Row(
                      children: [
                        ImageCard(
                          hintTitle: "+ Ảnh bìa",
                          onImageChanged: (file) {
                            avatarImage = file;
                          },
                        ),
                        ImageCard(
                          hintTitle: "+ Ảnh đại diện",
                          onImageChanged: (file) {
                            backgroundImage = file;
                          },
                        ),
                      ],
                    ),
                    TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _descriptionTextController,
                        minLines: 3,
                        maxLines: 5,
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular.ttf',
                            fontSize: 15,
                            color: Colors.grey[600]),
                        decoration: InputDecoration(
                            hintText: "Viết nội dung ở đây...",
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none)),
                  ],
                ),
              ),
            ),
            Container(
              height: 70,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Divider(color: Colors.grey[600]),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => {},
                          icon: Icon(
                            Icons.attach_file_sharp,
                            color: maincolor,
                            size: 25,
                          )),
                      Chip(
                        deleteIcon: Icon(Icons.close),
                        label: Text(
                          "Mồ côi",
                          style: TextStyle(
                              fontFamily: 'Roboto_Regular',
                              fontSize: 12,
                              color: Color(0xFF455154)),
                        ),
                      )
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   itemCount: 2,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return Chip(
                      //       deleteIcon: Icon(Icons.close),
                      //       label: Text(
                      //         "Mồ côi",
                      //         style: TextStyle(
                      //             fontFamily: 'Roboto_Regular',
                      //             fontSize: 12,
                      //             color: Color(0xFF455154)),
                      //       ),
                      //       onDeleted: null,
                      //     );
                      //   },
                      // )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class textFormFieldWithTitle extends StatelessWidget {
  final String title;
  final String text;
  final Icon? iconData;
  final TextInputType type;
  final TextEditingController controller;
  const textFormFieldWithTitle({
    Key? key,
    required this.title,
    required this.text,
    required this.iconData,
    required this.type,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontFamily: 'Roboto-Regular.ttf',
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.grey[600]),
        ),
        TextFormField(
          controller: controller,
          cursorColor: maincolor,
          style: TextStyle(
              fontFamily: 'Roboto-Regular.ttf',
              fontSize: 15,
              color: Colors.black),
          keyboardType: type,
          decoration: new InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: maincolor),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: maincolor,
                ),
              ),
              suffixIcon: iconData,
              label: null),
        ),
        SizedBox(height: 7)
      ],
    );
  }
}
