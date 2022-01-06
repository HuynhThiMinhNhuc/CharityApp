import 'package:charityapp/domain/entities/form_register.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/route_generator.dart';
import 'package:charityapp/views/bloc/event_bloc/event.dart';
import 'package:charityapp/views/bloc/form_bloc/form.dart';
import 'package:charityapp/views/bloc/like_post_bloc/like_post.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injector.dart';
import 'views/bloc/post_bloc/post.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<EventTabBloc>(
        create: (context) => EventTabBloc(),
      ),
      BlocProvider<PostBloc>(
        create: (context) => PostBloc(),
      ),
      BlocProvider<LikePostBloc>(
        create: (context) => LikePostBloc(),
      ),
      BlocProvider<FormBloc>(
        create: (context) => FormBloc(),
      )
    ],
    child: MeerApp(),
  ));
}

class MeerApp extends StatelessWidget {
  final _appRoutes = RouteGenerator();
  Map<int, Color> maincolor = {
    50: Color.fromRGBO(90, 164, 105, .1),
    200: Color.fromRGBO(90, 164, 105, .3),
    300: Color.fromRGBO(90, 164, 105, .4),
    400: Color.fromRGBO(90, 164, 105, .5),
    500: Color.fromRGBO(90, 164, 105, .6),
    600: Color.fromRGBO(90, 164, 105, .7),
    700: Color.fromRGBO(90, 164, 105, .8),
    800: Color.fromRGBO(90, 164, 105, .9),
    900: Color.fromRGBO(90, 164, 105, .1),
    100: Color.fromRGBO(90, 164, 105, .2),
  };
  MeerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('vi', ''), // VietNam, no country code
      ],
      debugShowCheckedModeBanner: true,
      onGenerateRoute: _appRoutes.generateRoute,
    );
  }
}
