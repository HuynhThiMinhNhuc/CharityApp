import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/bloc/searchevent_bloc/bloc/searchevent_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchEvent extends StatefulWidget {
  List<bool> _ischoice = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  String _query = "";
  SearchEvent({Key? key}) : super(key: key);

  @override
  _SearchEventState createState() => _SearchEventState();
}

class _SearchEventState extends State<SearchEvent> {
  @override
  Widget build(BuildContext context) {
    final _searcheventBloc =
        BlocProvider.of<SearcheventBloc>(context).add(SearcheventLoadTags());

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Container(
                    height: 140,
                    color: backgroundbottomtab,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () => {Navigator.pop(context)},
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Container(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width - 80,
                                  color: Colors.white,
                                  child: TextField(
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 1,
                                    cursorColor: maincolor,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 15),
                                        border: const OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey, width: 0.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: maincolor, width: 0.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        hintText: "Tìm kiếm",
                                        hintStyle: TextStyle(
                                          color: Colors.black.withAlpha(120),
                                        ),
                                        suffixIcon: Icon(Icons.search),
                                        suffixIconColor: maincolor,
                                        focusColor: maincolor),
                                    onChanged: (String keyword) {
                                      widget._query = keyword;
                                      BlocProvider.of<SearcheventBloc>(context)
                                          .add(SearcheventSearch(
                                              query: keyword,
                                              tags: widget._ischoice));
                                    },
                                  )),
                            )
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: BlocBuilder<SearcheventBloc, SearcheventState>(
                            buildWhen: (context, state) {
                              return state is SearcheventInitial ||
                                  state is SearcheventTagLoadfail ||
                                  state is SearcheventTagLoaded;
                            },
                            builder: (context, state) {
                              if (state is SearcheventTagLoading ||
                                  state is SearcheventInitial) {
                                return Text("Loading tag...");
                              }
                              if (state is SearcheventTagLoadfail) {
                                return Text("Loading tag fail...");
                              }
                              return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      (state as SearcheventTagLoaded)
                                          .listTags
                                          .length, (index) {
                                    return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 5, 5),
                                        child: FilterChip(
                                          checkmarkColor:
                                              widget._ischoice[index]
                                                  ? Colors.white
                                                  : Colors.black,
                                          label: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 7, 0, 7),
                                            child: Text(
                                              state.listTags[index],
                                              style: TextStyle(
                                                  color: widget._ischoice[index]
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          backgroundColor: Colors.white,
                                          selectedColor: maincolor,
                                          selected: widget._ischoice[index],
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Color(0x183C3C43)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          onSelected: (bool value) {
                                            setState(() {
                                              widget._ischoice[index] = value;
                                            });
                                            BlocProvider.of<SearcheventBloc>(
                                                    context)
                                                .add(SearcheventSearch(
                                                    query: widget._query,
                                                    tags: widget._ischoice));
                                          },
                                        ));
                                  }));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                BlocBuilder<SearcheventBloc, SearcheventState>(
                  buildWhen: (context, state) {
                    return state is SearcheventEventLoadfail ||
                        state is SearcheventEventLoading ||
                        state is SearcheventNoResult ||
                        state is SearcheventResult;
                  },
                  builder: (context, state) {
                    if (state is SearcheventNoResult) {
                      return (Text("Không có kết quả"));
                    }
                    if (state is SearcheventEventLoadfail)
                      return Text("Loading event fail...");
                    if (state is SearcheventResult)
                      return Column(
                        children: [
                          ListView.builder(
                            itemCount: state.listEvent.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      state.listEvent[index].avatarUri == null
                                          ? AssetImage('asset/avatar.png')
                                          : NetworkImage(state.listEvent[index]
                                              .avatarUri!) as ImageProvider,
                                  radius: 30,
                                ),
                                title: Text(state.listEvent[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    )),
                                subtitle: Text(
                                  "tp. Hồ Chí Minh, quận Thủ Đức",
                                  style:
                                      TextStyle(color: textcolor, fontSize: 14),
                                ),
                              );
                            },
                          )
                        ],
                      );
                    else
                      return Text("Loading....");
                  },
                )
              ],
            ),
          )),
    );
  }
}
