import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTag extends StatefulWidget {
  final Iterable<TagItemInUI> initTags;
  AddTag({Key? key, required this.initTags}) : super(key: key);

  @override
  _AddTagState createState() => _AddTagState();
}

class _AddTagState extends State<AddTag> {
  late Iterable<TagItemInUI> tags;

  @override
  void initState() {
    super.initState();
    tags = widget.initTags;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: textColor, //change your color here
        ),
        centerTitle: true,
        backgroundColor: backgroundBottomTab,
        title: Text(
          "Thêm tag",
          style: kText18BoldBlack,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(tags
                  .where((tag) => tag.isSelected == true)
                  .map((tagUI) => tagUI.tag)
                  .toList());
            },
            child: Text(
              "Hoàn thành ",
              style: kText15BoldMain,
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.w, 10.h, 10.w, 0),
        child: Wrap(
          spacing: 8.0.h, // gap between adjacent chips
          runSpacing: 2.0.w, // gap between lines
          children: generate_tags(),
        ),
      ),
    );
  }

  List<Widget> generate_tags() {
    List<FilterChip> chips = [];
    for (var tag in tags) {
      chips.add(FilterChip(
        checkmarkColor: tag.isSelected ? Colors.white : Colors.black,
        selectedColor: maincolor,
        selected: tag.isSelected,
        label: Text(
          tag.tag.name,
          style: TextStyle(
              fontFamily: 'Roboto_Regular',
              fontSize: 15.sp,
              color: tag.isSelected ? Colors.white : textColor),
        ),
        onSelected: (bool value) {
          setState(() {
            tag.isSelected = !tag.isSelected;
          });
        },
      ));
    }
    return chips;
  }
}

class TagItemInUI {
  final TagEvent tag;
  bool isSelected;
  TagItemInUI({Key? key, required this.tag, this.isSelected = false});
}
