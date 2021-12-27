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
    dynamic? gender,
    String? id,
    dynamic? name,
    int? numberFollower,
    int? numberFollowing,
    int? numberPost,
    dynamic? phone,
    dynamic? email,
    dynamic? password,
  }) {
    return UserProfile(
      avatarUri: avatarUri ?? this.avatarUri,
      birthDayString: birthDayString ?? this.birthDayString,
      description: description ?? this.description,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      name: name ?? this.name,
      numberFollower: numberFollower ?? this.numberFollower,
      numberFollowing: numberFollowing ?? this.numberFollowing,
      numberPost: numberPost ?? this.numberPost, 
      email: phone ?? this.phone, 
      password: email ?? this.email, 
      phone: password ?? this.password, 
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
      id: json['id'] as String?, 
      email: json['email'] as String, 
      password: json['password'] as String, 
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUri': instance.avatarUri?.toString(),
      'description': instance.description,
      'birthDayString': instance.birthDayString,
      'gender': _$GendersEnumMap[instance.gender],
      'numberPost': instance.numberPost,
      'numberFollower': instance.numberFollower,
      'numberFollowing': instance.numberFollowing,
      'phone': instance.phone,
      'email':instance.email,
      'password': instance.password
    };

const _$GendersEnumMap = {
  Genders.Male: 'Male',
  Genders.Female: 'Female',
  Genders.Undefined: 'Undefined',
};
