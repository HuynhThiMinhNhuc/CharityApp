// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_overview.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension EventOverviewCopyWith on EventOverview {
  EventOverview copyWith({
    String? avatarUri,
    String? backgroundUri,
    BaseUser? creator,
    String? id,
    String? name,
    List<TagEvent>? tags,
    DateTime? timeCreate,
  }) {
    return EventOverview(
      avatarUri: avatarUri ?? this.avatarUri,
      backgroundUri: backgroundUri ?? this.backgroundUri,
      creator: creator ?? this.creator,
      id: id ?? this.id,
      name: name ?? this.name,
      tags: tags ?? this.tags,
      timeCreate: timeCreate ?? this.timeCreate,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventOverview _$EventOverviewFromJson(Map<String, dynamic> json) =>
    EventOverview(
      name: json['name'] as String,
      creator: json['creator'] == null
          ? null
          : BaseUser.fromJson(json['creator'] as Map<String, dynamic>),
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
    );

Map<String, dynamic> _$EventOverviewToJson(EventOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creator': instance.creator,
      'timeCreate': instance.timeCreate?.toIso8601String(),
      'avatarUri': instance.avatarUri,
      'backgroundUri': instance.backgroundUri,
      'tags': instance.tags,
    };
