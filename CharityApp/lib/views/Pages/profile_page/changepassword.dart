import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Component/password_input.dart';
import 'package:charityapp/views/Login/register_view.dart';
import 'package:charityapp/views/bloc/changepassword_bloc/bloc/changepassword_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangePasswordEditprofile extends StatefulWidget {
  final String email;

  ChangePasswordEditprofile({Key? key, required this.email}) : super(key: key);
  @override
  _ChangePasswordEditprofileState createState() =>
      _ChangePasswordEditprofileState();
}

class _ChangePasswordEditprofileState extends State<ChangePasswordEditprofile> {
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      new TextEditingController();
  final TextEditingController oldpasswordcontroller =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _changepassBloc = BlocProvider.of<ChangepasswordBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 50, 0, 50),
              child: Row(children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back)),
              ]),
            ),
            Text(
              'Đổi mật khẩu',
              style: TextStyle(
                  color: maincolor,
                  fontSize: 38,
                  fontFamily: 'Roboto-Regular.ttf',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Text(
                'Mật khẩu mới cần khác với mật khẩu trước đó',
                style: TextStyle(
                    color: notetextcolor,
                    fontSize: 16,
                    fontFamily: 'Roboto_Regular'),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                child: Text(
                  'Mật khẩu cũ',
                  style: TextStyle(
                      color: maincolor,
                      fontFamily: 'Roboto-Regular.tff',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: PassWordInput(
                textInputType: TextInputType.text,
                securitytext: false,
                background: Colors.white,
                boder: maincolor,
                hint: '',
                ispass: true,
                textcontroller: oldpasswordcontroller,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                child: Text(
                  'Mật khẩu mới',
                  style: TextStyle(
                      color: maincolor,
                      fontFamily: 'Roboto-Regular.tff',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: PassWordInput(
                textInputType: TextInputType.text,
                securitytext: false,
                background: Colors.white,
                boder: maincolor,
                hint: '',
                ispass: true,
                textcontroller: passwordcontroller,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                child: Text(
                  'Xác nhận mật khẩu mới',
                  style: TextStyle(
                      color: maincolor,
                      fontFamily: 'Roboto-Regular.tff',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: PassWordInput(
                securitytext: true,
                background: Colors.white,
                boder: maincolor,
                hint: '',
                ispass: true,
                textcontroller: confirmpasswordcontroller,
                textInputType: TextInputType.text,
              ),
            ),
            TextButton(
                onPressed: () => {},
                child: Text(
                  "Quên mật khẩu?",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: redcolor,
                    fontSize: 15,
                  ),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: BlocListener<ChangepasswordBloc, ChangepasswordState>(
                  listener: (context, state) {
                    if (state is ChangepasswordSuccess) {
                      showDialog(
                          context: context,
                          builder: (BuildContext buildercontext) =>
                              AlertDialogCustom(
                                content:
                                    "Nhấn đồng ý để quay lại màn hình chỉnh sửa hồ sơ",
                                title: "Đổi mật khẩu thành công",
                                pathImage:
                                    "asset/imagesample/ImageAlerDIalog/changepasssuccess.png",
                              ));
                    } else if (state is ChangepasswordFailConfirmPass) {
                      showDialog(
                          context: context,
                          builder: (BuildContext buildercontext) =>
                              AlertDialogCustom(
                                content:
                                    "Vui lòng nhập chính xác mật khẩu xác nhận",
                                title: "Mật khẩu xác nhận sai",
                                pathImage:
                                    "asset/imagesample/ImageAlerDIalog/changepasssuccess.png",
                              ));
                    } else if (state is ChangepasswordFailOldpass) {
                      showDialog(
                          context: context,
                          builder: (BuildContext buildercontext) =>
                              AlertDialogCustom(
                                content: "Vui lòng nhập đúng mật khẩu cũ",
                                title: "Mật khẩu cũ sai",
                                pathImage:
                                    "asset/imagesample/ImageAlerDIalog/changepasssuccess.png",
                              ));
                    }
                  },
                  child: CustomButton(
                      onPressed: () => {
                            _changepassBloc.add(ChangepasswordChange(
                                confirmpass:
                                    this.confirmpasswordcontroller.text.trim(),
                                newpass: this.passwordcontroller.text.trim(),
                                oldpass: this.oldpasswordcontroller.text.trim(),
                                email: widget.email))
                          },
                      textInput: 'LƯU'),
                ))
          ],
        ),
      ),
    );
  }
}
