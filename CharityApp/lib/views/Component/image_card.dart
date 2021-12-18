import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageCard extends StatefulWidget {
  final double width;
  final double height;
  final String hintTitle;
  final Function(File?)? onImageChanged;

  ImageCard(
      {Key? key,
      this.hintTitle = "+ Thêm hình ảnh",
      this.width = 120,
      this.height = 150,
      this.onImageChanged})
      : super(key: key);

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  File? imageFile;
  Future<void> _galleryImage() async {
    final _picker = ImagePicker();
    var picture = await _picker.pickImage(source: ImageSource.gallery);
    if (picture != null) {
      final directory = await getApplicationDocumentsDirectory();
      final image = File('${directory.path}/${basename(picture.path)}');
      final file = await File(picture.path);//.copy(image.path);
      
      this.setState(() {
        //TODO: Add image to storage app
        imageFile = file;
        widget.onImageChanged?.call(imageFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = widget.width;
    final double height = widget.height;

    return Container(
      child: imageFile != null
          ? Image.file(
              imageFile!,
              width: width,
              height: height,
            )
          : InkWell(
              child: Center(
                child: Text(
                  widget.hintTitle,
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: _galleryImage,
            ),
      height: 150,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.black),
      ),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
    );
  }
}
