import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:charityapp/views/Component/my_alert_dialog_2.dart';
import 'package:charityapp/views/Login/login_view.dart';
import 'package:charityapp/views/Pages/add_event_page/add_tag_page.dart';
import 'package:charityapp/views/Root_App.dart';
import 'package:charityapp/views/bloc/activeuser_bloc/activeuser_bloc.dart';
import 'package:charityapp/views/bloc/calendar_bloc/calendar.dart';
import 'package:charityapp/views/bloc/editprofile_bloc/bloc/editprofile_bloc.dart';
import 'package:charityapp/views/bloc/event_bloc/event.dart';
import 'package:charityapp/views/bloc/form_bloc/form.dart' as formBLoc;
import 'package:charityapp/views/bloc/friend_bloc/friend_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
import 'package:charityapp/views/bloc/signin_bloc/signin_bloc.dart';
import 'package:charityapp/views/bloc/tab_bloc/tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import 'add_event_page/add_event_page.dart';
import 'add_event_page/add_post_page.dart';
import 'add_event_page/chosse_eventview.dart';
import 'home_page/Witdgets/detailFormJoining.dart';
import 'home_page/comment_view.dart';
import 'home_page/event_page.dart';
import 'home_page/form_view.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class RouteGenerator {
  Route generateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.login) {
      return LoginRoute(settings);
    } else if (settings.name == AppRoutes.home) {
      return HomeRoute(settings);
    } else if (settings.name == AppRoutes.addPost) {
      return AddPostRoute(settings);
    } else if (settings.name == AppRoutes.addEvent) {
      return AddEventRoute(settings);
    } else if (settings.name == AppRoutes.chooseEvent) {
      return ChooseEventRoute(settings);
    } else if (settings.name == AppRoutes.eventPage) {
      return EventPageRoute(settings);
    } else if (settings.name == AppRoutes.comment) {
      return CommentRoute(settings);
    } else if (settings.name == AppRoutes.formRegister) {
      return FormRegisterRoute(settings);
    } else if (settings.name == AppRoutes.detailFormRegister) {
      return DetailFormRegisterRoute(settings);
    } else if (settings.name == AppRoutes.chooseTags) {
      return ChooseTagRoute(settings);
    }

    return MaterialPageRoute(builder: (context) {
      return Text('Fail page');
    });
  }

  MaterialPageRoute<dynamic> ChooseTagRoute(RouteSettings settings) {
    final tagsEvent = settings.arguments as List<TagEvent>;

    return MaterialPageRoute(builder: (context) {
      BlocProvider.of<TagCubit>(context).load();
      return BlocBuilder<TagCubit, List<TagEvent>?>(
        builder: (context, alltag) {
          if (alltag == null) {
            return Container();
            // SketonAddTags();
          }

          for (var tag in tagsEvent) {
            if (alltag.contains(tag)) alltag.remove(tag);
          }

          List<TagItemInUI> tagsUi = tagsEvent
              .map((tag) => TagItemInUI(tag: tag, isSelected: true))
              .toList()
            ..addAll(
                alltag.map((tag) => TagItemInUI(tag: tag, isSelected: false)));

          return AddTag(initTags: tagsUi);
        },
      );
    });
  }

  MaterialPageRoute<dynamic> DetailFormRegisterRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => BlocBuilder<formBLoc.FormBloc, formBLoc.FormState>(
          builder: (_, state) {
        if (state is formBLoc.FormLoadSuccess) {
          return DetailFormJoinings(
            formDetail: state.form,
            userProfile: state.user,
          );
        } else
          return Scaffold(
            body: Container(),
          );
      }),
    );
  }

  MaterialPageRoute<dynamic> FormRegisterRoute(RouteSettings settings) {
    final event = settings.arguments as BaseEvent;

    return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return BlocProvider(
            create: (_) => formBLoc.FormBloc(),
            child: FormView(event: event),
          );
        });
  }

  MaterialPageRoute<dynamic> CommentRoute(RouteSettings settings) {
    final postId = settings.arguments as String;

    return MaterialPageRoute(
        settings: settings, builder: (context) => CommentView(postId: postId));
  }

  MaterialPageRoute<dynamic> EventPageRoute(RouteSettings settings) {
    final eventId = settings.arguments as String;

    return MaterialPageRoute(
      settings: settings,
      builder: (context) => BlocProvider(
        create: (_) => EventTitleCubit(),
        child: EventPage(eventId: eventId),
      ),
    );
  }

  MaterialPageRoute<dynamic> ChooseEventRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => ChossesEventView(),
    );
  }

  MaterialPageRoute<dynamic> AddEventRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        print("create add_event route");

        return BlocConsumer<EventTabBloc, EventTabState>(
          listener: (context, state) async {
            if (state is EventUpdateSuccess) {
              showDialog(
                  context: context,
                  builder: (context) => MyAlertDialog2(
                        content: 'Quay về màn hình chính',
                        title: 'Thêm sự kiện thành công',
                        pathImage: "asset/imageInpage/success.png",
                        onTabYes: () => Navigator.of(context)
                            .popUntil(ModalRoute.withName(AppRoutes.home)),
                      ));
            } else if (state is EventLoadFailure) {
              showDialog(
                  context: context,
                  builder: (context) => MyAlertDialog2(
                        content: 'Thêm sự kiện thất bại',
                        title: 'Lỗi',
                        isTwoActions: false,
                      ));
            }
          },
          builder: (context, state) {
            return AddEventPage(
              onClickSubmit: (newEvent, {avatarImage, backgroundImage}) {
                print("on AddEvent");
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
  }

  MaterialPageRoute<dynamic> AddPostRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        print("create add_post route");
        return BlocListener<PostBloc, PostState>(
          listener: (bloc_context, state) async {
            if (state is PostUpdated) {
              showDialog(
                  context: context,
                  builder: (context) => MyAlertDialog2(
                        content: 'Quay về màn hình chính',
                        title: 'Thêm bài viết thành công',
                        pathImage: "asset/imageInpage/success.png",
                        onTabYes: () => Navigator.of(context)
                            .popUntil(ModalRoute.withName(AppRoutes.home)),
                        onTabNo: () => Navigator.of(context).pushNamed(
                          AppRoutes.eventPage,
                          arguments: state.post.eventId,
                        ),
                      ));
            } else if (state is PostLoadFailure) {
              showDialog(
                context: context,
                builder: (context) => MyAlertDialog2(
                  content: 'Thêm bài viết thất bại',
                  title: 'Thông báo',
                  isTwoActions: false,
                ),
              );
            }
          },
          child: AddPostPage(
            onClickSubmit: (post, images) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Text('');
                  });

              BlocProvider.of<PostBloc>(context).add(
                AddPost(post: post, images: images),
              );
            },
          ),
        );
      },
    );
  }

  PageTransition<dynamic> HomeRoute(RouteSettings settings) {
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
  }

  MaterialPageRoute<dynamic> LoginRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => BlocProvider(
        create: (_) => SigninBloc(),
        //child: IndicatorLoginToHome(),
        child: Login(),
      ),
    );
  }
}

class SketonAddTags extends StatelessWidget {
  const SketonAddTags({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SkeletonLoader(
        builder: SkeletonLoader(
          builder: Padding(
            padding: EdgeInsets.fromLTRB(15.w, 10.h, 10.w, 0),
            child: Wrap(
              spacing: 8.0.h, // gap between adjacent chips
              runSpacing: 2.0.w, // gap between lines
              children: <FilterChip>[
                FilterChip(
                  label: Text(
                    "Tre em",
                    style: kText15Bold80Black,
                  ),
                  onSelected: null,
                ),
                FilterChip(
                  label: Text(
                    "Bao ve moi truong",
                    style: kText15Bold80Black,
                  ),
                  onSelected: null,
                ),
                FilterChip(
                  label: Text(
                    "Nguoi gia neo don",
                    style: kText15Bold80Black,
                  ),
                  onSelected: null,
                ),
                FilterChip(
                  label: Text(
                    "Mo coi",
                    style: kText15Bold80Black,
                  ),
                  onSelected: null,
                ),
                FilterChip(
                  label: Text(
                    "Xa hoi",
                    style: kText15Bold80Black,
                  ),
                  onSelected: null,
                )
              ],
            ),
          ),
          items: 2,
          period: Duration(seconds: 2),
          highlightColor: Color(0x505AA469),
          direction: SkeletonDirection.ltr,
        ),
      ),
    );
  }
}
