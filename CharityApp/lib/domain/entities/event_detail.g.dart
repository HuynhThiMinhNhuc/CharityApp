// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfEventDetail.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfEventDetail.copyWith.fieldName(...)`
class _EventDetailCWProxy {
  final EventDetail _value;

  const _EventDetailCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `EventDetail(...).copyWithNull(...)` to set certain fields to `null`. Prefer `EventDetail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EventDetail(...).copyWith(id: 12, name: "My name")
  /// ````
  EventDetail call({
    BaseUser? creator,
    String? description,
    String? id,
    String? location,
    int? numberMember,
    List<TagEvent>? tags,
    DateTime? timeCreate,
    DateTime? timeStart,
  }) {
    return EventDetail(
      creator: creator ?? _value.creator,
      description: description ?? _value.description,
      id: id ?? _value.id,
      location: location ?? _value.location,
      numberMember: numberMember ?? _value.numberMember,
      tags: tags ?? _value.tags,
      timeCreate: timeCreate ?? _value.timeCreate,
      timeStart: timeStart ?? _value.timeStart,
    );
  }

  EventDetail creator(BaseUser? creator) => creator == null
      ? _value._copyWithNull(creator: true)
      : this(creator: creator);

  EventDetail description(String? description) => description == null
      ? _value._copyWithNull(description: true)
      : this(description: description);

  EventDetail id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  EventDetail location(String? location) => location == null
      ? _value._copyWithNull(location: true)
      : this(location: location);

  EventDetail timeCreate(DateTime? timeCreate) => timeCreate == null
      ? _value._copyWithNull(timeCreate: true)
      : this(timeCreate: timeCreate);

  EventDetail timeStart(DateTime? timeStart) => timeStart == null
      ? _value._copyWithNull(timeStart: true)
      : this(timeStart: timeStart);

  EventDetail numberMember(int numberMember) =>
      this(numberMember: numberMember);

  EventDetail tags(List<TagEvent> tags) => this(tags: tags);
}

extension EventDetailCopyWith on EventDetail {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass EventDetail extends BaseObject.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass EventDetail extends BaseObject.name.copyWith.fieldName(...)`
  _EventDetailCWProxy get copyWith => _EventDetailCWProxy(this);

  EventDetail _copyWithNull({
    bool creator = false,
    bool description = false,
    bool id = false,
    bool location = false,
    bool timeCreate = false,
    bool timeStart = false,
  }) {
    return EventDetail(
      creator: creator == true ? null : this.creator,
      description: description == true ? null : this.description,
      id: id == true ? null : this.id,
      location: location == true ? null : this.location,
      numberMember: numberMember,
      tags: tags,
      timeCreate: timeCreate == true ? null : this.timeCreate,
      timeStart: timeStart == true ? null : this.timeStart,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetail _$EventDetailFromJson(Map<String, dynamic> json) => EventDetail(
      creator: json['creator'] == null
          ? null
          : BaseUser.fromJson(json['creator'] as Map<String, dynamic>),
      description: json['description'] as String?,
      id: json['id'] as String?,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => TagEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      timeCreate: json['timeCreate'] == null
          ? null
          : DateTime.parse(json['timeCreate'] as String),
      timeStart: json['timeStart'] == null
          ? null
          : DateTime.parse(json['timeStart'] as String),
      numberMember: json['numberMember'] as int? ?? 0,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$EventDetailToJson(EventDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator': instance.creator,
      'timeCreate': instance.timeCreate?.toIso8601String(),
      'timeStart': instance.timeStart?.toIso8601String(),
      'numberMember': instance.numberMember,
      'description': instance.description,
      'location': instance.location,
      'tags': instance.tags,
    };
