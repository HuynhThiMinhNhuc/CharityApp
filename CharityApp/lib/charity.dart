// ignore: unused_import
import 'package:charityapp/views/ChangePassword.dart';
import 'package:charityapp/views/Forgotpass.dart';
import 'package:charityapp/views/Login.dart';
import 'package:charityapp/views/Profile.dart';
import 'package:charityapp/views/Register.dart';
import 'package:charityapp/views/Splash2.dart';
import 'package:charityapp/views/Verification_code.dart';
import 'package:charityapp/views/Welcome.dart';
import 'package:flutter/material.dart';

class charity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: changepassword(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    );
  }
}
