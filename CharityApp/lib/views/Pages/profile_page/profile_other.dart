import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/bloc/editprofile_bloc/bloc/editprofile_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_even.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_state.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
import 'package:charityapp/views/bloc/post_bloc/post_bloc.dart';
import 'package:charityapp/views/bloc/post_bloc/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:charityapp/views/Pages/profile_page/profile_page.dart';

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
    BlocProvider.of<PostBloc>(context).add(LoadProfilePosts(creator: widget.creator, startIndex: 0, number: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          style: TextStyle(
              color: textcolor, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
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
      ),
    );
  }
}
