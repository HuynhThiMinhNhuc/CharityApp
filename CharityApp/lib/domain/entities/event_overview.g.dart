// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventOverview _$EventOverviewFromJson(Map<String, dynamic> json) =>
    EventOverview(
      name: json['name'] as String,
      creator: BaseUser.fromJson(json['creator'] as Map<String, dynamic>),
      avatar: const Uint8ListConverter().fromJson(json['avatar'] as List<int>?),
      background:
          const Uint8ListConverter().fromJson(json['background'] as List<int>?),
    )..id = json['id'] as String?;

Map<String, dynamic> _$EventOverviewToJson(EventOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creator': instance.creator,
      'avatar': const Uint8ListConverter().toJson(instance.avatar),
      'background': const Uint8ListConverter().toJson(instance.background),
    };
