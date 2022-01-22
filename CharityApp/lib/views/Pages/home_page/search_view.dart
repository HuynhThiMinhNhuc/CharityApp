import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/bloc/searchevent_bloc/bloc/searchevent_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchEvent extends StatefulWidget {
  final List<bool> _ischoice = [
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
    final _searcheventBloc = BlocProvider.of<SearcheventBloc>(context);
    _searcheventBloc.add(SearcheventLoadTags());
    _searcheventBloc.add(SearcheventSearch(query: "", tags: []));
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Container(
                    height: 135.h,
                    color: backgroundbottomtab,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () => {Navigator.pop(context)},
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                )),
                            // SizedBox(
                            //   width: 10.w,
                            // ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
                              child: Container(
                                  height: 45.h,
                                  width:
                                      MediaQuery.of(context).size.width - 80.h,
                                  color: Colors.white,
                                  child: TextField(
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 1,
                                    cursorColor: maincolor,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 15.w),
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
                                            fontSize: 16.sp),
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
                              if (state is SearcheventInitial) {
                                return Container();
                              } else if (state is SearcheventTagLoading) {
                                return Text("Loading search...");
                              }
                              if (state is SearcheventTagLoadfail) {
                                return Text("Loading search fail...");
                              }
                              return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      (state as SearcheventTagLoaded)
                                          .listTags
                                          .length, (index) {
                                    return Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            5.w, 0, 3.w, 5.h),
                                        child: FilterChip(
                                          checkmarkColor:
                                              widget._ischoice[index]
                                                  ? Colors.white
                                                  : Colors.black,
                                          label: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 7.h, 0, 7.h),
                                            child: Text(
                                              state.listTags[index].name,
                                              style: TextStyle(
                                                  color: widget._ischoice[index]
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 14.sp),
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
                      return Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Container(
                            width: 170.w,
                            height: 170.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "asset/imageInpage/no_result.png")),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Không có kết quả tìm kiếm",
                            style: kText15RegularGreyText,
                          )
                        ],
                      );
                    }
                    if (state is SearcheventEventLoadfail)
                      return Column(
                        children: [
                          Container(
                            width: 170.w,
                            height: 170.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "asset/imageInpage/no_result.png")),
                            ),
                          ),
                          Text("Không có kết quả tìm kiếm",
                              style: kText15RegularGreyText)
                        ],
                      );
                    if (state is SearcheventResult)
                      return Column(
                        children: [
                          ListView.builder(
                            itemCount: state.listEvent.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: (state.listEvent[index]
                                                    .avatarUri ==
                                                "" ||
                                            state.listEvent[index].avatarUri ==
                                                null)
                                        ? AssetImage('asset/avatar.png')
                                        : NetworkImage(state.listEvent[index]
                                            .avatarUri!) as ImageProvider,
                                    radius: 30.h,
                                  ),
                                  title: Text(state.listEvent[index].name,
                                      style: kText16BoldBlack),
                                  subtitle: Text(
                                    "tp. Hồ Chí Minh, quận Thủ Đức",
                                    style: TextStyle(
                                        color: textcolor, fontSize: 14.sp),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.eventPage,
                                      arguments: state.listEvent[index].id!);
                                },
                              );
                            },
                          )
                        ],
                      );
                    else
                      return SkeletonLoaderSearchfriend();
                  },
                )
              ],
            ),
          )),
    );
  }
}

class SkeletonLoaderSearchfriend extends StatelessWidget {
  const SkeletonLoaderSearchfriend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      builder: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30.h,
            ),
            SizedBox(width: 10.h),
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
