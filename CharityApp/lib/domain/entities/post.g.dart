// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PostCopyWith on Post {
  Post copyWith({
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
      creator: creator ?? this.creator,
      description: description ?? this.description,
      eventId: eventId ?? this.eventId,
      id: id ?? this.id,
      imagesUri: imagesUri ?? this.imagesUri,
      isLike: isLike ?? this.isLike,
      numberComment: numberComment ?? this.numberComment,
      numberLike: numberLike ?? this.numberLike,
      tags: tags ?? this.tags,
      timeCreate: timeCreate ?? this.timeCreate,
      title: title ?? this.title,
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
