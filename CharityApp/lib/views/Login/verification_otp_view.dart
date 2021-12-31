import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Component/otp_textfield.dart';
import 'package:charityapp/views/Login/forgot_password.dart';
import 'package:charityapp/views/Login/register_view.dart';
import 'package:charityapp/views/Login/welcome_view.dart';
import 'package:charityapp/views/Pages/profile_page/changepassforgot.dart';
import 'package:charityapp/views/bloc/changepassforgot_bloc/bloc/changepassforgot_bloc.dart';
import 'package:charityapp/views/bloc/verifidecode_bloc/bloc/verifycode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerificationOtpView extends StatefulWidget {
  final bool ischangepass;
  final String email;
  TextEditingController onecontrolller = new TextEditingController();
  TextEditingController twocontrolller = new TextEditingController();
  TextEditingController threecontrolller = new TextEditingController();
  TextEditingController fourcontrolller = new TextEditingController();
  TextEditingController fivecontrolller = new TextEditingController();
  TextEditingController sixcontrolller = new TextEditingController();
  VerificationOtpView(
      {Key? key, required this.email, required this.ischangepass})
      : super(key: key);
  @override
  _VerificationOtpViewState createState() => _VerificationOtpViewState();
}

class _VerificationOtpViewState extends State<VerificationOtpView> {
  var verifyCodeBloc;
  @override
  void initState() {
    super.initState();
    verifyCodeBloc = BlocProvider.of<VerifycodeBloc>(context);
    verifyCodeBloc.add(VerifycodeInitEvent(widget.email));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 0, 50),
                child: Row(children: [
                  IconButton(
                      onPressed: () => {Navigator.pop(context)},
                      icon: Icon(Icons.arrow_back)),
                ]),
              ),
              Text(
                'Xác nhận mã',
                style: TextStyle(
                    color: maincolor,
                    fontSize: 38,
                    fontFamily: 'Roboto-Regular.ttf',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Nhập mã OTP đã được gửi đến',
                style: TextStyle(
                    color: notetextcolor,
                    fontSize: 18,
                    fontFamily: 'Roboto_Regular'),
              ),
              Text(
                widget.email,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Roboto_Regular',
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 70, 30, 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      OtpTextField(
                        next: true,
                        textEditingController: widget.onecontrolller,
                      ),
                      OtpTextField(
                        next: true,
                        textEditingController: widget.twocontrolller,
                      ),
                      OtpTextField(
                        next: true,
                        textEditingController: widget.threecontrolller,
                      ),
                      OtpTextField(
                        next: false,
                        textEditingController: widget.fourcontrolller,
                      ),
                      OtpTextField(
                        next: false,
                        textEditingController: widget.fivecontrolller,
                      ),
                      OtpTextField(
                        next: false,
                        textEditingController: widget.sixcontrolller,
                      )
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Chưa nhập được mã OTP?',
                      style: TextStyle(
                        color: icon,
                        fontSize: 14,
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  TextButton(
                    child: Text(' GỬI LẠI OTP (112)',
                        style: TextStyle(
                            color: redcolor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    onPressed: () =>
                        {verifyCodeBloc.add(VerifycodeInitEvent(widget.email))},
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 70, 30, 10),
                  child: BlocListener<VerifycodeBloc, VerifycodeState>(
                    listener: (context, state) {
                      if (state is VerifycodeSucessState) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => !widget.ischangepass
                                    ? WelcomeView(email: widget.email)
                                    : BlocProvider(
                                        create: (context) => ChangepassforgotBloc(),
                                        child: ChangePassforgotprofile(
                                            email: widget.email),
                                      )));
                      } else if (state is VerifycodeFailState) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                AlertDialogCustom(
                                  title: "Mã OTP sai",
                                  content: "",
                                  pathImage:
                                      'asset/imagesample/ImageAlerDIalog/wrong.png',
                                ));
                      }
                    },
                    child: CustomButton(
                        onPressed: () => {
                              this.verifyCodeBloc.add(VerifycodeVerifyEvent(
                                  widget.onecontrolller.text +
                                      widget.twocontrolller.text +
                                      widget.threecontrolller.text +
                                      widget.fourcontrolller.text +
                                      widget.fivecontrolller.text +
                                      widget.sixcontrolller.text,
                                  widget.email))
                            },
                        textInput: 'XÁC NHẬN'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
