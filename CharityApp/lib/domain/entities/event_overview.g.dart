// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_overview.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension EventOverviewCopyWith on EventOverview {
  EventOverview copyWith({
    Uri? avatarUri,
    Uri? backgroundUri,
    BaseUser? creator,
    String? id,
    String? name,
  }) {
    return EventOverview(
      avatarUri: avatarUri ?? this.avatarUri,
      backgroundUri: backgroundUri ?? this.backgroundUri,
      creator: creator ?? this.creator,
      id: id ?? this.id,
      name: name ?? this.name,
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
      avatarUri: json['avatarUri'] == null
          ? null
          : Uri.parse(json['avatarUri'] as String),
      backgroundUri: json['backgroundUri'] == null
          ? null
          : Uri.parse(json['backgroundUri'] as String),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$EventOverviewToJson(EventOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creator': instance.creator,
      'avatarUri': instance.avatarUri?.toString(),
      'backgroundUri': instance.backgroundUri?.toString(),
    };
