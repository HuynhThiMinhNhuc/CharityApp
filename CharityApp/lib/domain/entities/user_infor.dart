import 'package:charityapp/core/uint8list_converter.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_infor.g.dart';

enum Genders {
  Male,
  Female,
  Undefined,
}

@JsonSerializable()
class UserInfor extends UserOverview {
  String? description;
  String? birthDayString;
  Genders gender;

  DateTime? get birthDay => birthDayString != null ? DateFormat('dd/MM/yyyy').parse(birthDayString!) : null;

  UserInfor({required name, 
      required avatar,
      required this.description,
      required this.birthDayString,
      required this.gender,
  }) : super(name: name, avatar: avatar);

  factory UserInfor.fromJson(Map<String, dynamic> json) => _$UserInforFromJson(json);
  Map<String, dynamic> toJson() => _$UserInforToJson(this);
}