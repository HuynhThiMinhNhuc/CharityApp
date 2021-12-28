// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension BaseEventCopyWith on BaseEvent {
  BaseEvent copyWith({
    BaseUser? creator,
    String? id,
    String? name,
    DateTime? timeCreate,
  }) {
    return BaseEvent(
      creator: creator ?? this.creator,
      id: id ?? this.id,
      name: name ?? this.name,
      timeCreate: timeCreate ?? this.timeCreate,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseEvent _$BaseEventFromJson(Map<String, dynamic> json) => BaseEvent(
      name: json['name'] as String,
      creator: json['creator'] == null
          ? null
          : BaseUser.fromJson(json['creator'] as Map<String, dynamic>),
      id: json['id'] as String?,
      timeCreate: json['timeCreate'] == null
          ? null
          : DateTime.parse(json['timeCreate'] as String),
    );

Map<String, dynamic> _$BaseEventToJson(BaseEvent instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creator': instance.creator,
      'timeCreate': instance.timeCreate?.toIso8601String(),
    };
