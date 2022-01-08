import 'package:charityapp/Constant/cmt_json.dart';
import 'package:charityapp/core/helper/format_number_k.dart';
import 'package:charityapp/core/helper/get_time_compare_present.dart';
import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Login/login_view.dart';
import 'package:charityapp/views/Pages/profile_page/profile_other.dart';
import 'package:charityapp/views/bloc/comment_bloc/comment.dart';
import 'package:charityapp/views/bloc/like_post_bloc/like_post.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/post_bloc/post_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class CommentView extends StatelessWidget {
  final String postId;
  const CommentView({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    fontSize: 15,
                    color: textcolor),
              ),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<LikePostBloc>(likeContext).add(
                        LikePost(isLike: !postState.isLike, postId: postId));
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
  late TextEditingController commentTextController;

  @override
  void initState() {
    super.initState();
    commentTextController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<CommentBloc>(context);
    _bloc.getComments(widget.postId);
  }

  @override
  void dispose() {
    // _bloc.dispose();
    commentTextController.dispose();
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
                  controller: commentTextController,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                  iconSize: 25,
                  onPressed: () {
                    if (commentTextController.text.trim() != '') {
                      _bloc.add(AddComment(
                          postId: widget.postId,
                          content: commentTextController.text));
                      commentTextController.text = '';
                    }
                  },
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

                  if (listComment.isEmpty) return NoComment();

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listComment.length,
                    itemBuilder: (BuildContext context, int index) {
                      //return SketonComment();
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
                          return SketonComment();
                        },
                      );
                    },
                  );
                }
              })),
    );
  }
}

class SketonComment extends StatelessWidget {
  const SketonComment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SkeletonLoader(
        builder: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 15,
                    width: 50,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 15,
                    width: 100,
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Container(
                  height: 15,
                  width: 300,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Container(
                    height: 15,
                    width: 200,
                    color: Colors.white,
                  )),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        items: 6,
        period: Duration(seconds: 2),
        highlightColor: Color(0x505AA469),
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}

class NoComment extends StatelessWidget {
  const NoComment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/imageInpage/no_comment.png"))),
        ),
        Text(
          "Chưa có bình luận nào",
          style: TextStyle(fontSize: 15, color: notetextcolor),
        )
      ],
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
              InkWell(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: (comment.avatarUri != "" &&
                                    comment.avatarUri != null)
                                ? NetworkImage(comment.avatarUri!)
                                : AssetImage("asset/avatar.png")
                                    as ImageProvider,
                            fit: BoxFit.cover))),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<OverViewUserBloc>(
                                  create: (context) => OverViewUserBloc(),
                                ),
                                BlocProvider<PostBloc>(
                                  create: (context) => PostBloc(),
                                ),
                              ],
                              child: ProfileOtherPage(
                                  creator: UserOverview(
                                      name: comment.name,
                                      avatarUri: comment.avatarUri,
                                      id: comment.id)),
                            )),
                  )
                },
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                comment.name,
                style: TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontSize: 15,
                    color: textcolor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                ' - ' + GetTimeComparePresent.call(comment.timeComment),
                style: TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontSize: 13,
                    color: const Color(0xFF838282)),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              comment.content,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: 'Roboto_Regular', fontSize: 15, color: textcolor),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
