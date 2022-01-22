import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Component/text_input.dart';
import 'package:charityapp/views/Login/verification_otp_view.dart';
import 'package:charityapp/views/bloc/verifidecode_bloc/bloc/verifycode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              'QUÊN MẬT KHẨU',
              style: kText38BoldMain,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.h, 10.w),
              child: Text(
                'Nhập email bạn đã đăng ký và chúng tôi sẽ gửi một mã xác thực để bạn tiến hành việc đổi mật khẩu',
                style: kText18RegularGreyNoteText,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30.w, 0, 0, 10.h),
                child: Text(
                  'Email',
                  style: kText15RegularGreyText,
                ),
              ),
            ]),
            Padding(
                padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
                child: TextInput(
                  icon: Icons.mail,
                  background: Colors.white,
                  boder: maincolor,
                  hint: '',
                  labeltext: '',
                  textEditingController: emailcontroller,
                  textInputType: TextInputType.text,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
                child: CustomButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => VerifycodeBloc(),
                                        child: VerificationOtpView(
                                            email: emailcontroller.text.trim(),
                                            ischangepass: true),
                                      )))
                        },
                    textInput: 'GỬI MÃ OTP'))
          ],
        ),
      ),
    );
  }
}
