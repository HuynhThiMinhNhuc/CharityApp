// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_infor.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserInfor.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfUserInfor.copyWith.fieldName(...)`
class _UserInforCWProxy {
  final UserInfor _value;

  const _UserInforCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `UserInfor(...).copyWithNull(...)` to set certain fields to `null`. Prefer `UserInfor(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserInfor(...).copyWith(id: 12, name: "My name")
  /// ````
  UserInfor call({
    dynamic? avatarUri,
    String? birthDayString,
    String? description,
    Genders? gender,
    String? id,
    dynamic? name,
  }) {
    return UserInfor(
      avatarUri: avatarUri ?? _value.avatarUri,
      birthDayString: birthDayString ?? _value.birthDayString,
      description: description ?? _value.description,
      gender: gender ?? _value.gender,
      id: id ?? _value.id,
      name: name ?? _value.name,
    );
  }

  UserInfor birthDayString(String? birthDayString) => birthDayString == null
      ? _value._copyWithNull(birthDayString: true)
      : this(birthDayString: birthDayString);

  UserInfor description(String? description) => description == null
      ? _value._copyWithNull(description: true)
      : this(description: description);

  UserInfor id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  UserInfor avatarUri(dynamic avatarUri) => this(avatarUri: avatarUri);

  UserInfor gender(Genders gender) => this(gender: gender);

  UserInfor name(dynamic name) => this(name: name);
}

extension UserInforCopyWith on UserInfor {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass UserInfor extends UserOverview.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass UserInfor extends UserOverview.name.copyWith.fieldName(...)`
  _UserInforCWProxy get copyWith => _UserInforCWProxy(this);

  UserInfor _copyWithNull({
    bool birthDayString = false,
    bool description = false,
    bool id = false,
  }) {
    return UserInfor(
      avatarUri: avatarUri,
      birthDayString: birthDayString == true ? null : this.birthDayString,
      description: description == true ? null : this.description,
      gender: gender,
      id: id == true ? null : this.id,
      name: name,
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
    )..address = json['address'] as String?;

Map<String, dynamic> _$UserInforToJson(UserInfor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUri': instance.avatarUri,
      'address': instance.address,
      'description': instance.description,
      'birthDayString': instance.birthDayString,
      'gender': _$GendersEnumMap[instance.gender],
    };

const _$GendersEnumMap = {
  Genders.Male: 'Male',
  Genders.Female: 'Female',
  Genders.Undefined: 'Undefined',
};
