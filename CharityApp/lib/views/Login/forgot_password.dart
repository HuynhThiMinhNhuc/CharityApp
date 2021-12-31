import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Component/text_input.dart';
import 'package:charityapp/views/Login/verification_otp_view.dart';
import 'package:charityapp/views/bloc/verifidecode_bloc/bloc/verifycode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              padding: EdgeInsets.fromLTRB(20, 50, 0, 50),
              child: Row(children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back)),
              ]),
            ),
            Text(
              'QUÊN MẬT KHẨU',
              style: TextStyle(
                  color: maincolor,
                  fontSize: 38,
                  fontFamily: 'Roboto-Regular.ttf',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Text(
                'Nhập email bạn đã đăng ký và chúng tôi sẽ gửi một mã xác thực để bạn tiến hành việc đổi mật khẩu',
                style: TextStyle(
                    color: notetextcolor,
                    fontSize: 16,
                    fontFamily: 'Roboto_Regular'),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                child: Text(
                  'Email',
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
                  icon: Icons.mail,
                  background: Colors.white,
                  boder: maincolor,
                  hint: '',
                  labeltext: '',
                  textEditingController: emailcontroller,
                  textInputType: TextInputType.text,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
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
