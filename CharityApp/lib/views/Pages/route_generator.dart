import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/views/Login/login_view.dart';
import 'package:charityapp/views/Root_App.dart';
import 'package:charityapp/views/bloc/activeuser_bloc/activeuser_bloc.dart';
import 'package:charityapp/views/bloc/calendar_bloc/calendar.dart';
import 'package:charityapp/views/bloc/editprofile_bloc/bloc/editprofile_bloc.dart';
import 'package:charityapp/views/bloc/event_bloc/event.dart';
import 'package:charityapp/views/bloc/form_bloc/form.dart';
import 'package:charityapp/views/bloc/friend_bloc/friend_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
import 'package:charityapp/views/bloc/signin_bloc/signin_bloc.dart';
import 'package:charityapp/views/bloc/tab_bloc/tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'add_event_page/add_event_page.dart';
import 'add_event_page/add_post_page.dart';
import 'add_event_page/chosse_eventview.dart';
import 'home_page/comment_view.dart';
import 'home_page/event_page.dart';
import 'home_page/form_view.dart';

class RouteGenerator {
  Route generateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.login) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => BlocProvider(
          create: (_) => SigninBloc(),
          child: Login(),
        ),
      );
    } else if (settings.name == AppRoutes.home) {
      return PageTransition(
        type: PageTransitionType.bottomToTop,
        settings: settings,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TabBloc>(
              create: (context) => TabBloc(),
            ),
            BlocProvider<FriendBloc>(
              create: (context) => FriendBloc(),
            ),
            BlocProvider<EditprofileBloc>(
              create: (context) => EditprofileBloc(),
            ),
            BlocProvider<OverViewUserBloc>(
              create: (context) => OverViewUserBloc(),
            ),
            BlocProvider<ActiveuserBloc>(
              create: (context) => ActiveuserBloc(),
            ),
            BlocProvider(
              create: (context) => CalendarBloc(),
            )
          ],
          child: RootApp(),
        ),
      );
    } else if (settings.name == AppRoutes.addPost) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          print("create add_post route");
          return BlocListener<PostBloc, PostState>(
            listener: (bloc_context, state) async {
              if (state is PostUpdated) {
                await showMyDialog(bloc_context, 'Thêm bài viết thành công');
                Navigator.of(context).pushNamed(
                  AppRoutes.eventPage,
                  arguments: state.post.eventId,
                );
              } else if (state is PostLoadFailure) {
                showMyDialog(bloc_context, 'Thêm bài viết thất bại',
                    closeWhenClick: false);
              }
            },
            child: AddPostPage(
              onClickSubmit: (post, images) {
                BlocProvider.of<PostBloc>(context).add(
                  AddPost(post: post, images: images),
                );
              },
            ),
          );
        },
      );
    } else if (settings.name == AppRoutes.addEvent) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          print("create add_event route");
          return BlocConsumer<EventTabBloc, EventTabState>(
            listener: (context, state) async {
              if (state is EventUpdateSuccess) {
                showMyDialog(context, "Thêm sự kiện thành công");
              } else if (state is EventLoadFailure) {
                showMyDialog(context, "Thêm sự kiện thất bại",
                    closeWhenClick: false);
              }
            },
            builder: (context, state) {
              return AddEventPage(
                onClickSubmit: (newEvent, {avatarImage, backgroundImage}) {
                  print("add new Event");
                  BlocProvider.of<EventTabBloc>(context).add(
                    AddEvent(
                        event: newEvent,
                        avartarFile: avatarImage,
                        backgroundFile: backgroundImage),
                  );
                },
              );
            },
          );
        },
      );
    } else if (settings.name == AppRoutes.chooseEvent) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => ChossesEventView(),
      );
    } else if (settings.name == AppRoutes.eventPage) {
      final eventId = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => BlocProvider(
          create: (_) => EventTitleCubit(),
          child: EventPage(eventId: eventId),
        ),
      );
      //  PageRouteBuilder(
      //     transitionsBuilder: (BuildContext context,
      //         Animation<double> animation,
      //         Animation<double> secondaryAnimation,
      //         child) {
      //       return child;
      //     },
      //     settings: settings,
      //     pageBuilder: (BuildContext context, Animation<double> animation,
      //             Animation<double> secondaryAnimation) =>
      //         Align(
      //           child: SizeTransition(
      //             sizeFactor: animation,
      //             child: BlocProvider(
      //               create: (_) => EventTitleCubit(),
      //               child: EventPage(eventId: eventId),
      //             ),
      //           ),
      //         ));
    } else if (settings.name == AppRoutes.comment) {
      final postId = settings.arguments as String;

      return MaterialPageRoute(
          settings: settings,
          builder: (context) => CommentView(postId: postId));
    } else if (settings.name == AppRoutes.formRegister) {
      final event = settings.arguments as BaseEvent;

      return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return BlocProvider(
              create: (_) => FormBloc(),
              child: FormView(event: event),
            );
          });
    }
    return MaterialPageRoute(builder: (context) {
      return Text('fail page');
    });
  }

  Future<void> showMyDialog(BuildContext context, String text,
      {bool closeWhenClick = true}) async {
    return showDialog(
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
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Text(text, textAlign: TextAlign.center),
                ),
                SizedBox(height: 30),
                InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Text("Đồng ý", textAlign: TextAlign.center),
                    ),
                    onTap: () {
                      if (closeWhenClick) {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName(AppRoutes.home));
                      } else {
                        Navigator.of(context).pop();
                      }
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
