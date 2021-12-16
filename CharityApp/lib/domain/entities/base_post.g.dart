// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePost _$BasePostFromJson(Map<String, dynamic> json) => BasePost(
      title: json['title'] as String,
      creator: UserOverview.fromJson(json['creator'] as Map<String, dynamic>),
    )..id = json['id'] as String;

Map<String, dynamic> _$BasePostToJson(BasePost instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'creator': instance.creator,
    };
