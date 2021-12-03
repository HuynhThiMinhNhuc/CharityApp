// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      name: json['name'],
      avatar: json['avatar'],
      description: json['description'],
      birthDayString: json['birthDayString'],
      gender: json['gender'] ?? Genders.Undefined,
      numberFollower: json['numberFollower'] as int? ?? 0,
      numberFollowing: json['numberFollowing'] as int? ?? 0,
      numberPost: json['numberPost'] as int? ?? 0,
    )..id = json['id'] as String?;

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': const Uint8ListConverter().toJson(instance.avatar),
      'description': instance.description,
      'birthDayString': instance.birthDayString,
      'gender': _$GendersEnumMap[instance.gender],
      'numberPost': instance.numberPost,
      'numberFollower': instance.numberFollower,
      'numberFollowing': instance.numberFollowing,
    };

const _$GendersEnumMap = {
  Genders.Male: 'Male',
  Genders.Female: 'Female',
  Genders.Undefined: 'Undefined',
};
