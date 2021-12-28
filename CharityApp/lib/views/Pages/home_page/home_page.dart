import 'package:charityapp/Constant/active_json.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/active_item.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class HomePage extends StatefulWidget {
//   // final List<Post> posts = const <Post>[];
//   // final List<UserOverview> friends = const <UserOverview>[];
//   final bool isReload;

//   const HomePage({Key? key, this.isReload = false}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

class HomePage extends StatefulWidget {
  // final bool needReload;
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late bool isReload;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostBloc>(context)
        .add(LoadRandomPosts(startIndex: 0, number: 5));
  }

  @override
  Widget build(BuildContext context) {
    return getbody();
  }

  getbody() {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        // if (needLoad) {
        //   BlocProvider.of<PostBloc>(context).add(LoadPosts(
        //       eventId: "CnNqZwmqSBf9RYMXAnpp", startIndex: 0, number: 10));
        // }
        // if (!isReload) {
        //   isReload = true;
        //   BlocProvider.of<PostBloc>(context).add(LoadEventPosts(
        //       eventId: "CnNqZwmqSBf9RYMXAnpp", startIndex: 0, number: 10));
        //   return Text("Loading view 2...");
        //   ;
        // }
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
