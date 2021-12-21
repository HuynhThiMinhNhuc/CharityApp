// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_infor.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension EventInforCopyWith on EventInfor {
  EventInfor copyWith({
    Uri? avatarUri,
    Uri? backgroundUri,
    BaseUser? creator,
    String? description,
    String? id,
    String? name,
    int? numberMember,
    int? numberPost,
    List<String>? tags,
    String? timeStart,
  }) {
    return EventInfor(
      avatarUri: avatarUri ?? this.avatarUri,
      backgroundUri: backgroundUri ?? this.backgroundUri,
      creator: creator ?? this.creator,
      description: description ?? this.description,
      id: id ?? this.id,
      name: name ?? this.name,
      numberMember: numberMember ?? this.numberMember,
      numberPost: numberPost ?? this.numberPost,
      tags: tags ?? this.tags,
      timeStart: timeStart ?? this.timeStart,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventInfor _$EventInforFromJson(Map<String, dynamic> json) => EventInfor(
      name: json['name'] as String,
      creator: json['creator'] == null
          ? null
          : BaseUser.fromJson(json['creator'] as Map<String, dynamic>),
      avatarUri: json['avatarUri'] == null
          ? null
          : Uri.parse(json['avatarUri'] as String),
      backgroundUri: json['backgroundUri'] == null
          ? null
          : Uri.parse(json['backgroundUri'] as String),
      description: json['description'] as String?,
      timeStart: json['timeStart'] as String?,
      numberMember: json['numberMember'] as int? ?? 0,
      numberPost: json['numberPost'] as int? ?? 0,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      id: json['id'] as String?,
    );

Map<String, dynamic> _$EventInforToJson(EventInfor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creator': instance.creator,
      'avatarUri': instance.avatarUri?.toString(),
      'backgroundUri': instance.backgroundUri?.toString(),
      'description': instance.description,
      'timeStart': instance.timeStart,
      'numberMember': instance.numberMember,
      'numberPost': instance.numberPost,
      'tags': instance.tags,
    };
