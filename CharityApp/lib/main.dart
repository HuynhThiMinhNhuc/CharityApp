import 'package:charityapp/views/Pages/route_generator.dart';
import 'package:charityapp/views/bloc/event_bloc/event.dart';
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
    ],
    child: MeerApp(),
  ));
}

class MeerApp extends StatelessWidget {
  final _appRoutes = RouteGenerator();
  MeerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
