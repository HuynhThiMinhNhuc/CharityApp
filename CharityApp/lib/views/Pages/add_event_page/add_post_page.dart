import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/add_event_page/add_event_page.dart';
import 'package:charityapp/views/Pages/add_event_page/chosse_eventview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: getAppBar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextButton(
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChossesEventView()),
                          )
                        },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Chọn sự kiện",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: 'Roboto_Regular',
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: Icon(Icons.navigate_next,
                              size: 20, color: textcolor),
                          splashRadius: 20,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChossesEventView()),
                            );
                          },
                        )
                      ],
                    )),
                Divider(color: Colors.grey[600], height: 1),
                SizedBox(
                  height: 10,
                ),
                textFormFieldWithTitle(
                  title: "Tiêu đề",
                  text: "",
                  iconData: null,
                  type: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Thêm ảnh",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontFamily: 'Roboto_Regular',
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      Text(
                        "Tối đa 10 ảnh",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'Roboto_Regular',
                          fontSize: 13,
                        ),
                      )
                    ]),
                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 120,
                      child: IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.add_photo_alternate_outlined,
                              color: maincolor, size: 25)),
                      decoration: BoxDecoration(
                          color: backgroundbottomtab,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
                    ),
                    SizedBox(width: 5),
                    // ListView.builder(
                    //   itemCount: 0,
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return ImageCard(
                    //       onImageChanged: (file) {},
                    //     );
                    //   },
                    // )
                  ],
                ),
                TextFormField(
                    cursorColor: maincolor,
                    keyboardType: TextInputType.name,
                    minLines: 3,
                    maxLines: 5,
                    style: TextStyle(
                        fontFamily: 'Roboto-Regular.ttf', fontSize: 15),
                    decoration: InputDecoration(
                        hintText: "Viết nội dung ở đây...",
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none)),
              ],
            ),
          ),
        ));
  }

  AppBar getAppBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: textcolor, //change your color here
      ),
      backgroundColor: backgroundbottomtab,
      centerTitle: true,
      title: Text("Tạo bài viết",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto_Regular',
              fontSize: 19,
              fontWeight: FontWeight.w600)),
      actions: [
        TextButton(
            onPressed: () => {},
            child: Text("Đăng",
                style: TextStyle(
                    color: maincolor,
                    fontFamily: 'Roboto_Regular',
                    fontSize: 17,
                    fontWeight: FontWeight.w600)))
      ],
    );
  }
}
