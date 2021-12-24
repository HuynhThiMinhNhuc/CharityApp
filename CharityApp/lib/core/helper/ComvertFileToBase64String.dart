import 'dart:io' as Io;

import 'dart:io';
import 'dart:convert';

import 'dart:typed_data';

class FilestoBase64String {
  static Uint8List? encode;
  static Future<Uint8List> endcode(File image) async {
    Uint8List? bytes;
    bytes = await Io.File(image.path).readAsBytes();
    encode = bytes;
    return bytes;
  }

  // static File? decode(String source) {
  //   final bytes;
  //   var file = Io.File("data.png");
  //   try {
  //     Uint8List bytes = base64.decode(source);
  //     return  file.writeAsBytes(bytes);
  //   } catch (e) {
  //     print("Lỗi Decode error:" + e.toString());
  //     return file;
  //   }
  // }
}
