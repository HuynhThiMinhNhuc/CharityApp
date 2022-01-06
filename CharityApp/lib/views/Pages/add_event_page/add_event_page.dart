import 'dart:io';

import 'package:charityapp/core/model/keys.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/image_card.dart';
import 'package:charityapp/views/Login/login_view.dart';
import 'package:charityapp/views/Login/register_view.dart';
import 'package:charityapp/views/Pages/add_event_page/add_tag_page.dart';
import 'package:charityapp/views/Pages/google_map_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  DateTime? startDate;
  LatLng? latLng;

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
    final List<String> _tags = <String>[
      "Mồ côi",
      "Người già",
      "Trẻ em",
      "Môi trường"
    ];
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
                creatorId: 'test',
                description: _descriptionTextController.text == ""
                    ? null
                    : _descriptionTextController.text,
                timeStart: startDate,
                locationText: _locationTextController.text == ""
                    ? null
                    : _locationTextController.text,
                locationGeo: latLng,
              );
              widget.onClickSubmit?.call(
                _event,
                avatarImage: avatarImage,
                backgroundImage: backgroundImage,
              );
              Navigator.pop(context);
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
                      title: 'Thời gian bắt đầu',
                      type: TextInputType.datetime,
                      controller: _dateTextController,
                      onClickIcon: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 1,
                              DateTime.now().month, DateTime.now().day),
                          lastDate: DateTime(DateTime.now().year + 2),
                        ).then((value) {
                          startDate = value;

                          if (startDate != null) {
                            final formattedDate =
                                DateFormat('dd/MM/yyyy').format(startDate!);
                            if (formattedDate != _dateTextController.text)
                              setState(() {
                                _dateTextController.text = formattedDate;
                                print("Date selected: $formattedDate");
                              });
                          } else {
                            setState(() {
                              _dateTextController.text = '';
                            });
                          }
                        });
                      },
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
                      onClickIcon: () async {
                        if (!await isPermissionMap()) {
                          AlertDialog(
                            title: Text('Thông báo'),
                            content: Text(
                                'Vui lòng cấp quyền cho ứng dụng để mở bản đồ'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Đồng ý'),
                              )
                            ],
                          );
                        }
                        final args = await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return latLng != null
                              ? GoogleMapPage(initLatlng: latLng!)
                              : GoogleMapPage();
                        }));

                        if (args != null) {
                          _locationTextController.text =
                              args[0] as String? ?? "";
                          latLng = args[1] as LatLng;
                        } else {
                          // latLng = null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      " Thêm ảnh",
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular.ttf',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                    Row(
                      children: [
                        ImageCard(
                          hintTitle: "+ Ảnh bìa",
                          onImageChanged: (file) {
                            backgroundImage = file;
                          },
                        ),
                        ImageCard(
                          hintTitle: "+ Ảnh đại diện",
                          onImageChanged: (file) {
                            avatarImage = file;
                          },
                        ),
                      ],
                    ),
                    TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _descriptionTextController,
                        minLines: 3,
                        maxLines: 3,
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
              height: 65,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Divider(color: Colors.grey[600]),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddTag(tags: <Tags>[
                                                new Tags(
                                                    tag: "love",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "instagood",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "photooftheday",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "beautiful",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "fashion",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "happy",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "tbt",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "cute",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "summer",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "love",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "instadaily",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "followme",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "selfie",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "followme",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "love",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "picoftheday",
                                                    isSelected: false),
                                                new Tags(
                                                    tag: "love",
                                                    isSelected: false),
                                              ])))
                                },
                            icon: Icon(
                              FontAwesomeIcons.tags,
                              color: maincolor,
                              size: 25,
                            )),
                        Row(
                          children: List.generate(
                            _tags.length,
                            (index) => Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Chip(
                                deleteIcon: Icon(
                                  FontAwesomeIcons.timesCircle,
                                  color: notetextcolor,
                                ),
                                label: Text(
                                  _tags[index],
                                  style: TextStyle(
                                      fontFamily: 'Roboto_Regular',
                                      fontSize: 12,
                                      color: Color(0xFF455154)),
                                ),
                                onDeleted: () => {},
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> isPermissionMap() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }

    return true;
  }
}

class textFormFieldWithTitle extends StatelessWidget {
  final String title;
  final String text;
  final Icon? iconData;
  final TextInputType type;
  final TextEditingController controller;
  final Function()? onClickIcon;
  const textFormFieldWithTitle({
    Key? key,
    required this.title,
    required this.text,
    required this.iconData,
    required this.type,
    required this.controller,
    this.onClickIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: 'Roboto-Regular.ttf',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black),
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
                suffixIcon: iconData != null
                    ? IconButton(
                        onPressed: () => onClickIcon?.call(), icon: iconData!)
                    : null,
                label: null),
          ),
          SizedBox(height: 7)
        ],
      ),
    );
  }
}
