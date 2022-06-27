import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/core/helper/format_number_k.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/bloc/like_post_bloc/like_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/helper/state_full_wrapper.dart';
import 'information_creator_post_view.dart';

class PostOverviewCard extends StatelessWidget {
  final Post post;

  PostOverviewCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        BlocProvider.of<LikePostBloc>(context)
            .add(GetNumberLike(postId: post.id!));
      },
      child: Container(
        child: Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
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
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.addPost);
                            },
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
                height: 10.h,
              ),
              if (post.imagesUri.length > 0)
                Stack(children: <Widget>[
                  Container(
                    height: 400.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(post.imagesUri[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (post.imagesUri.length > 1)
                    Positioned(
                      child: IconButton(
                        icon: FaIcon(FontAwesomeIcons.angleRight),
                        onPressed: null,
                      ),
                      right: -10.w,
                      top: 150.h,
                    ),
                  if (post.imagesUri.length > 1)
                    Positioned(
                      child: IconButton(
                        icon: FaIcon(FontAwesomeIcons.angleLeft),
                        onPressed: null,
                      ),
                      left: -10.w,
                      top: 150.h,
                    )
                ]),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 10.h, 5.w, 5.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.eventPage,
                        arguments: post.eventId!);
                  },
                  child: Text(
                    post.title,
                    style: kText15BoldBlack,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 10.h),
                child: Text(
                  post.description,
                  style:
                      TextStyle(fontSize: 13.sp, fontFamily: 'Roboto_Regular'),
                ),
              ),
              if (post.tags.length > 0)
                SizedBox(
                  height: 30.h,
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
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
                            style: kText12RegularBlack,
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
                    padding: EdgeInsets.fromLTRB(8.w, 0, 10.w, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Xem bình luận',
                          style: TextStyle(
                            fontFamily: 'Roboto_Regular',
                            fontSize: 13.sp,
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
                                      size: 18.w,
                                    )
                                  : FaIcon(FontAwesomeIcons.heart),
                              splashRadius: 20.w,
                            ),
                            Text(
                              FormatNumberK.call(post.numberLike),
                              style: kText13BoldBlack,
                            )
                          ],
                        ),
                        SizedBox(width: 10.w),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              onPressed: () async {
                                await Navigator.of(context).pushNamed(
                                    AppRoutes.comment,
                                    arguments: post.id);
                                BlocProvider.of<LikePostBloc>(context)
                                    .add(GetNumberLike(postId: post.id!));
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.comment,
                                size: 18.w,
                              ),
                              splashRadius: 20.w,
                            ),
                            Text(
                              FormatNumberK.call(post.numberComment),
                              style: kText13BoldBlack,
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
      ),
    );
  }
}
