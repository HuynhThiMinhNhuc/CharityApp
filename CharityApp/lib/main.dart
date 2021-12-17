import 'package:charityapp/views/root_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injector.dart';
import 'views/bloc/tab_bloc/tab_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDependencies();
  runApp(MeerApp());
}

class MeerApp extends StatelessWidget {
  const MeerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<TabBloc>(create: (context) => TabBloc()),
          ],
          child: RootApp(),
        ));
  }
}
