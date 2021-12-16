// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserComment _$UserCommentFromJson(Map<String, dynamic> json) => UserComment(
      name: json['name'] as String,
      avatar: const Uint8ListConverter().fromJson(json['avatar'] as List<int>?),
      content: json['content'] as String,
      timeComment: json['timeComment'] as String,
    )..id = json['id'] as String;

Map<String, dynamic> _$UserCommentToJson(UserComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': const Uint8ListConverter().toJson(instance.avatar),
      'content': instance.content,
      'timeComment': instance.timeComment,
    };
