import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddTag extends StatefulWidget {
  final List<Tags> tags;
  AddTag({Key? key, required this.tags}) : super(key: key);

  @override
  _AddTagState createState() => _AddTagState();
}

class _AddTagState extends State<AddTag> {
  @override
  Widget build(BuildContext context) {
    bool _isSelect = false;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: textcolor, //change your color here
        ),
        centerTitle: true,
        backgroundColor: backgroundbottomtab,
        title: Text(
          "Thêm tag",
          style: TextStyle(
              color: textcolor,
              fontFamily: 'Roboto_Regular',
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Hoàn thành ",
              style: TextStyle(
                  color: maincolor,
                  fontSize: 18,
                  fontFamily: 'Roboto_Regular',
                  fontWeight: FontWeight.bold),
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
        padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
        child: Wrap(
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 4.0, // gap between lines
          children: <Widget>[...generate_tags()],
        ),
      ),
    );
  }

  generate_tags() {
    List<FilterChip> chips = [];
    for (var tag in widget.tags) {
      chips.add(FilterChip(
        checkmarkColor: tag.isSelected ? Colors.white : Colors.black,
        selectedColor: maincolor,
        selected: tag.isSelected,
        label: Text(
          tag.tag,
          style: TextStyle(
              fontFamily: 'Roboto_Regular',
              fontSize: 15,
              color: tag.isSelected ? Colors.white : textcolor),
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

class Tags {
  String tag;
  bool isSelected;
  Tags({Key? key, required this.tag, required this.isSelected});
}
