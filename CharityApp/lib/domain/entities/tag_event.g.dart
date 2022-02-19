// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfTagEvent.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfTagEvent.copyWith.fieldName(...)`
class _TagEventCWProxy {
  final TagEvent _value;

  const _TagEventCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `TagEvent(...).copyWithNull(...)` to set certain fields to `null`. Prefer `TagEvent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TagEvent(...).copyWith(id: 12, name: "My name")
  /// ````
  TagEvent call({
    String? id,
    String? name,
  }) {
    return TagEvent(
      id: id ?? _value.id,
      name: name ?? _value.name,
    );
  }

  TagEvent id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  TagEvent name(String name) => this(name: name);
}

extension TagEventCopyWith on TagEvent {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass TagEvent extends BaseObject.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass TagEvent extends BaseObject.name.copyWith.fieldName(...)`
  _TagEventCWProxy get copyWith => _TagEventCWProxy(this);

  TagEvent _copyWithNull({
    bool id = false,
  }) {
    return TagEvent(
      id: id == true ? null : this.id,
      name: name,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagEvent _$TagEventFromJson(Map<String, dynamic> json) => TagEvent(
      name: json['name'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$TagEventToJson(TagEvent instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
