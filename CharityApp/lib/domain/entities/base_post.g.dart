// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_post.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension BasePostCopyWith on BasePost {
  BasePost copyWith({
    UserOverview? creator,
    String? eventId,
    String? id,
    String? title,
  }) {
    return BasePost(
      creator: creator ?? this.creator,
      eventId: eventId ?? this.eventId,
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePost _$BasePostFromJson(Map<String, dynamic> json) => BasePost(
      title: json['title'] as String,
      creator: json['creator'] == null
          ? null
          : UserOverview.fromJson(json['creator'] as Map<String, dynamic>),
      eventId: json['eventId'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$BasePostToJson(BasePost instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'eventId': instance.eventId,
      'creator': instance.creator,
    };
