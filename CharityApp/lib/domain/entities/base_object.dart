abstract class BaseObject {
  late String _id = "1";

  String get id => _id;
  set id(String value) {
    _id = value;
  }
}