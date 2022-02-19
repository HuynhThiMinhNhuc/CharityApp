// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfBaseUser.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfBaseUser.copyWith.fieldName(...)`
class _BaseUserCWProxy {
  final BaseUser _value;

  const _BaseUserCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `BaseUser(...).copyWithNull(...)` to set certain fields to `null`. Prefer `BaseUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BaseUser(...).copyWith(id: 12, name: "My name")
  /// ````
  BaseUser call({
    String? id,
    String? name,
  }) {
    return BaseUser(
      id: id ?? _value.id,
      name: name ?? _value.name,
    );
  }

  BaseUser id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  BaseUser name(String name) => this(name: name);
}

extension BaseUserCopyWith on BaseUser {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass BaseUser extends BaseObject.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass BaseUser extends BaseObject.name.copyWith.fieldName(...)`
  _BaseUserCWProxy get copyWith => _BaseUserCWProxy(this);

  BaseUser _copyWithNull({
    bool id = false,
  }) {
    return BaseUser(
      id: id == true ? null : this.id,
      name: name,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseUser _$BaseUserFromJson(Map<String, dynamic> json) => BaseUser(
      name: json['name'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$BaseUserToJson(BaseUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
