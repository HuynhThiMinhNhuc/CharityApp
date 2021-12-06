// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_infor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventInfor _$EventInforFromJson(Map<String, dynamic> json) => EventInfor(
      name: json['name'] as String,
      creator: BaseUser.fromJson(json['creator'] as Map<String, dynamic>),
      avatar: const Uint8ListConverter().fromJson(json['avatar'] as List<int>?),
      background:
          const Uint8ListConverter().fromJson(json['background'] as List<int>?),
      description: json['description'] as String?,
      timeStart: json['timeStart'] as String?,
      numberMember: json['numberMember'] as int? ?? 0,
      numberPost: json['numberPost'] as int? ?? 0,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    )..id = json['id'] as String?;

Map<String, dynamic> _$EventInforToJson(EventInfor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creator': instance.creator,
      'avatar': const Uint8ListConverter().toJson(instance.avatar),
      'background': const Uint8ListConverter().toJson(instance.background),
      'description': instance.description,
      'timeStart': instance.timeStart,
      'numberMember': instance.numberMember,
      'numberPost': instance.numberPost,
      'tags': instance.tags,
    };
