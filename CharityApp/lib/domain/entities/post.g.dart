// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

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
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'title': instance.title,
      'creator': instance.creator,
      'imagesUri': instance.imagesUri,
      'description': instance.description,
      'numberComment': instance.numberComment,
      'numberLike': instance.numberLike,
      'tags': instance.tags,
    };
