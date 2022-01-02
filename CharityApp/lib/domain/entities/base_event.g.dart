// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension BaseEventCopyWith on BaseEvent {
  BaseEvent copyWith({
    String? creatorId,
    String? id,
    String? name,
    DateTime? timeCreate,
  }) {
    return BaseEvent(
      creatorId: creatorId ?? this.creatorId,
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
      creatorId: json['creatorId'] as String,
      id: json['id'] as String?,
      timeCreate: json['timeCreate'] == null
          ? null
          : DateTime.parse(json['timeCreate'] as String),
    );

Map<String, dynamic> _$BaseEventToJson(BaseEvent instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creatorId': instance.creatorId,
      'timeCreate': instance.timeCreate?.toIso8601String(),
    };
