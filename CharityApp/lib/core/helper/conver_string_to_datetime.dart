import 'package:intl/intl.dart';

class StringToDatetime {
  static DateTime? Convert(String? value) {
    return value != null ? DateFormat('dd/MM/yyyy').parse(value) : null;
  }
}