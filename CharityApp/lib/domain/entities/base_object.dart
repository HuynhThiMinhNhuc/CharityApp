import 'package:copy_with_extension/copy_with_extension.dart';

@CopyWith()
abstract class BaseObject {
  String? id;

  BaseObject({this.id});
  // setId(String id) {
  //   _id = id;
  // }
}