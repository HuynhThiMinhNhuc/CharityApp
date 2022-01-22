import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThanhYouPage extends StatefulWidget {
  final String name;
  final String event;
  final String avataruri;
  const ThanhYouPage(
      {Key? key,
      required this.avataruri,
      required this.name,
      required this.event})
      : super(key: key);

  @override
  _ThanhYouPage createState() => _ThanhYouPage();
}

class _ThanhYouPage extends State<ThanhYouPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();

    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.w, 0, 0, 10.h),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 132.w,
                        height: 142.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("asset/imageInpage/heart.png")),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("Cảm ơn",
                          style: TextStyle(
                            fontFamily: "Redressed-Regular.ttf",
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w600,
                          )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("vì form đăng kí của bạn",
                          style: kText15RegularGreyText),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 138.h,
                        height: 138.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: activecolor)),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            width: 138.h,
                            height: 138.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 3.h),
                              image: DecorationImage(
                                  image: (widget.avataruri == "")
                                      ? AssetImage('asset/avatar.png')
                                          as ImageProvider
                                      : NetworkImage(widget.avataruri),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(widget.name, style: kText20RegularBlack),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("Yêu cầu của bạn đã được gửi đến chủ sự kiện:",
                          style: kText15RegularGreyText),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(widget.event,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Roboto-Regular.ttf",
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600)),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 0),
                        child: CustomButton(
                            onPressed: () => {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      AppRoutes.home, (route) => false)
                                },
                            textInput: ("Trang chủ")),
                      )
                    ]),
              ),
            ),
          )),
    );
  }
}
