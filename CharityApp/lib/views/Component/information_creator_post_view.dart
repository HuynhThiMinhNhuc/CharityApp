import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/profile_page/profile_other.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/post_bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationCreatorPostView extends StatelessWidget {
  final UserOverview creator;
  final String location;

  InformationCreatorPostView({required this.creator, this.location = ''});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 10,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 40.h,
              height: 40.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image:
                        (creator.avatarUri != null && creator.avatarUri != "")
                            ? NetworkImage(creator.avatarUri!)
                            : AssetImage('asset/avatar.png') as ImageProvider,
                    fit: BoxFit.cover),
              ),
            ),
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
                          child: ProfileOtherPage(creator: creator),
                        )),
              )
            },
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ProfilePage(userprofile: , posts: null)));
                },
                child: Text(this.creator.name, style: kText15BoldBlack),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(this.location, style: kText12RegularBlack),
            ],
          )
        ],
      ),
    );
  }
}
