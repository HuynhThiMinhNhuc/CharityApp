// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfPost.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfPost.copyWith.fieldName(...)`
class _PostCWProxy {
  final Post _value;

  const _PostCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `Post(...).copyWithNull(...)` to set certain fields to `null`. Prefer `Post(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Post(...).copyWith(id: 12, name: "My name")
  /// ````
  Post call({
    UserOverview? creator,
    String? description,
    String? eventId,
    String? id,
    List<String>? imagesUri,
    bool? isLike,
    int? numberComment,
    int? numberLike,
    List<String>? tags,
    DateTime? timeCreate,
    String? title,
  }) {
    return Post(
      creator: creator ?? _value.creator,
      description: description ?? _value.description,
      eventId: eventId ?? _value.eventId,
      id: id ?? _value.id,
      imagesUri: imagesUri ?? _value.imagesUri,
      isLike: isLike ?? _value.isLike,
      numberComment: numberComment ?? _value.numberComment,
      numberLike: numberLike ?? _value.numberLike,
      tags: tags ?? _value.tags,
      timeCreate: timeCreate ?? _value.timeCreate,
      title: title ?? _value.title,
    );
  }

  Post creator(UserOverview? creator) => creator == null
      ? _value._copyWithNull(creator: true)
      : this(creator: creator);

  Post eventId(String? eventId) => eventId == null
      ? _value._copyWithNull(eventId: true)
      : this(eventId: eventId);

  Post id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  Post timeCreate(DateTime? timeCreate) => timeCreate == null
      ? _value._copyWithNull(timeCreate: true)
      : this(timeCreate: timeCreate);

  Post description(String description) => this(description: description);

  Post imagesUri(List<String> imagesUri) => this(imagesUri: imagesUri);

  Post isLike(bool isLike) => this(isLike: isLike);

  Post numberComment(int numberComment) => this(numberComment: numberComment);

  Post numberLike(int numberLike) => this(numberLike: numberLike);

  Post tags(List<String> tags) => this(tags: tags);

  Post title(String title) => this(title: title);
}

extension PostCopyWith on Post {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass Post extends BasePost.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass Post extends BasePost.name.copyWith.fieldName(...)`
  _PostCWProxy get copyWith => _PostCWProxy(this);

  Post _copyWithNull({
    bool creator = false,
    bool eventId = false,
    bool id = false,
    bool timeCreate = false,
  }) {
    return Post(
      creator: creator == true ? null : this.creator,
      description: description,
      eventId: eventId == true ? null : this.eventId,
      id: id == true ? null : this.id,
      imagesUri: imagesUri,
      isLike: isLike,
      numberComment: numberComment,
      numberLike: numberLike,
      tags: tags,
      timeCreate: timeCreate == true ? null : this.timeCreate,
      title: title,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      title: json['title'] as String,
      creator: json['creator'] == null
          ? null
          : UserOverview.fromJson(json['creator'] as Map<String, dynamic>),
      description: json['description'] as String,
      numberComment: json['numberComment'] as int? ?? 0,
      numberLike: json['numberLike'] as int? ?? 0,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      imagesUri: (json['imagesUri'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      eventId: json['eventId'] as String?,
      id: json['id'] as String?,
      timeCreate: json['timeCreate'] == null
          ? null
          : DateTime.parse(json['timeCreate'] as String),
      isLike: json['isLike'] as bool? ?? false,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'eventId': instance.eventId,
      'creator': instance.creator,
      'timeCreate': instance.timeCreate?.toIso8601String(),
      'imagesUri': instance.imagesUri,
      'description': instance.description,
      'numberComment': instance.numberComment,
      'numberLike': instance.numberLike,
      'isLike': instance.isLike,
      'tags': instance.tags,
    };
