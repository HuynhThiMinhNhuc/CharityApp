import 'dart:io';
import 'dart:ui';

import 'package:charityapp/core/model/keys.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/image_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEventPage extends StatefulWidget {
  final Function(
    EventInfor event, {
    File? avatarImage,
    File? backgroundImage,
  }) onClickSubmit;

  const AddEventPage({Key? key, required this.onClickSubmit})
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundbottomtab,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Tạo sự kiện",
          style: TextStyle(
              color: textcolor,
              fontFamily: 'Roboto_Regular',
              fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final event = EventInfor(
                name: _nameTextController.text,
                creator: BaseUser(name: 'Thạch'),
                description: _descriptionTextController.text == "" ? null : _descriptionTextController.text,
                timeStart: _dateTextController.text == "" ? null : _dateTextController.text,
              );
              widget.onClickSubmit(
                event,
                avatarImage: avatarImage,
                backgroundImage: backgroundImage,
              );
            },
            child: Text(
              "Đăng",
              style: TextStyle(
                  color: textcolor,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tên sự kiện"),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: _nameTextController,
              decoration: InputDecoration(
                hintText: "Nhập tên sự kiện",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
            Text("Thời gian"),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _dateTextController,
                    decoration: InputDecoration(
                      hintText: "Nhập thời gian",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today_rounded),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025))
                        .then((value) {
                      if (value != null) {
                        final formattedDate =
                            DateFormat('dd/MM/yyyy').format(value);
                        if (formattedDate != _dateTextController.text)
                          setState(() {
                            _dateTextController.text = formattedDate;
                            print("Date selected: $formattedDate");
                          });
                      }
                    });
                  },
                ),
              ],
            ),
            Text("Địa điểm"),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _locationTextController,
              decoration: InputDecoration(
                hintText: "Nhập địa điểm",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
            Text("Hình ảnh"),
            Row(
              children: [
                // CardImage(titleName: "+ Ảnh bìa"),
                // CardImage(titleName: "+ Ảnh đại diện"),
                ImageCard(
                  hintTitle: "+ Ảnh bìa",
                  onImageChanged: (file) {avatarImage = file;},
                ),
                ImageCard(
                  hintTitle: "+ Ảnh đại diện",
                  onImageChanged: (file) {backgroundImage = file;},
                ),
              ],
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: _descriptionTextController,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Viết nội dung ở đây",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
