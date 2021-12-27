import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Pages/friend_page/widgets/short_infor_card.dart';
import 'package:charityapp/views/bloc/friend_bloc/friend_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({Key? key}) : super(key: key);

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  @override
  void initState() {
    super.initState();
    final friendBloc = BlocProvider.of<FriendBloc>(context);
    friendBloc.add(
        FriendLoadEvent(GetIt.instance.get<Authenticator>().idCurrentUser));
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
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: Colors.white);
                //Apply list friend suggest
              }).toList(),
            ),
          ),
        );
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
              return Text("Loading....");
            else if (state is FriendLoadedState)
              return friends(
                listFriend: state.friends,
                totalfriend: state.totalfriend,
              );
            else
              return Text("Loading failer....");
          },
        ),
      ),
    );
  }
}

class friends extends StatelessWidget {
  final List<UserOverview>? listFriend;
  final totalfriend;
  const friends({
    Key? key,
    this.listFriend,
    this.totalfriend,
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
                  return ShortInforCard(
                      userOverview: new UserOverview(
                          name: listFriend![index].name,
                          avatarUri: listFriend![index].avatarUri),
                      isFollow: true);
                },
              )
            : Text("Bạn chưa có bạn bè nào cả")
      ],
    );
  }
}
