import 'package:charityapp/views/Pages/home_page/comment_view.dart';
import 'package:charityapp/views/Pages/home_page/event_page.dart';
import 'package:charityapp/views/root_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: true,
    home:
    Container(
        child: RootApp()),
    ));
}
