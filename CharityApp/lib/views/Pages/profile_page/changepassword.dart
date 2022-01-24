import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Component/my_alert_dialog.dart';
import 'package:charityapp/views/Component/password_input.dart';
import 'package:charityapp/views/Login/verification_otp_view.dart';
import 'package:charityapp/views/bloc/changepassword_bloc/bloc/changepassword_bloc.dart';
import 'package:charityapp/views/bloc/verifidecode_bloc/bloc/verifycode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              padding: EdgeInsets.fromLTRB(20.w, 50.h, 0, 50.h),
              child: Row(children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back)),
              ]),
            ),
            Text(
              'Đổi mật khẩu',
              style: kText38BoldMain,
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
              child: Text(
                'Mật khẩu mới cần khác với mật khẩu trước đó',
                style: kText16RegularGreyText,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30.w, 0, 0, 10.h),
                child: Text('Mật khẩu cũ', style: kText15BoldMain),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
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
                padding: EdgeInsets.fromLTRB(30.w, 0, 0, 10.h),
                child: Text(
                  'Mật khẩu mới',
                  style: kText15BoldMain,
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
                padding: EdgeInsets.fromLTRB(30.w, 0, 0, 10.h),
                child: Text(
                  'Xác nhận mật khẩu mới',
                  style: kText15BoldMain,
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
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
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => VerifycodeBloc(),
                                    child: VerificationOtpView(
                                      email: widget.email,
                                      ischangepass: true,
                                    ),
                                  )))
                    },
                child: Text(
                  "Quên mật khẩu?",
                  textAlign: TextAlign.right,
                  style: kText15BoldRed,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
                child: BlocListener<ChangepasswordBloc, ChangepasswordState>(
                  listener: (context, state) {
                    if (state is ChangepasswordSuccess) {
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
                    } else if (state is ChangepasswordFailConfirmPass) {
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
                    } else if (state is ChangepasswordFailOldpass) {
                      showDialog(
                          context: context,
                          builder: (BuildContext buildercontext) =>
                              MyAlertDialog(
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
