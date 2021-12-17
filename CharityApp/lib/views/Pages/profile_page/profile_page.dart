import 'package:charityapp/Constant/user_json.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_even.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_state.dart';
import 'package:charityapp/views/bloc/post_bloc/post_bloc.dart';
import 'package:charityapp/views/bloc/post_bloc/post_event.dart';
import 'package:charityapp/views/bloc/post_bloc/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Widgets/profile_overview.dart';

class ProfilePage extends StatefulWidget {

  ProfilePage ();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var postBloc;
  var overViewUserBloc;
  @override
  void initState(){
    super.initState();
    postBloc = BlocProvider.of<PostBloc>(context);
    overViewUserBloc = BlocProvider.of<OverViewUserBloc>(context);
    context.read<OverViewUserBloc>().add(LoadOverViewUserEvent());
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
              buildWhen: (context, state){
                return state is LoadingOverViewUserState
                    || state is LoadFailOverViewUserState
                    || state is LoadedOverViewUserState;
              },
              builder: (context, state){
                if(state is LoadedOverViewUserState){
                  return ProfileOverView(state.userProfile as UserProfile);
                }
                else return Text("Loading");
              },
            )

          ),
          Divider(thickness: 1.0),
          Center(
            child: BlocConsumer<PostBloc, PostState>(
            //      listenWhen: (context, state){
            //        return state is ClickPostEvent;
            // },
              listener: (context, state){
                   if (state is LoadingPostState)
                     {
                       //push DetailPost with post ID
                     }
            },
            buildWhen: (context, state){
                   return state is LoadingPostState ||
                          state is LoadedPostState ||
                          state is LoadingFailState;
            },
            builder: (context, state){
                   if ( state is LoadedPostState) {
                     return ListView.builder(
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemCount: state.listPost.length,
                       itemBuilder: (BuildContext context, int index) {
                         return PostOverview(post: state.listPost[index]);
                       },
                     );
                   }
                   else return Text("Loading");
            },

    )
          ),
        ],
      ),
    );
  }
}
