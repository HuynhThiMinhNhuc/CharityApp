// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension TagEventCopyWith on TagEvent {
  TagEvent copyWith({
    String? id,
    String? name,
  }) {
    return TagEvent(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagEvent _$TagEventFromJson(Map<String, dynamic> json) => TagEvent(
      name: json['name'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$TagEventToJson(TagEvent instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
