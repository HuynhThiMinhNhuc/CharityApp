import 'package:charityapp/Constant/cmt_json.dart';
import 'package:charityapp/core/helper/format_number_k.dart';
import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/bloc/comment_bloc/comment.dart';
import 'package:charityapp/views/bloc/like_post_bloc/like_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentView extends StatelessWidget {
  const CommentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context)!.settings.arguments as String;
    BlocProvider.of<LikePostBloc>(context).add(GetNumberLike(postId: postId));

    return BlocProvider(
        create: (context) => CommentBloc(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: getAppbar(context, postId),
          body: CommentViewElement(postId: postId),
        ));
  }

  AppBar getAppbar(BuildContext context, String postId) {
    return AppBar(
      iconTheme: IconThemeData(color: textcolor),
      backgroundColor: backgroundbottomtab,
      title: BlocBuilder<LikePostBloc, LikePostState>(
        builder: (likeContext, state) {
          final postState = (state as PostNumberLike);
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                // total.toString(),
                FormatNumberK.call(postState.numberLike),
                style: TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontSize: 12,
                    color: textcolor),
              ),
              SizedBox(
                width: 5,
              ),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<LikePostBloc>(likeContext)
                        .add(LikePost(isLike: !postState.isLike, postId: postId));
                  },
                  icon: postState.isLike
                      ? FaIcon(
                          FontAwesomeIcons.heart,
                          color: Colors.red[900],
                        )
                      : FaIcon(FontAwesomeIcons.heart))
            ],
          );
        },
      ),
    );
  }
}

class CommentViewElement extends StatefulWidget {
  final String postId;
  CommentViewElement({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentViewElementState createState() => _CommentViewElementState();
}

class _CommentViewElementState extends State<CommentViewElement> {
  late CommentBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<CommentBloc>(context);
    _bloc.getComments(widget.postId);
  }

  @override
  void dispose() {
    // _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            return _buildComments(context);
          },
        ),
        _buildTextComment(),
      ],
    );
  }

  _buildTextComment() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: 60,
        color: backgroundbottomtab,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Viết bình luận",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(5, 5, 50, 0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                  iconSize: 25,
                  onPressed: null,
                  icon: Icon(
                    Icons.send,
                    color: maincolor,
                  ))
            ],
          ),
        ));
  }

  _buildComments(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
          child: StreamBuilder(
              stream: BlocProvider.of<CommentBloc>(context).commentStream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text('loading or not data');
                } else {
                  final listComment = snapshot.data!.docs;
                  if (listComment.length == 0) return Text('no comments');
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listComment.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FutureBuilder<UserComment>(
                        future: _bloc.getComment(
                            listComment[index].data() as Map<String, dynamic>),
                        builder: (context, user) {
                          if (user.hasError) {
                            return Text('error loading');
                          }
                          if (user.hasData) {
                            return CommentItem(
                              comment: user.data!,
                            );
                          }
                          return Text('loading user');
                        },
                      );
                    },
                  );
                }
              }) // Column(
          //     children: List.generate(cmts.length, (index) {
          //   return CommentItem(
          //       avatar: cmts[index]['avatar'],
          //       name: cmts[index]['name'],
          //       time: cmts[index]['timeago'],
          //       cmt: cmts[index]['comment']);
          // })),
          ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final UserComment comment;

  const CommentItem({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              comment.avatarUri ?? cmts[0]['avatarUri']),
                          fit: BoxFit.cover))),
              SizedBox(
                width: 5,
              ),
              Text(
                comment.name,
                style: TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontSize: 13,
                    color: textcolor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                " - " + comment.timeComment.toString(),
                style: TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontSize: 12,
                    color: const Color(0xFF838282)),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            comment.content,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: 'Roboto_Regular', fontSize: 14, color: textcolor),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
