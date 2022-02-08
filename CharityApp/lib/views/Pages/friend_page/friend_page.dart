import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Pages/friend_page/widgets/short_infor_card.dart';
import 'package:charityapp/views/Pages/profile_page/profile_other.dart';
import 'package:charityapp/views/bloc/friend_bloc/friend_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/post_bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({Key? key}) : super(key: key);

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  List<UserOverview> history = [];
  var friendBloc;

  @override
  void initState() {
    super.initState();
    friendBloc = BlocProvider.of<FriendBloc>(context);
    friendBloc.add(
        FriendLoadEvent(GetIt.instance.get<Authenticator>().userProfile.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        getListFriend(),
        getSearchbar(),
      ],
    );
  }

  Widget getSearchbar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      backdropColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: BorderSide(width: 1, color: Color(0xFFA6A6AA)),
      hint: 'Tìm kiếm',
      clearQueryOnClose: true,
      scrollPadding: EdgeInsets.only(top: 16.h, bottom: 56.h),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      closeOnBackdropTap: true,
      onQueryChanged: (query) {
        friendBloc.add(FriendSearchEvent(query.trim()));
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Container(),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: true,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: BlocBuilder<FriendBloc, FriendState>(
                buildWhen: (context, state) {
                  return state is FriendSearchWithResultState ||
                      state is FriendSearchLoadingState ||
                      state is FriendSearchNoResultState;
                },
                builder: (context, state) {
                  return state is FriendSearchWithResultState
                      ? Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.suggestion.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                      radius: 18.h,
                                      backgroundImage: (state.suggestion[index]
                                                      .avatarUri ==
                                                  "" ||
                                              state.suggestion[index]
                                                      .avatarUri ==
                                                  null)
                                          ? AssetImage('asset/avatar.png')
                                          : NetworkImage(state.suggestion[index]
                                              .avatarUri!) as ImageProvider),
                                  title: Text(state.suggestion[index].name),
                                  selectedColor: Color(0x10F4F4F4),
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MultiBlocProvider(
                                                providers: [
                                                  BlocProvider<
                                                      OverViewUserBloc>(
                                                    create: (context) =>
                                                        OverViewUserBloc(),
                                                  ),
                                                  BlocProvider<PostBloc>(
                                                    create: (context) =>
                                                        PostBloc(),
                                                  ),
                                                ],
                                                child: ProfileOtherPage(
                                                    creator:
                                                        state.suggestion[index],
                                                    onClose: () => {
                                                          friendBloc.add(
                                                              FriendLoadEvent(GetIt
                                                                  .instance
                                                                  .get<
                                                                      Authenticator>()
                                                                  .userProfile
                                                                  .id!))
                                                        }),
                                              )),
                                    )
                                  },
                                );
                              },
                            ),
                          ],
                        )
                      : history != null
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: history.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Icon(Icons.history),
                                  title: Text(history[index].name),
                                  selectedColor: Color(0x10F4F4F4),
                                  onTap: () => {},
                                );
                              },
                            )
                          : Container();
                },
              ),
            ));
      },
    );
  }

  Widget getListFriend() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
      child: SingleChildScrollView(
        child: BlocBuilder<FriendBloc, FriendState>(
          buildWhen: (context, state) {
            return state is FriendLoadingPageState ||
                state is FriendLoadedPageState ||
                state is FriendLoadPageFailState;
          },
          builder: (context, state) {
            if (state is FriendLoadingPageState)
              return Skeletonloaderfriend();
            else if (state is FriendLoadedPageState) {
              history = state.histories == null ? [] : state.histories;
              return friends(
                listFriend: state.friends,
                totalfriend: state.totalfriend,
                friendBloc: this.friendBloc,
              );
            } else
              return Text("");
          },
        ),
      ),
    );
  }
}

class Skeletonloaderfriend extends StatelessWidget {
  const Skeletonloaderfriend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      builder: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30.h,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 10.h,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      items: 10,
      period: Duration(seconds: 2),
      highlightColor: Color(0x505AA469),
      direction: SkeletonDirection.ltr,
    );
  }
}

class friends extends StatelessWidget {
  final List<UserOverview>? listFriend;
  final totalfriend;
  final friendBloc;
  const friends({
    Key? key,
    this.listFriend,
    this.totalfriend,
    this.friendBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Bạn đang theo dõi " + this.totalfriend.toString() + " người",
            style: kText17BoldBlack,
          ),
        ),
        this.listFriend != null
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: totalfriend,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
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
                                      creator: listFriend![index],
                                      onClose: () => {
                                            friendBloc.add(FriendLoadEvent(GetIt
                                                .instance
                                                .get<Authenticator>()
                                                .userProfile
                                                .id!))
                                          }),
                                )),
                      )
                    },
                    child: ShortInforCard(
                        userOverview: new UserOverview(
                            name: listFriend![index].name,
                            avatarUri: listFriend![index].avatarUri),
                        isFollow: true),
                  );
                },
              )
            : Text("Bạn chưa theo dõi ai")
      ],
    );
  }
}
