import 'package:charityapp/core/helper/conver_string_to_datetime.dart';
import 'package:charityapp/core/helper/uint8list_converter.dart';
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

  DateTime? get birthDay => StringToDatetime.Convert(
      birthDayString); // birthDayString != null ? DateFormat('dd/MM/yyyy').parse(birthDayString!) : null;

  UserInfor({
    required name,
    required avatarUri,
    required this.description,
    required this.birthDayString,
    required this.gender,
  }) : super(name: name, avatarUri: avatarUri);

  // factory UserInfor.fromJson(Map<String, dynamic> json) => _$UserInforFromJson(json);
  // Map<String, dynamic> toJson() => _$UserInforToJson(this);

  factory UserInfor.fromJson(Map<String, dynamic> json) => UserInfor(
        name: json['name'],
        avatarUri: json['avatarUri'],
        description: json['description'] as String?,
        birthDayString: json['birthDayString'] as String?,
        gender: $enumDecode(_$GendersEnumMap, json['gender']),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'avatarUri': this.avatarUri?.toString(),
        'description': this.description,
        'birthDayString': this.birthDayString,
        'gender': _$GendersEnumMap[this.gender],
      };
}
