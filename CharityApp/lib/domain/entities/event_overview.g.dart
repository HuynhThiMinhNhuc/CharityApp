// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventOverview _$EventOverviewFromJson(Map<String, dynamic> json) =>
    EventOverview(
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
    );

Map<String, dynamic> _$EventOverviewToJson(EventOverview instance) =>
    <String, dynamic>{
      'name': instance.name,
      'creator': instance.creator,
      'avatarUri': instance.avatarUri?.toString(),
      'backgroundUri': instance.backgroundUri?.toString(),
    };
