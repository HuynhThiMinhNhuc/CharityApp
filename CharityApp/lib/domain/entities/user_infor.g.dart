// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_infor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfor _$UserInforFromJson(Map<String, dynamic> json) => UserInfor(
      name: json['name'],
      avatar: json['avatar'],
      description: json['description'] as String?,
      birthDayString: json['birthDayString'] as String?,
      gender: $enumDecode(_$GendersEnumMap, json['gender']),
    )..id = json['id'] as String?;

Map<String, dynamic> _$UserInforToJson(UserInfor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': const Uint8ListConverter().toJson(instance.avatar),
      'description': instance.description,
      'birthDayString': instance.birthDayString,
      'gender': _$GendersEnumMap[instance.gender],
    };

const _$GendersEnumMap = {
  Genders.Male: 'Male',
  Genders.Female: 'Female',
  Genders.Undefined: 'Undefined',
};
