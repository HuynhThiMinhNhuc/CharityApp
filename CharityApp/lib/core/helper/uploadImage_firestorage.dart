import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';

class UploadImageToFirestorage {
  static Future<String> call({
    required File imageFile,
    required String rootPath,
  }) async {
    File? imageCompressFile;
    try {
      imageCompressFile = await compressFile(imageFile, 50);
      String fileName = basename(imageCompressFile.path);

      final uploadTask = await FirebaseStorage.instance
          .ref('$rootPath/$fileName')
          .putFile(imageCompressFile);
      return await uploadTask.ref.getDownloadURL();
    } on FirebaseException {
      print("Error upload file + ${basename(imageFile.path)}");
      rethrow;
    } finally {
      if (imageCompressFile != null) {
        imageCompressFile.delete();
      }
    }
  }
}

Future<File> compressFile(File file, int quality) async {
  final filePath = file.absolute.path;

  // Create output file path
  // eg:- "Volume/VM/abcd_out.jpeg"
  final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    outPath,
    quality: quality,
  );

  print(file.lengthSync());
  print(result!.lengthSync());

  return result;
}
