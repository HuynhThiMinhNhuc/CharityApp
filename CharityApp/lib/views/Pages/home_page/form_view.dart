import 'package:charityapp/Constant/post_jason.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/form_register.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/bloc/form_bloc/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormView extends StatefulWidget {
  final BaseEvent event;
  final String username;
  final String userphone;
  const FormView(
      {Key? key, this.username = '', this.userphone = '', required this.event})
      : super(key: key);

  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _question1Controller;
  late TextEditingController _question2Controller;
  late TextEditingController _question3Controller;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _question1Controller = TextEditingController();
    _question2Controller = TextEditingController();
    _question3Controller = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _question1Controller.dispose();
    _question2Controller.dispose();
    _question3Controller.dispose();
    super.dispose();
  }

  List<String> Items = [
    "Email",
    "Bạn nghĩ mình sẽ giúp đỡ công việc tình nguyện này như thế nào?",
    "Đối nét về bản thân( sở thích, tính cách, tài lẻ...)",
    "Link Facebook(nếu có)",
  ];
  List<int> maxlines = [1, 5, 5, 2];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: textcolor),
          title: Text(
            "Form đăng kí",
            style: TextStyle(
                fontFamily: 'Roboto_Regular',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textcolor),
          ),
          backgroundColor: backgroundbottomtab,
        ),
        body: getbody(),
        bottomNavigationBar: Container(
            height: 60,
            color: backgroundbottomtab,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: CustomButton(
                  onPressed: () {
                    String myId = '';
                    final form = FormRegister(
                        name: _nameController.text,
                        phone: _phoneController.text,
                        email: _emailController.text,
                        creatorId: myId,
                        eventId: widget.event.id!,
                        timeCreate: DateTime.now());
                        
                    BlocProvider.of<FormBloc>(context)
                        .add(RegisterForm(form: form));
                  },
                  textInput: 'Đăng ký',
                ))));
  }

  Widget getbody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.event.name,
              style: TextStyle(
                  fontFamily: 'Roboto_Regular',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textcolor),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Tên",
              style: TextStyle(
                  fontFamily: 'Roboto_Regular',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textcolor),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: widget.username,
                enabled: false,
                contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Số điện thoại",
              style: TextStyle(
                  fontFamily: 'Roboto_Regular',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textcolor),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: widget.userphone,
                  enabled: false,
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
                children: List.generate(Items.length, (index) {
              return (TextInput(
                Items: [],
                title: Items[index],
                maxline: maxlines[index],
              ));
            }))
          ],
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  final String title;
  final int maxline;
  const TextInput(
      {Key? key,
      required this.title,
      required this.Items,
      required this.maxline})
      : super(key: key);

  final List<String> Items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontFamily: 'Roboto_Regular',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: textcolor),
        ),
        SizedBox(
          height: 5,
        ),
        Theme(
          data: ThemeData(
            primaryColor: maincolor,
            primaryColorDark: Colors.red,
          ),
          child: TextField(
            maxLines: maxline,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: maincolor),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
