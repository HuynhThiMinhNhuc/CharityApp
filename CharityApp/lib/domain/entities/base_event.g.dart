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
  }) {
    return BaseEvent(
      creator: creator ?? this.creator,
      id: id ?? this.id,
      name: name ?? this.name,
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
    );

Map<String, dynamic> _$BaseEventToJson(BaseEvent instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creator': instance.creator,
    };
