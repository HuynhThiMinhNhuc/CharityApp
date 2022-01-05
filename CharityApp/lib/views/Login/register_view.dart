import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Component/my_alert_dialog.dart';
import 'package:charityapp/views/Component/password_input.dart';
import 'package:charityapp/views/Component/text_input.dart';
import 'package:charityapp/views/Login/login_view.dart';
import 'package:charityapp/views/Login/verification_otp_view.dart';
import 'package:charityapp/views/bloc/signup_bloc/bloc/signup_bloc.dart';
import 'package:charityapp/views/bloc/verifidecode_bloc/bloc/verifycode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      new TextEditingController();
  final TextEditingController emailcontroller = new TextEditingController();

  var signupbloc;

  @override
  void initState() {
    super.initState();
    signupbloc = BlocProvider.of<SignupBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 0, 30),
                child: Row(children: [
                  IconButton(
                      onPressed: () => {Navigator.pop(context)},
                      icon: Icon(Icons.arrow_back)),
                ]),
              ),
              Text(
                'Đăng ký',
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
                'Tạo tài khoản mới',
                style: TextStyle(
                    color: notetextcolor,
                    fontSize: 18,
                    fontFamily: 'Roboto_Regular'),
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextInput(
                    icon: Icons.people,
                    background: backgrountbutton.withOpacity(0.2),
                    boder: maincolor.withOpacity(0.1),
                    hint: 'Email',
                    labeltext: '',
                    textEditingController: emailcontroller,
                    textInputType: TextInputType.emailAddress,
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: PassWordInput(
                  hint: 'Mật khẩu',
                  background: backgrountbutton,
                  boder: maincolor,
                  securitytext: false,
                  ispass: true,
                  textcontroller: passwordcontroller,
                  textInputType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: PassWordInput(
                  hint: 'Xác nhận mật khẩu',
                  background: backgrountbutton,
                  boder: maincolor,
                  securitytext: true,
                  ispass: true,
                  textcontroller: confirmpasswordcontroller,
                  textInputType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'Bằng cách đăng ký, bạn đã đồng ý với',
                        style: TextStyle(color: icon, fontSize: 14),
                      ),
                      TextSpan(
                          text: ' điều khoản sử dụng',
                          style: TextStyle(color: maincolor)),
                      TextSpan(
                        text: ' và',
                        style: TextStyle(color: icon, fontSize: 14),
                      ),
                      TextSpan(
                        text: ' chế độ riêng tư',
                        style: TextStyle(color: maincolor, fontSize: 14),
                      ),
                    ])),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: BlocListener<SignupBloc, SignupState>(
                  listener: (context, state) {
                    if (state is SignupSussesState) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (context) => VerifycodeBloc(),
                                  child: VerificationOtpView(
                                    email: this.emailcontroller.text.trim(),
                                    ischangepass: false,
                                  ))));
                    } else if (state is SignupFailEmailFomatState) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => MyAlertDialog(
                          content: 'Vui lòng nhập email hợp lệ',
                          title: "Email không hợp lệ",
                          pathImage:
                              'asset/imagesample/ImageAlerDIalog/wrong.png',
                        ),
                      );
                    } else if (state is SignupFailMutilAccountState) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => MyAlertDialog(
                          content:
                              'Vui lòng nhập địa chỉ email chưa từng tạo tài khoản bao giờ',
                          title: "Email đã được sử dụng",
                          pathImage:
                              'asset/imagesample/ImageAlerDIalog/wrong.png',
                        ),
                      );
                    } else if (state is SignupFailPassweakState) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => MyAlertDialog(
                          content: 'Mật khẩu phải chứa ít nhất 6 kí tự',
                          title: "Mật khẩu không hợp lệ",
                          pathImage:
                              'asset/imagesample/ImageAlerDIalog/wrong.png',
                        ),
                      );
                    } else if (state is SignupIncorrectPassConfirmState) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => MyAlertDialog(
                          content:
                              'Mật khẩu xác nhận phải trùng với mật khẩu vừa đặt',
                          title: "Mật khẩu xác nhận không trùng khớp",
                          pathImage:
                              'asset/imagesample/ImageAlerDIalog/wrong.png',
                        ),
                      );
                    } else if (state is SignupEmptyFeldmState) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => MyAlertDialog(
                          content: 'Vui lòng điền đầy đủ thông tin',
                          title: "Không được để trống",
                          pathImage:
                              'asset/imagesample/ImageAlerDIalog/wrong.png',
                        ),
                      );
                    } else if (state is SignupNoReasonState) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => MyAlertDialog(
                          content:
                              'Hệ thống đang gặp lỗi, chúng tôi sẽ cố gắng sửa lỗi sớm. Vui lòng thử lại sau',
                          title: "Lỗi không xác định",
                          pathImage:
                              'asset/imagesample/ImageAlerDIalog/wrong.png',
                        ),
                      );
                    }
                  },
                  child: CustomButton(
                    onPressed: () => {
                      signupbloc.add(SignupWithEmailAndPassEvent(
                          emailcontroller.text.trim(),
                          passwordcontroller.text.trim(),
                          confirmpasswordcontroller.text.trim()))
                    },
                    textInput: 'ĐĂNG KÝ',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Bạn đã có tài khoản?',
                      style: TextStyle(
                        color: icon,
                        fontSize: 16,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    child: Text(' Đăng nhập!',
                        style: TextStyle(
                            color: redcolor,
                            fontSize: 17,
                            fontWeight: FontWeight.w600)),
                    onPressed: () => {Navigator.pop(context)},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}