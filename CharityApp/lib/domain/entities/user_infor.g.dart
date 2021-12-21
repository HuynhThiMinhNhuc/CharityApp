// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_infor.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension UserInforCopyWith on UserInfor {
  UserInfor copyWith({
    dynamic? avatarUri,
    String? birthDayString,
    String? description,
    Genders? gender,
    String? id,
    dynamic? name,
  }) {
    return UserInfor(
      avatarUri: avatarUri ?? this.avatarUri,
      birthDayString: birthDayString ?? this.birthDayString,
      description: description ?? this.description,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfor _$UserInforFromJson(Map<String, dynamic> json) => UserInfor(
      name: json['name'],
      avatarUri: json['avatarUri'],
      description: json['description'] as String?,
      birthDayString: json['birthDayString'] as String?,
      gender: $enumDecode(_$GendersEnumMap, json['gender']),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$UserInforToJson(UserInfor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUri': instance.avatarUri?.toString(),
      'description': instance.description,
      'birthDayString': instance.birthDayString,
      'gender': _$GendersEnumMap[instance.gender],
    };

const _$GendersEnumMap = {
  Genders.Male: 'Male',
  Genders.Female: 'Female',
  Genders.Undefined: 'Undefined',
};
