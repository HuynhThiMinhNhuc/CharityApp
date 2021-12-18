// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_infor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfor _$UserInforFromJson(Map<String, dynamic> json) => UserInfor(
      name: json['name'],
// <<<<<<< Updated upstream
      avatarUri: json['avatarUri'],
// =======
//      // avatar: json['avatar'],
// >>>>>>> Stashed changes
      description: json['description'] as String?,
      birthDayString: json['birthDayString'] as String?,
      gender: $enumDecode(_$GendersEnumMap, json['gender']),
    );

Map<String, dynamic> _$UserInforToJson(UserInfor instance) => <String, dynamic>{
      'name': instance.name,
//<<<<<<< Updated upstream
      'avatarUri': instance.avatarUri?.toString(),
// =======
//      // 'avatar': const Uint8ListConverter().toJson(instance.avatar),
// >>>>>>> Stashed changes
      'description': instance.description,
      'birthDayString': instance.birthDayString,
      'gender': _$GendersEnumMap[instance.gender],
    };

const _$GendersEnumMap = {
  Genders.Male: 'Male',
  Genders.Female: 'Female',
  Genders.Undefined: 'Undefined',
};
