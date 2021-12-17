import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  late TextEditingController _nameTextController;
  late TextEditingController _locationTextController;
  late Image myImage;

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
    return SingleChildScrollView(
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
    );
  }

  Widget CardImage({required String titleName, Image? image = null }) {
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
