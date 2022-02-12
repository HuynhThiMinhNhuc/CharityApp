import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_even.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_state.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charityapp/views/Pages/profile_page/profile_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Widgets/profile_overview.dart';

class ProfileOtherPage extends StatefulWidget {
  final UserOverview creator;
  final Function? onClose;
  ProfileOtherPage({required this.creator, this.onClose});

  @override
  _ProfileOtherPageState createState() => _ProfileOtherPageState();
}

class _ProfileOtherPageState extends State<ProfileOtherPage> {
  var postBloc;
  var overViewUserBloc;
  @override
  void initState() {
    super.initState();
    postBloc = BlocProvider.of<PostBloc>(context);
    overViewUserBloc = BlocProvider.of<OverViewUserBloc>(context);
    overViewUserBloc.add(LoadOverViewUserEvent(widget.creator.id));
    BlocProvider.of<PostBloc>(context).add(
        LoadProfilePosts(creator: widget.creator, startIndex: 0, number: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(context),
      body: getBody(),
    );
  }

  SingleChildScrollView getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
              child: BlocBuilder<OverViewUserBloc, OverViewUserState>(
                buildWhen: (context, state) {
                  return state is LoadingOverViewUserState ||
                      state is LoadFailOverViewUserState ||
                      state is FollowOverViewUserState ||
                      state is UnfollowOverViewUserState ||
                      state is LoadedOverViewUserState;
                },
                builder: (context, state) {
                  if (state is LoadedOverViewUserState) {
                    return ProfileOverView(state.userProfile as UserProfile,
                        state.isfriend, overViewUserBloc);
                  } else if (state is FollowOverViewUserState) {
                    return ProfileOverView(state.userProfile as UserProfile,
                        state.isfriend, overViewUserBloc);
                  } else if (state is UnfollowOverViewUserState) {
                    return ProfileOverView(state.userProfile as UserProfile,
                        state.isfriend, overViewUserBloc);
                  } else if (state is PostLoadInProgress)
                    return SketonProfile();
                  else
                    return SketonProfile();
                },
              )),
          Divider(thickness: 1.0),
          Center(
              child: BlocConsumer<PostBloc, PostState>(
            //      listenWhen: (context, state){
            //        return state is ClickPostEvent;
            // },
            listener: (context, state) {
              if (state is PostLoadInProgress) {
                //push DetailPost with post ID
              }
            },
            buildWhen: (context, state) {
              return state is PostLoadInProgress ||
                  state is PostsLoadSuccess ||
                  state is PostLoadFailure;
            },
            builder: (context, state) {
              if (state is PostsLoadSuccess) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 20.w,
                      child: Text(
                        "Bài viết",
                        style: kText18BoldBlack,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PostOverviewCard(post: state.posts[index]);
                      },
                    ),
                  ],
                );
              } else
                return SketonEvent();
            },
          )),
        ],
      ),
    );
  }

  AppBar getAppbar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: textcolor, //change your color here
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () async {
          await widget.onClose?.call();
          Navigator.pop(context);
        },
      ),
      backgroundColor: backgroundbottomtab,
      centerTitle: true,
      title: Text(
        "Hồ sơ người dùng",
        style: kText20BoldBlack,
      ),
    );
  }
}
