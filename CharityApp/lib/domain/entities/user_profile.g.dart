// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension UserProfileCopyWith on UserProfile {
  UserProfile copyWith({
    dynamic? avatarUri,
    dynamic? birthDayString,
    dynamic? description,
    String? email,
    dynamic? gender,
    String? id,
    dynamic? name,
    int? numberFollower,
    int? numberFollowing,
    int? numberPost,
    String? phone,
  }) {
    return UserProfile(
      avatarUri: avatarUri ?? this.avatarUri,
      birthDayString: birthDayString ?? this.birthDayString,
      description: description ?? this.description,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      name: name ?? this.name,
      numberFollower: numberFollower ?? this.numberFollower,
      numberFollowing: numberFollowing ?? this.numberFollowing,
      numberPost: numberPost ?? this.numberPost,
      phone: phone ?? this.phone,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      name: json['name'],
      avatarUri: json['avatarUri'],
      description: json['description'],
      birthDayString: json['birthDayString'],
      gender: json['gender'] ?? Genders.Undefined,
      numberFollower: json['numberFollower'] as int? ?? 0,
      numberFollowing: json['numberFollowing'] as int? ?? 0,
      numberPost: json['numberPost'] as int? ?? 0,
      phone: json['phone'] as String,
      email: json['email'] as String,
      id: json['id'] as String?,
    )..address = json['address'] as String?;

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUri': instance.avatarUri,
      'address': instance.address,
      'description': instance.description,
      'birthDayString': instance.birthDayString,
      'gender': _$GendersEnumMap[instance.gender],
      'numberPost': instance.numberPost,
      'numberFollower': instance.numberFollower,
      'numberFollowing': instance.numberFollowing,
      'phone': instance.phone,
      'email': instance.email,
    };

const _$GendersEnumMap = {
  Genders.Male: 'Male',
  Genders.Female: 'Female',
  Genders.Undefined: 'Undefined',
};
