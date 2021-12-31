import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Component/password_input.dart';
import 'package:charityapp/views/Component/text_input.dart';
import 'package:charityapp/views/Login/login_view.dart';
import 'package:charityapp/views/Login/register_view.dart';
import 'package:charityapp/views/bloc/profile/bloc/profile_bloc.dart';
import 'package:charityapp/views/bloc/signin_bloc/signin_bloc.dart';
import 'package:charityapp/views/bloc/verifidecode_bloc/bloc/verifycode_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  final String email;
  var userProfile;

  Profile({Key? key, required this.email}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController namecontroller = new TextEditingController();
  final TextEditingController birthcontroller = new TextEditingController();
  final TextEditingController phonecontroller = new TextEditingController();
  var ismade = false;
  var profileBloc;

  @override
  void initState() {
    super.initState();
    profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 50, 0, 20),
              child: Row(children: [
                IconButton(onPressed: () => {}, icon: Icon(Icons.arrow_back)),
              ]),
            ),
            Text(
              'Hồ sơ',
              style: TextStyle(
                  color: maincolor,
                  fontSize: 38,
                  fontFamily: 'Roboto-Regular.ttf',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Bổ sung thông tin của bạn',
              style: TextStyle(
                  color: notetextcolor,
                  fontSize: 20,
                  fontFamily: 'Roboto_Regular'),
            ),
            SizedBox(
              height: 40,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                child: Text(
                  'Họ và tên',
                  style: TextStyle(
                      color: maincolor,
                      fontFamily: 'Roboto-Regular.tff',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ]),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextInput(
                  icon: FontAwesomeIcons.pen,
                  background: Colors.white,
                  boder: maincolor,
                  hint: '',
                  labeltext: '',
                  textEditingController: namecontroller,
                  textInputType: TextInputType.text,
                )),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                child: Text(
                  'Ngày sinh',
                  style: TextStyle(
                      color: maincolor,
                      fontFamily: 'Roboto-Regular.tff',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: PassWordInput(
                  hint: 'dd/mm/yyy',
                  background: Colors.white,
                  boder: maincolor,
                  securitytext: false,
                  ispass: false,
                  textcontroller: birthcontroller,
                  textInputType: TextInputType.text),
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                child: Text(
                  'Số điện thoại',
                  style: TextStyle(
                      color: maincolor,
                      fontFamily: 'Roboto-Regular.tff',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ]),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextInput(
                  icon: Icons.phone,
                  background: Colors.white,
                  boder: maincolor,
                  hint: '',
                  labeltext: '',
                  textEditingController: phonecontroller,
                  textInputType: TextInputType.phone,
                )),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                child: Text(
                  'Giới tính',
                  style: TextStyle(
                      color: maincolor,
                      fontFamily: 'Roboto-Regular.tff',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      color: backgrountbutton.withOpacity(0.2),
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      child: TextButton.icon(
                          onPressed: () => {
                                setState(() => {this.ismade = true})
                              },
                          icon: Icon(
                            Icons.male,
                            color: !ismade ? maincolor : Colors.white,
                            size: 40,
                          ),
                          label: Text(
                            'Phụ nữ',
                            style: TextStyle(
                                color: !ismade ? maincolor : Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 15),
                          ),
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: ismade
                                ? MaterialStateProperty.all<Color>(maincolor)
                                : MaterialStateProperty.all<Color>(
                                    maincolor.withOpacity(0.2)),
                          )),
                    ),
                    Container(
                      color: backgrountbutton.withOpacity(0.2),
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      child: TextButton.icon(
                          onPressed: () => {
                                setState(() => {ismade = false})
                              },
                          icon: Icon(
                            Icons.female,
                            color: !ismade ? Colors.white : maincolor,
                            size: 40,
                          ),
                          label: Text(
                            'Đàn ông',
                            style: TextStyle(
                                color: !ismade ? Colors.white : maincolor,
                                fontFamily: 'Roboto',
                                fontSize: 15),
                          ),
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: !ismade
                                ? MaterialStateProperty.all<Color>(maincolor)
                                : MaterialStateProperty.all<Color>(
                                    maincolor.withOpacity(0.2)),
                          )),
                    ),
                  ]),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: BlocListener<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileSucessState) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => BlocProvider(
                            create: (context) => SigninBloc(),
                            child: Login(),
                          ),
                        ),
                        (route) => false,
                      );
                    } else if (state is ProfileFailState) {
                      AlertDialogCustom(
                          content:
                              "Xin lỗi vì sự bất tiện này. Vui lòng thử lại sau",
                          pathImage:
                              "asset/imagesample/ImageAlerDIalog/lostconnect.png",
                          title: "Lỗi kết nối");

                    }
                  },
                  child: CustomButton(
                      onPressed: () => {
                            profileBloc.add(ProfileSaveEvent(
                                new UserInfor(
                                    name: namecontroller.text.trim(),
                                    avatarUri: null,
                                    description: "",
                                    birthDayString: birthcontroller.text.trim(),
                                    gender: this.ismade
                                        ? Genders.Male
                                        : Genders.Female),
                                widget.email))
                          },
                      textInput: 'LƯU'),
                ))
          ],
        ),
      ),
    );
  }
}
