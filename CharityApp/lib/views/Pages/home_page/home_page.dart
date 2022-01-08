import 'package:animations/animations.dart';
import 'package:charityapp/Constant/active_json.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/active_item.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/Pages/profile_page/profile_other.dart';
import 'package:charityapp/views/Pages/profile_page/profile_page.dart';
import 'package:charityapp/views/bloc/activeuser_bloc/activeuser_bloc.dart';
import 'package:charityapp/views/bloc/friend_bloc/friend_bloc.dart';
import 'package:charityapp/views/bloc/like_post_bloc/like_post_bloc.dart';
import 'package:charityapp/views/bloc/like_post_bloc/like_post_event.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void loadPage(BuildContext context) {
    BlocProvider.of<PostBloc>(context)
        .add(LoadRandomPosts(startIndex: 0, number: 5));
    BlocProvider.of<ActiveuserBloc>(context).add(ActiveuserLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostsLoadSuccess) {
          return LoadSuccessHomeView(state.posts);
        }
        if (state is PostLoadInProgress) {
          return SkeletonEvent();
        } else
          return Text("Load fail");
      },
    );
  }

  Widget LoadSuccessHomeView(List<Post> posts) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 0, 15),
              child: SizedBox(
                width: double.infinity,
                child: Text("Đang hoạt động",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: textcolor,
                        fontSize: 18,
                        decoration: TextDecoration.none,
                        fontFamily: 'Roboto_Regular',
                        fontWeight: FontWeight.bold)),
              ),
            ),
            BlocBuilder<ActiveuserBloc, ActiveuserState>(
              builder: (context, state) {
                if (state is ActiveuserLoadingState) {
                  return SkeletonEvent();
                } else if (state is ActiveuserLoadFailState) {
                  return Container(
                    height: 0,
                  );
                } else if (state is ActiveuserLoadedState)
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(state.users.length, (index) {
                          return InkWell(
                            child: ActiveItem(
                                imgUrl: state.users[index].avatarUri!,
                                imgName: state.users[index].name),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider<OverViewUserBloc>(
                                              create: (context) =>
                                                  OverViewUserBloc(),
                                            ),
                                            BlocProvider<PostBloc>(
                                              create: (context) => PostBloc(),
                                            ),
                                          ],
                                          child: ProfileOtherPage(
                                              creator: state.users[index]),
                                        )),
                              )
                            },
                          );
                        })),
                  );
                else
                  return (Text("Fail out"));
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 7, 0, 15),
              child: SizedBox(
                width: double.infinity,
                child: Text("Bài viết",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: textcolor,
                        fontSize: 18,
                        decoration: TextDecoration.none,
                        fontFamily: 'Roboto_Regular',
                        fontWeight: FontWeight.bold)),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: posts.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                BlocProvider.of<LikePostBloc>(context)
                    .add(GetNumberLike(postId: posts[index].id!));
                return PostOverviewCard(post: posts[index]);
              },
            ),
          ]),
    );
  }
}

class SkeletonEvent extends StatelessWidget {
  const SkeletonEvent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(" Đang hoạt động",
                textAlign: TextAlign.start,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: textcolor,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.bold)),
          ),
          SkeletonLoader(
            builder: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                  );
                }),
              ),
            ),
            items: 1,
            period: Duration(seconds: 2),
            highlightColor: Color(0x505AA469),
            direction: SkeletonDirection.ltr,
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(" Sự kiện",
                textAlign: TextAlign.start,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: textcolor,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.bold)),
          ),
          SketonEvent()
        ],
      ),
    );
  }
}

class SkeletonActiveUser extends StatelessWidget {
  const SkeletonActiveUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      builder: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
      items: 6,
      period: Duration(seconds: 2),
      highlightColor: Color(0x505AA469),
      direction: SkeletonDirection.ltr,
    );
  }
}
