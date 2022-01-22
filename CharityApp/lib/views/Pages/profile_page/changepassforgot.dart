import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Component/my_alert_dialog.dart';
import 'package:charityapp/views/Component/password_input.dart';
import 'package:charityapp/views/Login/login_view.dart';
import 'package:charityapp/views/bloc/changepassforgot_bloc/bloc/changepassforgot_bloc.dart';
import 'package:charityapp/views/bloc/signin_bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              padding: EdgeInsets.fromLTRB(10.w, 50.h, 0, 50.h),
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
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
              child: Text(
                'Mật khẩu mới cần khác với mật khẩu trước đó',
                style: kText18RegularGreyNoteText,
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
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
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
                child: Text('Xác nhận mật khẩu mới', style: kText15BoldMain),
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
            Padding(
                padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
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
