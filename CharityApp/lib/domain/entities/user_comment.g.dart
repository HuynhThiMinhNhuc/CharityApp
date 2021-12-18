// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserComment _$UserCommentFromJson(Map<String, dynamic> json) => UserComment(
      name: json['name'] as String,
      avatarUri: json['avatarUri'] == null
          ? null
          : Uri.parse(json['avatarUri'] as String),
      content: json['content'] as String,
      timeComment: json['timeComment'] as String,
    );

Map<String, dynamic> _$UserCommentToJson(UserComment instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avatarUri': instance.avatarUri?.toString(),
      'content': instance.content,
      'timeComment': instance.timeComment,
    };
