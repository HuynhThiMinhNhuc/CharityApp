import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Login/profile_view.dart';
import 'package:charityapp/views/bloc/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeView extends StatefulWidget {
  final String email;

  WelcomeView({Key? key, required this.email}) : super(key: key);

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: textcolor, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: () => {},
                icon: FaIcon(
                  FontAwesomeIcons.checkCircle,
                  color: maincolor,
                  size: 30,
                ),
                label: Text(
                  'Đăng ký thành công',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto-Regular.ttf',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              '  Chào mừng đến với MEER',
              style: TextStyle(
                  color: maincolor,
                  fontSize: 28,
                  fontFamily: 'Roboto_Regular',
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                  'Tình nguyện không phải công việc cá nhân đó là sự gắn kết của xã hội',
                  maxLines: 4,
                  style: TextStyle(
                    color: notetextcolor,
                    fontFamily: 'Roboto-Regular.tff',
                    fontSize: 16,
                  )),
            ),
            Center(
              child: Image(
                image: AssetImage('asset/welcome.png'),
                width: 350,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => ProfileBloc(),
                                      child: Profile(email: widget.email),
                                    )))
                      },
                  textInput: 'BẮT ĐẦU'),
            )
          ],
        ),
      ),
    );
  }
}
