import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Pages/add_event_page/add_event_page.dart';
import 'package:charityapp/views/Pages/friend_page/widgets/short_infor_card.dart';
import 'package:charityapp/views/Pages/profile_page/profile_other.dart';
import 'package:charityapp/views/Pages/profile_page/profile_page.dart';
import 'package:charityapp/views/bloc/friend_bloc/friend_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/post_bloc/post_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({Key? key}) : super(key: key);

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  List<String> history = ["Anna", "William", "Janne", "JoneCena", "Alam"];
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
    final actions = [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.place),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];

    return FloatingSearchBar(
      backdropColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: BorderSide(width: 1, color: Color(0xFFA6A6AA)),
      hint: 'Tìm kiếm',
      clearQueryOnClose: true,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      closeOnBackdropTap: true,
      onQueryChanged: (query) {
        friendBloc.add(FriendSearchEvent(query));
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
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
                  return state is FriendSearchState ||
                      state is FriendLoadingState ||
                      state is FriendLoadFailState;
                },
                builder: (context, state) {
                  return state is FriendSearchState
                      ? Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.suggestion.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                      radius: 18,
                                      backgroundImage: state.suggestion[index]
                                                  .avatarUri ==
                                              null
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
                                                    state.suggestion[index].id,
                                                    () => {
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
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: history.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Icon(Icons.history),
                              title: Text(history[index]),
                              selectedColor: Color(0x10F4F4F4),
                              onTap: () => {},
                            );
                          },
                        );
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
            return state is FriendLoadingState ||
                state is FriendLoadedState ||
                state is FriendLoadFailState;
          },
          builder: (context, state) {
            if (state is FriendLoadingState)
              return Skeletonloaderfriend();
            else if (state is FriendLoadedState)
              return friends(
                listFriend: state.friends,
                totalfriend: state.totalfriend,
                friendBloc: this.friendBloc,
              );
            else
              return Text("Loading failer....");
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
      builder: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flexible(
                child: Container(
                  width: 200,
                  height: 20,
                  color: Colors.white,
                ),
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 10,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
            this.totalfriend.toString() + " người theo dõi bạn",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        this.listFriend != null
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listFriend!.length,
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
                                      listFriend![index].id,
                                      () => {
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
            : Text("Bạn chưa có bạn bè nào cả")
      ],
    );
  }
}
