// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_comment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension UserCommentCopyWith on UserComment {
  UserComment copyWith({
    Uri? avatarUri,
    String? content,
    String? id,
    String? name,
    String? timeComment,
  }) {
    return UserComment(
      avatarUri: avatarUri ?? this.avatarUri,
      content: content ?? this.content,
      id: id ?? this.id,
      name: name ?? this.name,
      timeComment: timeComment ?? this.timeComment,
    );
  }
}

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
      id: json['id'] as String?,
    );

Map<String, dynamic> _$UserCommentToJson(UserComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUri': instance.avatarUri?.toString(),
      'content': instance.content,
      'timeComment': instance.timeComment,
    };
