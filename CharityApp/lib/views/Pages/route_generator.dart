import 'package:charityapp/core/model/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    if (settings.name == AppRoutes.home) {

    }
    else if (settings.name == AppRoutes.addPost) {

    }
    else if (settings.name == AppRoutes.addEvent) {

    }
    else if (settings.name == AppRoutes.chooseEvent) {

    }
    else if (settings.name == AppRoutes.eventPage) {

    }
    else if (settings.name == AppRoutes.comment) {

    }
    return MaterialPageRoute(builder: (context) {
      return Text('fail page');
    });
  }
}