import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_even.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_state.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Widgets/profile_overview.dart';

enum mode { My, Friend, Stranger, Joiner, Pending_approval }

class ProfilePage extends StatefulWidget {
  final UserOverview creator;
  ProfilePage({required this.creator});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var postBloc;
  var overViewUserBloc;
  @override
  void initState() {
    super.initState();
    postBloc = BlocProvider.of<PostBloc>(context);
    overViewUserBloc = BlocProvider.of<OverViewUserBloc>(context);
    overViewUserBloc.add(LoadOverViewUserEvent(
        GetIt.instance.get<Authenticator>().userProfile.id));
    BlocProvider.of<PostBloc>(context).add(
        LoadProfilePosts(creator: widget.creator, startIndex: 0, number: 10));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: BlocBuilder<OverViewUserBloc, OverViewUserState>(
                buildWhen: (context, state) {
                  return state is LoadingOverViewUserState ||
                      state is LoadFailOverViewUserState ||
                      state is LoadedOverViewUserState;
                },
                builder: (context, state) {
                  if (state is LoadedOverViewUserState) {
                    //return SketonProfile();
                    return ProfileOverView(state.userProfile as UserProfile,
                        mode.My, overViewUserBloc);
                  } else if (state is PostLoadInProgress)
                    return SketonProfile();
                  else
                    return SketonProfile();
                },
              )),
          Divider(thickness: 1.0),
          Center(child: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostsLoadSuccess) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PostOverviewCard(post: state.posts[index]);
                  },
                );
              } else
                return SketonEvent();
            },
          )),
        ],
      ),
    );
  }
}

class SketonEvent extends StatelessWidget {
  const SketonEvent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SkeletonLoader(
        builder: SkeletonLoader(
          builder: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 100.w,
                            height: 10.h,
                            color: Colors.white,
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: 150.w,
                            height: 12.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 300,
                    color: Colors.white,
                  ),
                ),
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

class SketonProfile extends StatelessWidget {
  const SketonProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      builder: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width - 60,
                            height: 10.h,
                            color: Colors.white,
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: MediaQuery.of(context).size.width - 60,
                            height: 12.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 150.w,
                    height: 10.h,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 150.w,
                    height: 12.h,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 12.h,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      items: 1,
      period: Duration(seconds: 2),
      highlightColor: Color(0x505AA469),
      direction: SkeletonDirection.ltr,
    );
  }
}
