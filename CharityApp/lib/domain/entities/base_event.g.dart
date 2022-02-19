// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfBaseEvent.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfBaseEvent.copyWith.fieldName(...)`
class _BaseEventCWProxy {
  final BaseEvent _value;

  const _BaseEventCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `BaseEvent(...).copyWithNull(...)` to set certain fields to `null`. Prefer `BaseEvent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BaseEvent(...).copyWith(id: 12, name: "My name")
  /// ````
  BaseEvent call({
    String? creatorId,
    String? id,
    String? name,
    DateTime? timeCreate,
  }) {
    return BaseEvent(
      creatorId: creatorId ?? _value.creatorId,
      id: id ?? _value.id,
      name: name ?? _value.name,
      timeCreate: timeCreate ?? _value.timeCreate,
    );
  }

  BaseEvent id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  BaseEvent timeCreate(DateTime? timeCreate) => timeCreate == null
      ? _value._copyWithNull(timeCreate: true)
      : this(timeCreate: timeCreate);

  BaseEvent creatorId(String creatorId) => this(creatorId: creatorId);

  BaseEvent name(String name) => this(name: name);
}

extension BaseEventCopyWith on BaseEvent {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass BaseEvent extends BaseObject.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass BaseEvent extends BaseObject.name.copyWith.fieldName(...)`
  _BaseEventCWProxy get copyWith => _BaseEventCWProxy(this);

  BaseEvent _copyWithNull({
    bool id = false,
    bool timeCreate = false,
  }) {
    return BaseEvent(
      creatorId: creatorId,
      id: id == true ? null : this.id,
      name: name,
      timeCreate: timeCreate == true ? null : this.timeCreate,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseEvent _$BaseEventFromJson(Map<String, dynamic> json) => BaseEvent(
      name: json['name'] as String,
      creatorId: json['creatorId'] as String,
      id: json['id'] as String?,
      timeCreate: json['timeCreate'] == null
          ? null
          : DateTime.parse(json['timeCreate'] as String),
    );

Map<String, dynamic> _$BaseEventToJson(BaseEvent instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creatorId': instance.creatorId,
      'timeCreate': instance.timeCreate?.toIso8601String(),
    };
