import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class UploadImageToFirestorage {
  static Future<String?> call({
    required File imageFile,
    required String rootPath,
  }) async {
    String fileName = basename(imageFile.path);
    try {
      final uploadTask = await FirebaseStorage.instance
          .ref('$rootPath/$fileName')
          .putFile(imageFile);
      return await uploadTask.ref.getDownloadURL();
    } on FirebaseException {
      print("Error upload file + ${basename(imageFile.path)}");
      return null;
    }
  }
}
