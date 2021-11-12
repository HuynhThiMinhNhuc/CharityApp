import 'package:flutter/material.dart';

class InformationCreatorPostView extends StatelessWidget {
  final String avatarAsset;
  final String name;
  final String location;

  InformationCreatorPostView(this.name, this.location,
      {this.avatarAsset = "asset/imagesample/avatar1.jpg"});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(this.avatarAsset),
            radius: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(this.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(this.location, style: TextStyle(fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }
}
