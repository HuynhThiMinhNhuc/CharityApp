import 'package:charityapp/charity.dart';
import 'package:charityapp/views/HomeView/profile_overview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text('CharityApp'))),
        body: ProfileOverView("Vũ Ngọc Thạch", DateTime.now(),
            "Hong có gì để nói", [25, 50, 100]),
      ),
    );
  }
}
