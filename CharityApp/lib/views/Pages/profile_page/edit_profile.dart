import 'dart:io';

import 'package:charityapp/Constant/user_json.dart';
import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/aler_dialog.dart';
import 'package:charityapp/views/bloc/editprofile_bloc/bloc/editprofile_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_even.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final UserProfile currentUser;
  final Function onEditPro;
  const EditProfile(
      {Key? key, required this.currentUser, required this.onEditPro})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var editprofileBloc;
  var dropvalue = "Nữ";

  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imagetemporary = File(image.path);
    setState(() => {this.image = imagetemporary});
  }

  Future<void> close() async {
    await editprofileBloc.add(EditprofileEditEvent(widget.currentUser));
    widget.onEditPro.call();
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlerDialog (
          description: 'Nhấn Đồng ý để quay lại màn hình Hồ sơ của bạn',
          title: 'Cập nhật thông tin thành công',
          imagepath: 'asset/avatar.png',
        ));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    dropvalue = widget.currentUser.gender == Genders.Female
        ? "Nữ"
        : widget.currentUser.gender == Genders.Male
            ? "Nam"
            : "Khác";
    editprofileBloc = BlocProvider.of<EditprofileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80), child: getappbar()),
        body: getbody());
  }

  Widget getappbar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppBar(
          iconTheme: IconThemeData(color: textcolor),
          backgroundColor: backgroundbottomtab,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: null,
                child: Text(
                  "",
                  style: TextStyle(
                      color: textcolor,
                      fontFamily: 'Roboto_Regular',
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ),
              TextButton(
                onPressed: null,
                child: Text(
                  "Chỉnh sửa",
                  style: TextStyle(
                      color: textcolor,
                      fontFamily: 'Roboto_Regular',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: close,
                //onPressed:()=>{},
                child: Text(
                  "Hoàn thành",
                  style: TextStyle(
                      color: maincolor,
                      fontFamily: 'Roboto_Regular',
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getbody() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                width: 106,
                height: 106,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: activecolor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Column(
                    children: <Widget>[
                      Stack(alignment: Alignment.center, children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            image: DecorationImage(
                                image: image != null
                                    ? FileImage(image!) as ImageProvider
                                    : AssetImage('asset/avatar.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              alignment: Alignment.center,
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                color: maincolor,
                                icon: Icon(Icons.camera_enhance_outlined),
                                onPressed: pickImage,
                              ),
                            ))
                      ])
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    Container(
                      width: 110,
                      child: Text(
                        "Tên",
                        style: TextStyle(
                            color: textcolor,
                            fontFamily: 'Roboto_Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: widget.currentUser.name,
                        onChanged: (value) => {widget.currentUser.name = value},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    Container(
                      width: 110,
                      child: Text(
                        "Ngày sinh",
                        style: TextStyle(
                            color: textcolor,
                            fontFamily: 'Roboto_Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: widget.currentUser.birthDay.toString(),
                        onChanged: (value) =>
                            {widget.currentUser.birthDayString = value},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    Container(
                      width: 110,
                      child: Text(
                        "Mô tả",
                        style: TextStyle(
                            color: textcolor,
                            fontFamily: 'Roboto_Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 140,
                        child: Flexible(
                          child: TextFormField(
                            initialValue: widget.currentUser.description,
                            onChanged: (value) =>
                                {widget.currentUser.description = value},
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Thông tin mật",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: textcolor,
                        fontFamily: 'Roboto_Regular',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    Container(
                      width: 110,
                      child: Text(
                        "Email",
                        style: TextStyle(
                            color: textcolor,
                            fontFamily: 'Roboto_Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: widget.currentUser.email,
                        onChanged: (value) =>
                            {widget.currentUser.email = value},
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    Container(
                      width: 110,
                      child: Text(
                        "Số điện thoại",
                        style: TextStyle(
                            color: textcolor,
                            fontFamily: 'Roboto_Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: widget.currentUser.phone,
                        onChanged: (value) =>
                            {widget.currentUser.phone = value},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    Container(
                      width: 110,
                      child: Text(
                        "Giới tính",
                        style: TextStyle(
                            color: textcolor,
                            fontFamily: 'Roboto_Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: DropdownButton(
                        value: dropvalue,
                        icon: Icon(Icons.arrow_drop_down_outlined),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropvalue = newValue!;
                            widget.currentUser.gender = newValue == 'Nữ'
                                ? Genders.Female
                                : newValue == "Nam"
                                    ? Genders.Male
                                    : Genders.Undefined;
                          });
                        },
                        underline: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                        items: <String>['Nam', 'Nữ', 'Khác']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: const Color(0xff3C3C43),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Đổi mật khẩu",
                        style: TextStyle(
                            color: textcolor,
                            fontFamily: 'Roboto_Regular',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(onPressed: null, icon: Icon(Icons.navigate_next))
                  ],
                ),
              ),
              Divider(
                color: const Color(0xff3C3C43),
              )
            ],
          ),
        ),
      ),
    );
  }
}
