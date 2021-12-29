import 'package:charityapp/Constant/active_json.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/active_item.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/bloc/like_post_bloc/like_post_bloc.dart';
import 'package:charityapp/views/bloc/like_post_bloc/like_post_event.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void loadPage(BuildContext context) {
    BlocProvider.of<PostBloc>(context)
        .add(LoadRandomPosts(startIndex: 0, number: 5));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostsLoadSuccess) {
          return LoadSuccessHomeView(state.posts);
        }
        if (state is PostLoadInProgress) {
          return Text("Loading view...");
        } else
          return Text("Load fail");
      },
    );
  }

  Widget LoadSuccessHomeView(List<Post> posts) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 0, 15),
          child: SizedBox(
            width: double.infinity,
            child: Text("Hoạt động tích cực",
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List.generate(actives.length, (index) {
            return ActiveItem(
                imgUrl: actives[index]['img'], imgName: actives[index]['name']);
          })),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 7, 0, 15),
          child: SizedBox(
            width: double.infinity,
            child: Text("Sự kiện",
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
          physics: NeverScrollableScrollPhysics(),
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            return PostOverviewCard(post: posts[index]);
          },
        ),
      ]),
    );
  }
}
