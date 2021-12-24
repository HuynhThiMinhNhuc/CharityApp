import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/views/bloc/editprofile_bloc/bloc/editprofile_bloc.dart';
import 'package:charityapp/views/bloc/event_bloc/event.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/root_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injector.dart';
import 'repositories/event_repository_imp.dart';
import 'views/Pages/add_event_page/add_event_page.dart';
import 'views/bloc/post_bloc/post.dart';
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
      routes: {
        AppRoutes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<EditprofileBloc>(
                create: (context) => EditprofileBloc(),
              ),
              BlocProvider<PostBloc>(
                create: (context) => PostBloc(),
              ),
              BlocProvider<OverViewUserBloc>(
                create: (context) => OverViewUserBloc( ),
              ),
              

            ],
            child: RootApp(),
          );
        },
        AppRoutes.addPost: (context) {
          print("create new addpost route");
          return BlocProvider<EventBloc>(
            create: (context) => EventBloc(
                repository: EventRepositoryImp()),
            child: BlocConsumer<EventBloc, EventState>(
              listener: (context, state) async {
                if (state is EventUpdated) {
                  showMyDialog(context, "Thêm sự kiện thành công");
                } else if (state is EventLoadFailure) {
                  print("add fail");
                  showMyDialog(context, "Thêm sự kiện thất bại");
                }
              },
              builder: (context, state) {
                return AddEventPage(
                    // onClickSubmit: (newEvent, {avatarImage, backgroundImage}) {
                    //   print("add new Event");
                    //   BlocProvider.of<EventBloc>(context).add(AddEvent(
                    //       event: newEvent,
                    //       avartarFile: avatarImage,
                    //       backgroundFile: backgroundImage));
                    // },
                    );
              },
            ),
          );
        }
      },
    );
  }

  void showMyDialog(BuildContext context, String text) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 30.0),
          content: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: Text(text, textAlign: TextAlign.center),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Text(
                      "Đồng ý",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () => Navigator.of(context)
                      .popUntil(ModalRoute.withName(AppRoutes.home)),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
