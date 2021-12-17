import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/views/bloc/event_bloc/bloc/event.dart';
import 'package:charityapp/views/root_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injector.dart';
import 'repositories/event_repository_imp.dart';
import 'views/Pages/add_event_page/add_event_page.dart';
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
      // home: MultiBlocProvider(
      //   providers: [
      //     BlocProvider<TabBloc>(
      //       create: (context) => TabBloc(),
      //     ),
      //     BlocProvider<EventBloc>(
      //       create: (context) => EventBloc(
      //           repository: EventRepositoryImp(
      //               FirebaseFirestore.instance.collection("events"))),
      //     ),
      //   ],
      //   child: RootApp(),
      // ),
      routes: {
        AppRoutes.home: (context) {
          return BlocProvider<TabBloc>(
            create: (context) => TabBloc(),
            child: RootApp(),
          );
        },
        AppRoutes.addPost: (context) {
          return BlocProvider<EventBloc>(
            create: (context) => EventBloc(
                repository: EventRepositoryImp(
                    FirebaseFirestore.instance.collection("events"))),
            child: BlocBuilder<EventBloc, EventState>(
              builder: (context, state) {
                return AddEventPage(
                  onClickSubmit: (newEvent) {
                    print("add new Event");
                    BlocProvider.of<EventBloc>(context)
                        .add(AddEvent(event: newEvent));
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
