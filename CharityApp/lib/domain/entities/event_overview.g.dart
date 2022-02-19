// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_overview.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfEventOverview.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfEventOverview.copyWith.fieldName(...)`
class _EventOverviewCWProxy {
  final EventOverview _value;

  const _EventOverviewCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `EventOverview(...).copyWithNull(...)` to set certain fields to `null`. Prefer `EventOverview(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EventOverview(...).copyWith(id: 12, name: "My name")
  /// ````
  EventOverview call({
    String? avatarUri,
    String? backgroundUri,
    String? creatorId,
    String? id,
    String? name,
    int? numberMember,
    int? numberPost,
    List<TagEvent>? tags,
    DateTime? timeCreate,
  }) {
    return EventOverview(
      avatarUri: avatarUri ?? _value.avatarUri,
      backgroundUri: backgroundUri ?? _value.backgroundUri,
      creatorId: creatorId ?? _value.creatorId,
      id: id ?? _value.id,
      name: name ?? _value.name,
      numberMember: numberMember ?? _value.numberMember,
      numberPost: numberPost ?? _value.numberPost,
      tags: tags ?? _value.tags,
      timeCreate: timeCreate ?? _value.timeCreate,
    );
  }

  EventOverview avatarUri(String? avatarUri) => avatarUri == null
      ? _value._copyWithNull(avatarUri: true)
      : this(avatarUri: avatarUri);

  EventOverview backgroundUri(String? backgroundUri) => backgroundUri == null
      ? _value._copyWithNull(backgroundUri: true)
      : this(backgroundUri: backgroundUri);

  EventOverview id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  EventOverview timeCreate(DateTime? timeCreate) => timeCreate == null
      ? _value._copyWithNull(timeCreate: true)
      : this(timeCreate: timeCreate);

  EventOverview creatorId(String creatorId) => this(creatorId: creatorId);

  EventOverview name(String name) => this(name: name);

  EventOverview numberMember(int numberMember) =>
      this(numberMember: numberMember);

  EventOverview numberPost(int numberPost) => this(numberPost: numberPost);

  EventOverview tags(List<TagEvent> tags) => this(tags: tags);
}

extension EventOverviewCopyWith on EventOverview {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass EventOverview extends BaseEvent.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass EventOverview extends BaseEvent.name.copyWith.fieldName(...)`
  _EventOverviewCWProxy get copyWith => _EventOverviewCWProxy(this);

  EventOverview _copyWithNull({
    bool avatarUri = false,
    bool backgroundUri = false,
    bool id = false,
    bool timeCreate = false,
  }) {
    return EventOverview(
      avatarUri: avatarUri == true ? null : this.avatarUri,
      backgroundUri: backgroundUri == true ? null : this.backgroundUri,
      creatorId: creatorId,
      id: id == true ? null : this.id,
      name: name,
      numberMember: numberMember,
      numberPost: numberPost,
      tags: tags,
      timeCreate: timeCreate == true ? null : this.timeCreate,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventOverview _$EventOverviewFromJson(Map<String, dynamic> json) =>
    EventOverview(
      name: json['name'] as String,
      creatorId: json['creatorId'] as String,
      avatarUri: json['avatarUri'] as String?,
      backgroundUri: json['backgroundUri'] as String?,
      id: json['id'] as String?,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => TagEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      timeCreate: json['timeCreate'] == null
          ? null
          : DateTime.parse(json['timeCreate'] as String),
      numberMember: json['numberMember'] as int? ?? 0,
      numberPost: json['numberPost'] as int? ?? 0,
    );

Map<String, dynamic> _$EventOverviewToJson(EventOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creatorId': instance.creatorId,
      'timeCreate': instance.timeCreate?.toIso8601String(),
      'avatarUri': instance.avatarUri,
      'backgroundUri': instance.backgroundUri,
      'tags': instance.tags,
      'numberMember': instance.numberMember,
      'numberPost': instance.numberPost,
    };
