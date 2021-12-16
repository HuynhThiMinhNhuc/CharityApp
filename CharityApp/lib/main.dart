import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Pages/home_page/comment_view.dart';
import 'package:charityapp/views/Pages/home_page/event_page.dart';
import 'package:charityapp/views/Pages/profile_page/profile_page.dart';
import 'package:charityapp/views/root_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDependencies();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: true,
    home: RootApp()

    // Container(
    //     child: Scaffold
    //       (
    //         appBar: AppBar(
    //           title : Text("Hồ sơ")
    //         ),
    //         body: ProfilePage(userprofile: GetIt.instance.get<Authenticator>().idCurrentUser, posts: null,))
    // ),
    ));
}
