import 'dart:io';

import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/core/helper/uploadImage_firestorage.dart';
import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/dialog_with_circle_above.dart';
import 'package:charityapp/views/Component/my_alert_dialog.dart';
import 'package:charityapp/views/Pages/profile_page/changepassword.dart';
import 'package:charityapp/views/bloc/changepassword_bloc/bloc/changepassword_bloc.dart';
import 'package:charityapp/views/bloc/editprofile_bloc/bloc/editprofile_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  var _datetextcontroler;
  var backupUser;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final _imagetemporary = File(image.path);
    final imagetemporary = await compressFile(_imagetemporary, 40);
    final copyimage = await UploadImageToFirestorage.call(
      imageFile: imagetemporary,
      rootPath: 'images/users',
    );
    if (widget.currentUser.avatarUri != "" &&
        widget.currentUser.avatarUri != null)
      FirebaseStorage.instance
          .refFromURL(widget.currentUser.avatarUri!)
          .delete();
    setState(() => {widget.currentUser.avatarUri = copyimage});
    imagetemporary.delete();
  }

  Future<void> close() async {
    await editprofileBloc.add(EditprofileEditEvent(widget.currentUser));
    // await showDialog(
    //     context: context,
    //     builder: (BuildContext context) => MyAlertDialog(
    //         content: "Nhấn đồng ý đề quay lại Hồ sơ của bạn",
    //         pathImage: "asset/imagesample/ImageAlerDIalog/updateprofile.png",
    //         title: "Cập nhật hồ sơ thành công"));
    // await widget.onEditPro.call();

    // Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    dropvalue = widget.currentUser.gender == Genders.Female
        ? "Nữ"
        : widget.currentUser.gender == Genders.Male
            ? "Nam"
            : "Khác";
    this._datetextcontroler =
        new TextEditingController(text: widget.currentUser.birthDayString);
    editprofileBloc = BlocProvider.of<EditprofileBloc>(context);
    backupUser = widget.currentUser;
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: backgroundbottomtab,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: null,
                child: Text(
                  "",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Flexible(
                child: TextButton(
                  onPressed: null,
                  child: Text(
                    "Chỉnh sửa",
                    style: kText20BoldBlack,
                  ),
                ),
              ),
              BlocListener<EditprofileBloc, EditprofileState>(
                listener: (context, state) async {
                  if (state is EditprofilePhoneWrongFormatFail) {
                    showDialog(
                        context: context,
                        builder: (BuildContext buildercontext) =>
                            DialogWithCircleAbove(
                                title: "Số điện thoại không hợp lệ",
                                content:
                                    "Số điện thoại phải có 10 chữ số, bắt đầu bằng 0",
                                mode: ModeDialog.warning)
                        // => MyAlertDialog(
                        //       content:
                        //           "Số điện thoại phải có 10 chữ số, bắt đầu bằng 0",
                        //       pathImage:
                        //           'asset/imagesample/ImageAlerDIalog/lostconnect.png',
                        //       title: "Số điện thoại không hợp lệ",
                        //     )
                        );
                  } else if (state is EditprofileSucess) {
                    await showDialog(
                        context: context,
                        builder: (BuildContext buildercontext) {
                          return DialogWithCircleAbove(
                              title: "Cập nhật hồ sơ thành công",
                              content:
                                  "Vui lòng nhấn Đồng ý để quay về màn hình Hồ sơ của bạn",
                              mode: ModeDialog.anounce);
                          //  MyAlertDialog(
                          //   content:
                          //       "Vui lòng nhấn Đồng ý để quay về màn hình Hồ sơ của bạn",
                          //   pathImage:
                          //       'asset/imagesample/ImageAlerDIalog/updateprofile.png',
                          //   title: "Cập nhật hồ sơ thành công",
                          // );
                        });
                    widget.onEditPro.call();
                    Navigator.pop(context);
                  }
                },
                child: TextButton(
                  onPressed: close,
                  child: Text(
                    "Xong",
                    style: kText20BoldMain,
                  ),
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
                height: 30.h,
              ),
              Container(
                width: 106.h,
                height: 106.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: activecolor),
                ),
                child: Padding(
                  padding: EdgeInsets.all(3.h),
                  child: Column(
                    children: <Widget>[
                      Stack(alignment: Alignment.center, children: <Widget>[
                        Container(
                          width: 100.h,
                          height: 100.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3.w),
                            image: DecorationImage(
                                image: (widget.currentUser.avatarUri != "" &&
                                        widget.currentUser.avatarUri != null)
                                    ? NetworkImage(
                                            widget.currentUser.avatarUri!)
                                        as ImageProvider
                                    : AssetImage('asset/avatar.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                            bottom: 5.h,
                            right: 5.h,
                            child: Container(
                              alignment: Alignment.center,
                              width: 30.h,
                              height: 30.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                padding: EdgeInsets.all(0),
                                splashRadius: 20,
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
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                child: Row(
                  children: [
                    Container(
                      width: 110.w,
                      child: Text(
                        "Tên",
                        style: kText20BoldBlack,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: widget.currentUser.name,
                        onChanged: (value) => {widget.currentUser.name = value},
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                          borderSide:
                              const BorderSide(color: maincolor, width: 2.0),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                child: Row(
                  children: [
                    Container(
                      width: 110.w,
                      child: Text(
                        "Ngày sinh",
                        style: kText20BoldBlack,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: _datetextcontroler,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: maincolor, width: 2.0),
                            ),
                            suffixIcon: Theme(
                              data: Theme.of(context).copyWith(
                                primaryColor: maincolor,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.calendar_today,
                                    color: maincolor),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(
                                        DateTime.now().year - 1,
                                        DateTime.now().month,
                                        DateTime.now().day),
                                    lastDate: DateTime(DateTime.now().year + 2),
                                  ).then((value) {
                                    if (value != null) {
                                      widget.currentUser.birthDayString =
                                          DateFormat('dd/MM/yyyy')
                                              .format(value);
                                      if (widget.currentUser.birthDayString !=
                                          _datetextcontroler.text)
                                        setState(() {
                                          _datetextcontroler.text = widget
                                              .currentUser.birthDayString!;
                                          print(
                                              "Date selected: $widget.currentUser.birthDayString");
                                        });
                                    }
                                  });
                                },
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                child: Row(
                  children: [
                    Container(
                      width: 110.w,
                      child: Text(
                        "Giới tính",
                        style: kText20BoldBlack,
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
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                child: Row(
                  children: [
                    Container(
                      width: 110,
                      child: Text(
                        "Mô tả",
                        style: kText20BoldBlack,
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 140,
                        child: Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                    color: maincolor, width: 2.0),
                              ),
                            ),
                            initialValue: widget.currentUser.description,
                            onChanged: (value) =>
                                {widget.currentUser.description = value},
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 20.h, 0, 15.h),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Thông tin mật",
                    textAlign: TextAlign.left,
                    style: kText20BoldBlack,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                child: Row(
                  children: [
                    Container(
                      width: 110.w,
                      child: Text(
                        "Email",
                        style: kText20BoldBlack,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        enabled: false,
                        initialValue: widget.currentUser.email,
                        onChanged: (value) =>
                            {widget.currentUser.email = value},
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                child: Row(
                  children: [
                    Container(
                      width: 110.w,
                      child: Text(
                        "Số điện thoại",
                        style: kText20BoldBlack,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: widget.currentUser.phone,
                        onChanged: (value) =>
                            {widget.currentUser.phone = value},
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: const Color(0xff3C3C43),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                maincolor.withOpacity(0.1))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            ChangepasswordBloc(),
                                        child: ChangePasswordEditprofile(
                                            email: widget.currentUser.email),
                                      )));
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Đổi mật khẩu",
                            style: kText20BoldBlack,
                          ),
                        ),
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
