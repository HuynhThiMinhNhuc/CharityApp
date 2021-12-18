import 'dart:ui';

import 'package:charityapp/core/model/keys.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  final Function(EventInfor event) onClickSubmit;

  const AddEventPage({Key? key, required this.onClickSubmit})
      : super(key: key ?? AppKeys.addEventScreen);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  late TextEditingController _nameTextController;
  late TextEditingController _locationTextController;
  late Image myImage;
  late Image backgroundImage;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _locationTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _locationTextController.dispose();
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
                  creator: BaseUser(name: 'Thạch'));
              widget.onClickSubmit(event);
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
            TextFormField(
              keyboardType: TextInputType.datetime,
              controller: _nameTextController,
              decoration: InputDecoration(
                hintText: "Nhập thời gian",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
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
                CardImage(titleName: "+ Ảnh bìa"),
                CardImage(titleName: "+ Ảnh đại diện"),
              ],
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: _nameTextController,
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

  Widget CardImage({required String titleName, Image? image = null}) {
    // image = Image.asset("asset/Icon/HomeIcon.png");
    return Container(
      child: image != null
          ? image
          : InkWell(
              child: Center(
                child: Text(
                  titleName,
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () => {},
            ),
      height: 150,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.black),
      ),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
    );
  }
}
