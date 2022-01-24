import 'dart:io';

import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageCard extends StatefulWidget {
  final double width;
  final double height;
  final String? hintTitle;
  final IconData? icon;
  final Function(File)? onImageChanged;
  final Function()? onImageDeleted;

  ImageCard({
    Key? key,
    this.hintTitle,
    this.width = 120,
    this.height = 150,
    this.onImageChanged,
    this.onImageDeleted,
    this.icon,
  }) : super(key: key);

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

      //Get image path in storage app
      final image = File('${directory.path}/${basename(picture.path)}');

      //Create new image from source image, add temporary to storage app
      final file = await File(picture.path); //.copy(image.path);

      this.setState(() {
        //Update UI with image
        imageFile = file;
      });
      widget.onImageChanged?.call(imageFile!);
    }
  }

  Future<void> _deleteImage() async {
    if (imageFile != null) {
      print('request delete if image not null');
      setState(() {
        imageFile = null;
      });
      widget.onImageDeleted?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = widget.width;
    final double height = widget.height;

    return Container(
      child: InkWell(
        child: imageFile != null
            ? Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    imageFile!,
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Color(0xff455154),
                      ),
                      onPressed: _deleteImage,
                    ))
              ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.hintTitle != null)
                    Text(widget.hintTitle!,
                        textAlign: TextAlign.center,
                        style: kText13RegularBlack),
                  if (widget.icon != null)
                    Icon(widget.icon, color: maincolor, size: 25),
                ],
              ),
        onTap: _galleryImage,
        onLongPress: _deleteImage,
      ),
      height: 150,
      width: 120,
      decoration: BoxDecoration(
        color: backgroundbottomtab,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.fromLTRB(10.h, 10.w, 5.h, 10.h),
    );
  }
}
