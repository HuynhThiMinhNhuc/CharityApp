import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/dialog_with_circle_above.dart';
import 'package:charityapp/views/Component/indicater_logintohome.dart';
import 'package:charityapp/views/Component/loading_dialog.dart';
import 'package:charityapp/views/Component/password_input.dart';
import 'package:charityapp/views/Login/forgot_password.dart';
import 'package:charityapp/views/Login/register_view.dart';
import 'package:charityapp/views/bloc/signin_bloc/signin_bloc.dart';
import 'package:charityapp/views/bloc/signup_bloc/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:async/async.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final IconData eyeIcon = Icons.remove_red_eye_outlined;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  CancelableOperation? isLoading;
  late LoadingDialog loadingDialog;

  var signinBloc;

  @override
  void initState() {
    super.initState();
    signinBloc = BlocProvider.of<SigninBloc>(context);
    loadingDialog = LoadingDialog(context);
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('asset/login.png'),
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Đăng nhập vào tài khoản của bạn',
                  style: kText18RegularGreyNoteText,
                ),
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.people,
                        color: maincolor,
                        size: 23.h,
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: redcolor.withOpacity(1), width: 1)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: redcolor.withOpacity(1), width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: maincolor.withOpacity(1), width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: maincolor.withOpacity(1), width: 1)),
                      hintText: 'Email',
                      hintStyle: kText15BoldGreyHintText,
                      fillColor:
                          backgrountbutton.withOpacity(0.2).withOpacity(0.2),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                  child: PassWordInput(
                    textInputType: TextInputType.text,
                    hint: 'Mật khẩu',
                    background: backgrountbutton,
                    boder: maincolor,
                    securitytext: true,
                    ispass: true,
                    textcontroller: passwordController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          onPressed: () => {},
                          icon: Icon(
                            Icons.check_circle,
                            color: maincolor,
                            size: 20.h,
                          ),
                          label: Text(
                            'Nhớ tài khoản',
                            style: TextStyle(color: icon),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                        child: Text(
                          'Quên mật khẩu?',
                          style: kText14BoldMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
                  child: BlocConsumer<SigninBloc, SigninState>(
                    listener: (context, state) {
                      if (state is SignInLoadInProccess) {
                        // if (isLoading != null && !isLoading!.isCompleted)
                        //   return;
                        // isLoading = CancelableOperation.fromFuture(showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return IndicatorDialog();
                        //     }));
                        loadingDialog.load(IndicatorDialog());
                      } else {
                        // isLoading?.cancel();
                        loadingDialog.cancel();
                        
                        if (state is SigninfailEmailState) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              DialogWithCircleAbove(
                            content: 'Vui lòng nhập đúng email đã đăng ký!',
                            mode: ModeDialog.warning,
                            title: 'Sai Email',
                          ),
                        );
                      } else if (state is SigninfailPassState) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              DialogWithCircleAbove(
                            content: 'Vui lòng nhập đúng mật khẩu đã đăng ký!',
                            mode: ModeDialog.warning,
                            title: 'Sai mật khẩu',
                          ),
                          // => MyAlertDialog(
                          //     content:
                          //         "Vui lòng nhập đúng mật khẩu đã đăng ký!",
                          //     pathImage:
                          //         "asset/imagesample/ImageAlerDIalog/wrong.png",
                          //     title: "Sai mật khẩu"),
                        );
                      } else if (state is SigninSuccessState) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.home, (route) => false);
                      }
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () => {
                          signinBloc.add(SigninWithEmailAndPassEvent(
                              emailController.text.trim(),
                              passwordController.text.trim()))
                        },
                        child: Text(
                          'Đăng nhập',
                          style: kText18BoldWhite,
                        ),
                        style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            primary: maincolor,
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 60.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text('Hoặc sử dụng', style: kText15RegularGreyText),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => {},
                      icon: FaIcon(FontAwesomeIcons.google),
                      iconSize: 35.h,
                    ),
                    IconButton(
                      onPressed: () => {},
                      icon: FaIcon(FontAwesomeIcons.facebookF),
                      iconSize: 35.h,
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => SignupBloc(),
                                child: RegisterView(),
                              )),
                    );
                  },
                  child: RichText(
                      text: TextSpan(
                          text: "Bạn chưa có tài khoản?",
                          style: kText16RegularGreyText,
                          children: <TextSpan>[
                        TextSpan(text: ' Đăng ký!', style: kText17RegularRed),
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class AlertFailPassword extends StatelessWidget {
//   const AlertFailPassword({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Column(
//         children: [
//           Icon(Icons.ac_unit_outlined),
//           const Text('Sai mật khẩu'),
//         ],
//       ),
//       content: const Text('Vui lòng nhập đúng mật khẩu đã đăng ký'),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () => Navigator.pop(context, 'Đồng ý'),
//           child: const Text('Đồng ý'),
//         ),
//       ],
//     );
//   }
// }

// class AlerDialogFailEmail extends StatelessWidget {
//   const AlerDialogFailEmail({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Sai Email'),
//       content: SingleChildScrollView(
//         child: ListBody(
//           children: const <Widget>[
//             Text('Nhập email sai'),
//             Text('Vui lòng nhập lại email mà bạn đã đăng ký'),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: const Text('Đồng ý'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }
// }
