// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_comment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserComment.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfUserComment.copyWith.fieldName(...)`
class _UserCommentCWProxy {
  final UserComment _value;

  const _UserCommentCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `UserComment(...).copyWithNull(...)` to set certain fields to `null`. Prefer `UserComment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserComment(...).copyWith(id: 12, name: "My name")
  /// ````
  UserComment call({
    String? avatarUri,
    String? content,
    String? id,
    String? name,
    DateTime? timeComment,
  }) {
    return UserComment(
      avatarUri: avatarUri ?? _value.avatarUri,
      content: content ?? _value.content,
      id: id ?? _value.id,
      name: name ?? _value.name,
      timeComment: timeComment ?? _value.timeComment,
    );
  }

  UserComment avatarUri(String? avatarUri) => avatarUri == null
      ? _value._copyWithNull(avatarUri: true)
      : this(avatarUri: avatarUri);

  UserComment id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  UserComment content(String content) => this(content: content);

  UserComment name(String name) => this(name: name);

  UserComment timeComment(DateTime timeComment) =>
      this(timeComment: timeComment);
}

extension UserCommentCopyWith on UserComment {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass UserComment extends BaseObject.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass UserComment extends BaseObject.name.copyWith.fieldName(...)`
  _UserCommentCWProxy get copyWith => _UserCommentCWProxy(this);

  UserComment _copyWithNull({
    bool avatarUri = false,
    bool id = false,
  }) {
    return UserComment(
      avatarUri: avatarUri == true ? null : this.avatarUri,
      content: content,
      id: id == true ? null : this.id,
      name: name,
      timeComment: timeComment,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserComment _$UserCommentFromJson(Map<String, dynamic> json) => UserComment(
      name: json['name'] as String,
      avatarUri: json['avatarUri'] as String?,
      content: json['content'] as String,
      timeComment: DateTime.parse(json['timeComment'] as String),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$UserCommentToJson(UserComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUri': instance.avatarUri,
      'content': instance.content,
      'timeComment': instance.timeComment.toIso8601String(),
    };
