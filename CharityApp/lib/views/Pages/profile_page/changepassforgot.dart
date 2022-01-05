import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Component/my_alert_dialog.dart';
import 'package:charityapp/views/Component/password_input.dart';
import 'package:charityapp/views/Login/login_view.dart';
import 'package:charityapp/views/bloc/changepassforgot_bloc/bloc/changepassforgot_bloc.dart';
import 'package:charityapp/views/bloc/signin_bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePassforgotprofile extends StatefulWidget {
  final String email;

  ChangePassforgotprofile({Key? key, required this.email}) : super(key: key);
  @override
  _ChangePassforgotprofileState createState() =>
      _ChangePassforgotprofileState();
}

class _ChangePassforgotprofileState extends State<ChangePassforgotprofile> {
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _changepassBloc = BlocProvider.of<ChangepassforgotBloc>(context);
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
            Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child:
                    BlocListener<ChangepassforgotBloc, ChangepassforgotState>(
                  listener: (context, state) {
                    if (state is ChangepassforgotEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext buildercontext) =>
                              MyAlertDialog(
                                content: "Vui lòng nhập đầy đủ thông tin",
                                title: "Thông tin bị bỏ trống",
                                pathImage:
                                    "asset/imagesample/ImageAlerDIalog/wrong.png",
                              ));
                    } else if (state is Changepassforgotsuccess) {
                      showDialog(
                          context: context,
                          builder: (BuildContext buildercontext) =>
                              MyAlertDialog(
                                content:
                                    "Nhấn đồng ý để quay lại màn hình chỉnh sửa hồ sơ",
                                title: "Đổi mật khẩu thành công",
                                pathImage:
                                    "asset/imagesample/ImageAlerDIalog/changepasssuccess.png",
                              ));
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => SigninBloc(),
                                    child: Login(),
                                  )),
                          (route) => false);
                    } else if (state is ChangepassforgotWrongconfirmpass) {
                      showDialog(
                          context: context,
                          builder: (BuildContext buildercontext) =>
                              MyAlertDialog(
                                content:
                                    "Vui lòng nhập chính xác mật khẩu xác nhận",
                                title: "Mật khẩu xác nhận sai",
                                pathImage:
                                    "asset/imagesample/ImageAlerDIalog/changepasssuccess.png",
                              ));
                    }
                  },
                  child: CustomButton(
                      onPressed: () => {
                            _changepassBloc.add(ChangepassforgotChange(
                                confirmpass: confirmpasswordcontroller.text,
                                newpass: passwordcontroller.text))
                          },
                      textInput: 'LƯU'),
                ))
          ],
        ),
      ),
    );
  }
}
