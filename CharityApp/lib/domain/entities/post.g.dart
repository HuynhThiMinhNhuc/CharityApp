// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      title: json['title'] as String,
      description: json['description'] as String,
      numberComment: json['numberComment'] as int? ?? 0,
      numberLike: json['numberLike'] as int? ?? 0,
    )..id = json['id'] as String?;

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'numberComment': instance.numberComment,
      'numberLike': instance.numberLike,
    };
