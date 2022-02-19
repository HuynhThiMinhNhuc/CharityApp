// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_overview.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserOverview.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfUserOverview.copyWith.fieldName(...)`
class _UserOverviewCWProxy {
  final UserOverview _value;

  const _UserOverviewCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `UserOverview(...).copyWithNull(...)` to set certain fields to `null`. Prefer `UserOverview(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserOverview(...).copyWith(id: 12, name: "My name")
  /// ````
  UserOverview call({
    String? address,
    String? avatarUri,
    String? id,
    String? name,
  }) {
    return UserOverview(
      address: address ?? _value.address,
      avatarUri: avatarUri ?? _value.avatarUri,
      id: id ?? _value.id,
      name: name ?? _value.name,
    );
  }

  UserOverview address(String? address) => address == null
      ? _value._copyWithNull(address: true)
      : this(address: address);

  UserOverview avatarUri(String? avatarUri) => avatarUri == null
      ? _value._copyWithNull(avatarUri: true)
      : this(avatarUri: avatarUri);

  UserOverview id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  UserOverview name(String name) => this(name: name);
}

extension UserOverviewCopyWith on UserOverview {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass UserOverview extends BaseUser.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass UserOverview extends BaseUser.name.copyWith.fieldName(...)`
  _UserOverviewCWProxy get copyWith => _UserOverviewCWProxy(this);

  UserOverview _copyWithNull({
    bool address = false,
    bool avatarUri = false,
    bool id = false,
  }) {
    return UserOverview(
      address: address == true ? null : this.address,
      avatarUri: avatarUri == true ? null : this.avatarUri,
      id: id == true ? null : this.id,
      name: name,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOverview _$UserOverviewFromJson(Map<String, dynamic> json) => UserOverview(
      name: json['name'] as String,
      avatarUri: json['avatarUri'] as String?,
      id: json['id'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$UserOverviewToJson(UserOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUri': instance.avatarUri,
      'address': instance.address,
    };
