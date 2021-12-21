import 'package:intl/intl.dart';

class StringToDatetime {
  static DateTime? convert(String? value) {
    return value != null ? DateFormat('dd/MM/yyyy').parse(value) : null;
  }
}