// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_overview.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension EventOverviewCopyWith on EventOverview {
  EventOverview copyWith({
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
      avatarUri: avatarUri ?? this.avatarUri,
      backgroundUri: backgroundUri ?? this.backgroundUri,
      creatorId: creatorId ?? this.creatorId,
      id: id ?? this.id,
      name: name ?? this.name,
      numberMember: numberMember ?? this.numberMember,
      numberPost: numberPost ?? this.numberPost,
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
