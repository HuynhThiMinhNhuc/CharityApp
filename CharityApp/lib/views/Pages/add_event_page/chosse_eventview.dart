import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/add_event_page/Witgets/event_card_view.dart';
import 'package:flutter/material.dart';

class ChossesEventView extends StatefulWidget {
  const ChossesEventView({Key? key}) : super(key: key);

  @override
  _ChossesEventViewState createState() => _ChossesEventViewState();
}

class _ChossesEventViewState extends State<ChossesEventView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return EventCardView(
                      number: 3,
                      time: DateTime.now(),
                      title: 'Sự kiện vận chuyển đồ đạc cho người già neo đơn',
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: backgroundbottomtab,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: textcolor, //change your color here
      ),
      title: Text(
        "Chọn sự kiện",
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto_Regular',
            fontSize: 19,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
