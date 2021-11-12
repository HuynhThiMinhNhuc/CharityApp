import 'package:flutter/material.dart';

import 'information_creator_post_view.dart';

class PostOverview extends StatefulWidget {
  final String nameCreator;
  final String location;
  final String title;
  final String description;
  final List<String> tags;
  final String imageAsset;

  PostOverview(this.nameCreator, this.location, this.title, this.description,
      this.tags, this.imageAsset);

  @override
  _PostOverviewState createState() => _PostOverviewState();
}

class _PostOverviewState extends State<PostOverview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InformationCreatorPostView(widget.nameCreator, widget.location),
        SizedBox(height: 10,),
        Image.asset(
          widget.imageAsset,
          fit: BoxFit.fitWidth
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10,5,5,5),
          child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10,5,5,5),
          child: Text(
            widget.description,
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(
          height: 30,
          child: ListView.builder(
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: ElevatedButton(
                    onPressed: null, child: Text(widget.tags[index])),
              );
            },
            itemCount: widget.tags.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
