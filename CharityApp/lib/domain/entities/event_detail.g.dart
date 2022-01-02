// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension EventDetailCopyWith on EventDetail {
  EventDetail copyWith({
    BaseUser? creator,
    String? description,
    String? id,
    int? numberMember,
    List<TagEvent>? tags,
    DateTime? timeCreate,
    DateTime? timeStart,
  }) {
    return EventDetail(
      creator: creator ?? this.creator,
      description: description ?? this.description,
      id: id ?? this.id,
      numberMember: numberMember ?? this.numberMember,
      tags: tags ?? this.tags,
      timeCreate: timeCreate ?? this.timeCreate,
      timeStart: timeStart ?? this.timeStart,
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
    );

Map<String, dynamic> _$EventDetailToJson(EventDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator': instance.creator,
      'timeCreate': instance.timeCreate?.toIso8601String(),
      'timeStart': instance.timeStart?.toIso8601String(),
      'numberMember': instance.numberMember,
      'description': instance.description,
      'tags': instance.tags,
    };
