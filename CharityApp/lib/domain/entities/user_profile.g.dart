// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserProfile.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfUserProfile.copyWith.fieldName(...)`
class _UserProfileCWProxy {
  final UserProfile _value;

  const _UserProfileCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `UserProfile(...).copyWithNull(...)` to set certain fields to `null`. Prefer `UserProfile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserProfile(...).copyWith(id: 12, name: "My name")
  /// ````
  UserProfile call({
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
      avatarUri: avatarUri ?? _value.avatarUri,
      birthDayString: birthDayString ?? _value.birthDayString,
      description: description ?? _value.description,
      email: email ?? _value.email,
      gender: gender ?? _value.gender,
      id: id ?? _value.id,
      name: name ?? _value.name,
      numberFollower: numberFollower ?? _value.numberFollower,
      numberFollowing: numberFollowing ?? _value.numberFollowing,
      numberPost: numberPost ?? _value.numberPost,
      phone: phone ?? _value.phone,
    );
  }

  UserProfile id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  UserProfile avatarUri(dynamic avatarUri) => this(avatarUri: avatarUri);

  UserProfile birthDayString(dynamic birthDayString) =>
      this(birthDayString: birthDayString);

  UserProfile description(dynamic description) =>
      this(description: description);

  UserProfile email(String email) => this(email: email);

  UserProfile gender(dynamic gender) => this(gender: gender);

  UserProfile name(dynamic name) => this(name: name);

  UserProfile numberFollower(int numberFollower) =>
      this(numberFollower: numberFollower);

  UserProfile numberFollowing(int numberFollowing) =>
      this(numberFollowing: numberFollowing);

  UserProfile numberPost(int numberPost) => this(numberPost: numberPost);

  UserProfile phone(String phone) => this(phone: phone);
}

extension UserProfileCopyWith on UserProfile {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass UserProfile extends UserInfor.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass UserProfile extends UserInfor.name.copyWith.fieldName(...)`
  _UserProfileCWProxy get copyWith => _UserProfileCWProxy(this);

  UserProfile _copyWithNull({
    bool id = false,
  }) {
    return UserProfile(
      avatarUri: avatarUri,
      birthDayString: birthDayString,
      description: description,
      email: email,
      gender: gender,
      id: id == true ? null : this.id,
      name: name,
      numberFollower: numberFollower,
      numberFollowing: numberFollowing,
      numberPost: numberPost,
      phone: phone,
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
