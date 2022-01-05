import 'package:animations/animations.dart';
import 'package:charityapp/core/helper/format_number_k.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Pages/home_page/event_page.dart';
import 'package:charityapp/views/bloc/comment_bloc/comment.dart';
import 'package:charityapp/views/bloc/like_post_bloc/like_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'information_creator_post_view.dart';

class PostOverviewCard extends StatelessWidget {
  final Post post;

  PostOverviewCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InformationCreatorPostView(creator: post.creator),
                if (post.creator.id == Authenticator.Id)
                  PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: InkWell(
                          onTap: () {},
                          child: ListTile(
                            title: Text('Chỉnh sửa'),
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: InkWell(
                          onTap: () {},
                          child: ListTile(
                            title: Text('Xóa'),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            if (post.imagesUri.length > 0)
              Container(
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(post.imagesUri[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
              // child: OpenContainer(
              //   transitionDuration: Duration(seconds: 2),
              //   openBuilder: ((context, AppRoutes.eventPage, arguments: post.eventId!), _) => ,
              //   closedBuilder: (context, VoidCallback openContainer) =>
              //       GestureDetector(
              //     onTap: openContainer,
              //     child: Text(
              //       post.title,
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 15,
              //           fontFamily: 'Roboto_Regular'),
              //     ),
              //   ),

              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.eventPage,
                      arguments: post.eventId!);
                },
                child: Text(
                  post.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: 'Roboto_Regular'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
              child: Text(
                post.description,
                style: TextStyle(fontSize: 13, fontFamily: 'Roboto_Regular'),
              ),
            ),
            if (post.tags.length > 0)
              SizedBox(
                height: 30,
                child: ListView.builder(
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: OutlinedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0x50979797)),
                        ),
                        child: Text(
                          post.tags[index],
                          style: TextStyle(
                              fontFamily: 'Roboto_Regular',
                              fontSize: 12,
                              color: Color(0xFF455154)),
                        ),
                      ),
                    );
                  },
                  itemCount: post.tags.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            BlocConsumer<LikePostBloc, LikePostState>(
              listener: (context, state) {
                if (state is PostNumberLike) {
                  if (post.id == state.id) {
                    post.isLike = state.isLike;
                    post.numberLike = state.numberLike;
                    post.numberComment = state.numberComment;
                  }
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Xem bình luận',
                        style: TextStyle(
                          fontFamily: 'Roboto_Regular',
                          fontSize: 11,
                          color: Colors.black45,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<LikePostBloc>(context)
                                  .add(LikePost(
                                postId: post.id!,
                                isLike: !post.isLike,
                              ));
                            },
                            icon: post.isLike
                                ? FaIcon(
                                    FontAwesomeIcons.heart,
                                    color: Colors.red,
                                  )
                                : FaIcon(FontAwesomeIcons.heart),
                            splashRadius: 20,
                          ),
                          Text(
                            FormatNumberK.call(post.numberLike),
                            style: TextStyle(
                                fontFamily: 'Roboto_Regular',
                                fontSize: 13,
                                color: textcolor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(width: 10),
                      Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () async {
                              await Navigator.of(context).pushNamed(AppRoutes.comment,
                                  arguments: post.id);
                                  BlocProvider.of<LikePostBloc>(context).add(GetNumberLike(postId: post.id!));
                            },
                            icon: FaIcon(FontAwesomeIcons.comment),
                            splashRadius: 20,
                          ),
                          Text(
                            FormatNumberK.call(post.numberComment),
                            style: TextStyle(
                                fontFamily: 'Roboto_Regular',
                                fontSize: 13,
                                color: textcolor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
