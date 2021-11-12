import 'package:charityapp/Constant/user_json.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class editprofile extends StatefulWidget {
  const editprofile({Key? key}) : super(key: key);

  @override
  _editprofileState createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  String dropvalue = users[0]['gender'] ? "Nữ" : "Nam";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80), child: getappbar()),
        body: getbody());
  }

  Widget getappbar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppBar(
          backgroundColor: backgroundbottomtab,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: null,
                child: Text(
                  "Hủy",
                  style: TextStyle(
                      color: textcolor,
                      fontFamily: 'Roboto_Regular',
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ),
              TextButton(
                onPressed: null,
                child: Text(
                  "Chỉnh sửa",
                  style: TextStyle(
                      color: textcolor,
                      fontFamily: 'Roboto_Regular',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: null,
                child: Text(
                  "Hoàn thành",
                  style: TextStyle(
                      color: maincolor,
                      fontFamily: 'Roboto_Regular',
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget getbody() {
    return SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              width: 106,
              height: 106,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: activecolor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Column(
                  children: <Widget>[
                    Stack(children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          image: DecorationImage(
                              image: NetworkImage(users[0]['img']),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(Icons.camera_enhance_outlined,
                                color: maincolor),
                          ))
                    ])
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  Container(
                    width: 110,
                    child: Text(
                      "Tên",
                      style: TextStyle(
                          color: textcolor,
                          fontFamily: 'Roboto_Regular',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      initialValue: users[0]['name'],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  Container(
                    width: 110,
                    child: Text(
                      "Ngày sinh",
                      style: TextStyle(
                          color: textcolor,
                          fontFamily: 'Roboto_Regular',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      initialValue: users[0]['birth'],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  Container(
                    width: 110,
                    child: Text(
                      "Mô tả",
                      style: TextStyle(
                          color: textcolor,
                          fontFamily: 'Roboto_Regular',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Flexible(
                        child: TextFormField(
                          initialValue: users[0]['decs'],
                        ),
                      )),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Thông tin mật",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: textcolor,
                      fontFamily: 'Roboto_Regular',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  Container(
                    width: 110,
                    child: Text(
                      "Email",
                      style: TextStyle(
                          color: textcolor,
                          fontFamily: 'Roboto_Regular',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      initialValue: users[0]['email'],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  Container(
                    width: 110,
                    child: Text(
                      "Số điện thoại",
                      style: TextStyle(
                          color: textcolor,
                          fontFamily: 'Roboto_Regular',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      initialValue: users[0]['phone'],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  Container(
                    width: 110,
                    child: Text(
                      "Giới tính",
                      style: TextStyle(
                          color: textcolor,
                          fontFamily: 'Roboto_Regular',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: DropdownButton(
                      value: dropvalue,
                      icon: Icon(Icons.arrow_drop_down_outlined),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropvalue = newValue!;
                        });
                      },
                      underline: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                      items: <String>['Nam', 'Nữ']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),

                ],
              ),
            ),
            Divider(color: const Color(0xff3C3C43),),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children:<Widget> [
                  Expanded(
                    child: Text(
                          "Đổi mật khẩu",
                          style: TextStyle(
                              color: textcolor,
                              fontFamily: 'Roboto_Regular',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                  ),
                  IconButton(
                  onPressed: null, 
                  icon: Icon (Icons.navigate_next))
                ],
                ),
            ),
            Divider(color: const Color(0xff3C3C43),)
            
          ],
        ),
      ),
    );
  }
}
