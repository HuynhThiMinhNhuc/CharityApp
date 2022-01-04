import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/bloc/editprofile_bloc/bloc/editprofile_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_even.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_state.dart';
import 'package:charityapp/views/bloc/post_bloc/post_bloc.dart';
import 'package:charityapp/views/bloc/post_bloc/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'Widgets/profile_overview.dart';

enum mode { My, Friend, Stranger, Joiner, Pending_approval }

class ProfilePage extends StatefulWidget {
  ProfilePage();

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
    overViewUserBloc.add(LoadOverViewUserEvent(GetIt.instance.get<Authenticator>().userProfile.id));
    //poverViewUserBlocostBloc.add(LoadPostEvent());
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
                    return ProfileOverView(
                        state.userProfile as UserProfile, mode.My, overViewUserBloc);
                  } else if (state is PostLoadInProgress)
                    return Text("Loading");
                  else
                    return Text("Loading failer.....");
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
            buildWhen: (context, state){
                   return state is PostLoadInProgress ||
                          state is LoadedPostState ||
                          state is PostLoadFailure;
            },
            builder: (context, state){
                   if ( state is LoadedPostState) {
                     return ListView.builder(
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemCount: state.listPost.length,
                       itemBuilder: (BuildContext context, int index) {
                         return PostOverviewCard(post: state.listPost[index]);
                       },
                     );
                   }
                   else return Text("Loading");
            },
          )),
        ],
      ),
    );
  }
}
