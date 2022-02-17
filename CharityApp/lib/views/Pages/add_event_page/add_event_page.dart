import 'dart:io';

import 'package:charityapp/Config/colorconfig.dart';
import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/core/model/keys.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/image_card.dart';
import 'package:charityapp/views/Component/my_alert_dialog_2.dart';
import 'package:charityapp/views/Pages/google_map_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  late TextEditingController _requireTextController;
  File? avatarImage;
  File? backgroundImage;
  DateTime? startDate;
  LatLng? latLng;
  List<TagEvent> _tags = [];

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _dateTextController = TextEditingController();
    _locationTextController = TextEditingController();
    _descriptionTextController = TextEditingController();
    _requireTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _dateTextController.dispose();
    _locationTextController.dispose();
    _descriptionTextController.dispose();
    _requireTextController.dispose();
    super.dispose();
  }

  bool isValidation() {
    if (_nameTextController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (context) => MyAlertDialog2(
                content: 'Vui lòng nhập tên cho sự kiện',
                title: 'Thông báo',
                isTwoActions: false,
              ));
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cwColorBackground,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: textcolor, //change your color here
        ),
        centerTitle: true,
        backgroundColor: backgroundbottomtab,
        title: Text(
          "Tạo sự kiện",
          style: kText18BoldBlack,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (!isValidation()) return;

              final _event = EventInfor(
                name: _nameTextController.text,
                creatorId: Authenticator.Id,
                description: _descriptionTextController.text,
                timeStart: startDate,
                locationText: _locationTextController.text,
                locationGeo: latLng,
                tags: _tags,
              );
              widget.onClickSubmit?.call(
                _event,
                avatarImage: avatarImage,
                backgroundImage: backgroundImage,
              );
              // Navigator.pop(context);
            },
            child: Text(
              "Đăng",
              style: TextStyle(
                  color: maincolor,
                  fontFamily: 'Roboto_Regular',
                  fontSize: 18.sp,
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
        padding: EdgeInsets.all(10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: cwColorWhite,
                ),
                child: Column(
                  children: [
                    ChoiceField(
                      controller: _locationTextController,
                      icon: Icons.keyboard_arrow_right_outlined,
                      title: 'Chọn địa điểm',
                      onPress: () async {
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

                        FocusScope.of(context).unfocus();
                        if (args != null) {
                          _locationTextController.text =
                              args[0] as String? ?? "";
                          latLng = args[1] as LatLng;
                        } else {
                          // latLng = null;
                        }
                      },
                    ),
                    ChoiceField(
                      controller: _dateTextController,
                      icon: Icons.keyboard_arrow_right_outlined,
                      title: 'Chọn thời gian',
                      onPress: () {
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
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: cwColorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
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
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: cwColorWhite,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tag",
                            style: kText15BoldBlack,
                          ),
                          TextButton(
                              onPressed: () async {
                                List<TagEvent>? tagsChoose =
                                    await Navigator.of(context).pushNamed(
                                        AppRoutes.chooseTags,
                                        arguments: _tags) as List<TagEvent>?;

                                setState(() {
                                  _tags = tagsChoose ?? _tags;
                                });
                              },
                              child: Text(
                                "Tìm tag",
                                style: kText14BoldMainColor,
                              ))
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            _tags.length,
                            (index) => Padding(
                              padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
                              child: Chip(
                                backgroundColor: cwColorMain,
                                deleteIcon: Icon(
                                  FontAwesomeIcons.timesCircle,
                                  color: cwColorWhite,
                                ),
                                label: Text(
                                  _tags[index].name,
                                  style: TextStyle(
                                      fontFamily: 'Roboto_Regular',
                                      fontSize: 13.sp,
                                      color: cwColorWhite),
                                ),
                                onDeleted: () {
                                  setState(() {
                                    _tags.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      )
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
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        style: kText17BoldBlack,
                        controller: _nameTextController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Thêm tiêu đề tại đây"),
                      ),
                      TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _descriptionTextController,
                          minLines: 8,
                          maxLines: 15,
                          style: TextStyle(
                              fontFamily: 'Roboto-Regular.ttf',
                              fontSize: 15.sp,
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
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: cwColorWhite,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 20.w,
                        //  alignment: ,
                        child: Text(
                          "Yêu cầu",
                          style: kText17BoldBlack,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: _requireTextController,
                          minLines: 8,
                          maxLines: 10,
                          style: TextStyle(
                              fontFamily: 'Roboto-Regular.ttf',
                              fontSize: 15.sp,
                              color: Colors.grey[600]),
                          decoration: InputDecoration(
                              hintText: "Viết yêu cầu ở đây...",
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none)),
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

class ChoiceField extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function()? onPress;
  final TextEditingController controller;
  const ChoiceField(
      {Key? key,
      required this.title,
      required this.icon,
      this.onPress,
      required this.controller})
      : super(key: key);

  @override
  State<ChoiceField> createState() => _ChoiceFieldState();
}

class _ChoiceFieldState extends State<ChoiceField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.title,
            style: kText15BoldBlack,
          ),
          SizedBox(
            width: 10.w,
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.end,
                    style: kText15RegularMain,
                    controller: widget.controller,
                    decoration: new InputDecoration(border: InputBorder.none),
                  ),
                ),
                IconButton(
                    iconSize: 20.w,
                    padding: EdgeInsets.all(1.0),
                    onPressed: widget.onPress,
                    icon: Icon(
                      widget.icon,
                      color: maincolor,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
