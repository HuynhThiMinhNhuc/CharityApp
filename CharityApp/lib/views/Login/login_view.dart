import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/main.dart';
import 'package:charityapp/views/Component/password_input.dart';
import 'package:charityapp/views/Login/forgot_password.dart';
import 'package:charityapp/views/Login/register_view.dart';
import 'package:charityapp/views/Login/verification_otp_view.dart';
import 'package:charityapp/views/bloc/activeuser_bloc/activeuser_bloc.dart';
import 'package:charityapp/views/bloc/editprofile_bloc/bloc/editprofile_bloc.dart';
import 'package:charityapp/views/bloc/friend_bloc/friend_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/searchevent_bloc/bloc/searchevent_bloc.dart';
import 'package:charityapp/views/bloc/signin_bloc/signin_bloc.dart';
import 'package:charityapp/views/bloc/signup_bloc/bloc/signup_bloc.dart';
import 'package:charityapp/views/bloc/tab_bloc/tab_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animations/animations.dart';

import '../Root_App.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool securtytext = false;
  final IconData eye = Icons.remove_red_eye_outlined;
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController emailcontroller = new TextEditingController();

  var signinBloc;

  @override
  void initState() {
    super.initState();
    signinBloc = BlocProvider.of<SigninBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Image(
                //   image: AssetImage('asset/Login.png'),
                //   height: 280,
                //   width: MediaQuery.of(context).size.width,
                // ),
                //,
                Text(
                  'Xin chào',
                  style: TextStyle(
                      color: maincolor,
                      fontSize: 38,
                      fontFamily: 'Roboto_Regular',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Đăng nhập vào tài khoản của bạn',
                  style: TextStyle(
                      color: notetextcolor,
                      fontSize: 18,
                      fontFamily: 'Roboto_Regular'),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.people,
                        color: maincolor,
                        size: 23,
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
                      hintStyle: TextStyle(
                          color: hinttextcolor,
                          fontSize: 15,
                          fontFamily: 'Roboto-Thin.tff'),
                      fillColor:
                          backgrountbutton.withOpacity(0.2).withOpacity(0.2),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: PassWordInput(
                    textInputType: TextInputType.text,
                    hint: 'Mật khẩu',
                    background: backgrountbutton,
                    boder: maincolor,
                    securitytext: true,
                    ispass: true,
                    textcontroller: passwordcontroller,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          onPressed: () => {},
                          icon: Icon(
                            Icons.check_circle,
                            color: maincolor,
                            size: 20,
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
                          style: TextStyle(
                              color: maincolor,
                              fontFamily: 'Roboto-Regular.ttf',
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: BlocListener<SigninBloc, SigninState>(
                    listenWhen: (context, state) {
                      return state is SigninfailEmailState ||
                          state is SigninfailPassState ||
                          state is SigninSussessState;
                    },
                    listener: (context, state) {
                      if (state is SigninfailEmailState) {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlerDialogFailEmail();
                          },
                        );
                      } else if (state is SigninfailPassState) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertFailPassword(),
                        );
                      } else if (state is SigninSussessState) {
                        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (BuildContext context) =>
                        //           MultiBlocProvider(
                        //             providers: [
                        //               BlocProvider<TabBloc>(
                        //                 create: (context) => TabBloc(),
                        //               ),
                        //               BlocProvider<FriendBloc>(
                        //                 create: (context) => FriendBloc(),
                        //               ),
                        //               BlocProvider<EditprofileBloc>(
                        //                 create: (context) => EditprofileBloc(),
                        //               ),
                        //               BlocProvider<OverViewUserBloc>(
                        //                 create: (context) => OverViewUserBloc(),
                        //               ),
                        //               BlocProvider<ActiveuserBloc>(
                        //                 create: (context) => ActiveuserBloc(),
                        //               ), 
                        //             ],
                        //             child: RootApp(loadactiveuser: true,),
                        //           )),
                        //   (route) => false,
                        // );
                      }
                    },
                    child: BlocBuilder<SigninBloc, SigninState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () => {
                            signinBloc.add(SigninWithEmailAndPassEvent(
                                emailcontroller.text.trim(),
                                passwordcontroller.text.trim()))
                          },
                          child: Text(
                            'Đăng nhập',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                              alignment: Alignment.center,
                              primary: maincolor,
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Hoặc sử dụng',
                  style: TextStyle(
                      color: notetextcolor,
                      fontSize: 15,
                      fontFamily: 'Roboto-Regular.ttf'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => {},
                      icon: FaIcon(FontAwesomeIcons.google),
                      iconSize: 35,
                    ),
                    IconButton(
                      onPressed: () => {},
                      icon: FaIcon(FontAwesomeIcons.facebookF),
                      iconSize: 35,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Bạn chưa có tài khoản?',
                        style: TextStyle(
                          color: icon,
                          fontSize: 16,
                        )),
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
                      child: Text('Đăng ký!',
                          style: TextStyle(
                              color: redcolor,
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlertFailPassword extends StatelessWidget {
  const AlertFailPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Icon(Icons.ac_unit_outlined),
          const Text('Sai mật khẩu'),
        ],
      ),
      content: const Text('Vui lòng nhập đúng mật khẩu đã đăng ký'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Đồng ý'),
          child: const Text('Đồng ý'),
        ),
      ],
    );
  }
}

class AlerDialogFailEmail extends StatelessWidget {
  const AlerDialogFailEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sai Email'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('Nhập email sai'),
            Text('Vui lòng nhập lại email mà bạn đã đăng ký'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Đồng ý'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
