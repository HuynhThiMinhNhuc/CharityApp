import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/form_register.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/Pages/home_page/thankyou_view.dart';
import 'package:charityapp/views/bloc/form_bloc/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormView extends StatefulWidget {
  final BaseEvent event;
  const FormView({Key? key, required this.event}) : super(key: key);

  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  List<TextEditingController> _listController = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 6; i++) {
      _listController.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _listController.clear();

    super.dispose();
  }

  List<int> maxlines = [1, 5, 5, 1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: textColor),
          title: Text(
            "Form đăng kí",
            style: kText24BoldBlack,
          ),
          backgroundColor: backgroundBottomTab,
        ),
        body: getbody(),
        bottomNavigationBar: Container(
            height: 60.h,
            color: backgroundBottomTab,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 5.h),
                child: CustomButton(
                  onPressed: () {
                    final form = FormRegister(
                        name: _listController[0].text,
                        phone: _listController[1].text,
                        email: _listController[2].text,
                        questions: _listController
                            .skip(3)
                            .map((controller) => controller.text)
                            .toList(),
                        creatorId: Authenticator.Id,
                        eventId: widget.event.id!,
                        timeCreate: DateTime.now());

                    BlocProvider.of<FormBloc>(context)
                        .add(RegisterForm(form: form));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThanhYouPage(
                                  avataruri: GetIt.instance
                                      .get<Authenticator>()
                                      .userProfile
                                      .avatarUri!,
                                  event: widget.event.name,
                                  name: _listController[0].text,
                                )));
                  },
                  textInput: 'Đăng ký',
                ))));
  }

  Widget getbody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.event.name,
              style: kText24RegularBlack,
            ),
            SizedBox(
              height: 15.h,
            ),
            FormBody(
              listController: _listController,
              isReadonly: false,
            ),
          ],
        ),
      ),
    );
  }
}

class FormBody extends StatefulWidget {
  final List<TextEditingController> listController;
  final bool isReadonly;
  const FormBody(
      {Key? key, required this.listController, required this.isReadonly})
      : assert(listController.length > 2),
        super(key: key);

  @override
  State<FormBody> createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  List<TextEditingController> _questionController = [];
  final Map<String, int> items = {
    "Email": 1,
    "Bạn nghĩ mình sẽ giúp đỡ công việc tình nguyện này như thế nào?": 3,
    "Đối nét về bản thân( sở thích, tính cách, tài lẻ...)": 3,
    "Link Facebook(nếu có)": 1,
  };

  @override
  void initState() {
    super.initState();
    _nameController = widget.listController[0];
    _phoneController = widget.listController[1];

    for (int i = 0; i < items.length; i++) {
      _questionController.add(widget.listController[2 + i]);
    }

    getmyProfile();
  }

  void getmyProfile() {
    if (_nameController.text.isEmpty)
      _nameController.text = Authenticator.profile.name;
    if (_phoneController.text.isEmpty)
      _phoneController.text = Authenticator.profile.phone;
    if (_questionController[0].text.isEmpty)
      _questionController[0].text = Authenticator.profile.email;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _questionController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Tên",
            style: kText15BoldBlack,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            fillColor: Color(0xFFF4F4F4),
            filled: true,
            hintText: 'Nhập tên bạn tại đây',
            enabled: false,
            contentPadding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Số điện thoại",
            style: kText15BoldBlack,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        TextField(
          controller: _phoneController,
          decoration: InputDecoration(
              fillColor: Color(0xFFF4F4F4),
              filled: true,
              hintText: 'Nhập số điện thoại của bạn tại đây',
              enabled: false,
              contentPadding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0)),
        ),
        SizedBox(
          height: 20.h,
        ),
        Column(
            children: List.generate(items.length, (index) {
          return (TextInput(
            isReadonly: widget.isReadonly,
            title: items.keys.elementAt(index),
            maxline: items.values.elementAt(index),
            textController: _questionController[index],
          ));
        }))
      ],
    );
  }
}

class TextInput extends StatelessWidget {
  final String title;
  final int maxline;
  final bool isReadonly;
  final TextEditingController textController;
  const TextInput({
    Key? key,
    required this.title,
    this.maxline = 1,
    required this.isReadonly,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: kText15BoldBlack,
        ),
        SizedBox(
          height: 10.h,
        ),
        Theme(
          data: ThemeData(
            primaryColor: maincolor,
            primaryColorDark: Colors.red,
          ),
          child: TextField(
            controller: textController,
            maxLines: maxline,
            decoration: InputDecoration(
              enabled: !isReadonly,
              border: InputBorder.none,
              fillColor: Color(0xFFF4F4F4),
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: maincolor),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
