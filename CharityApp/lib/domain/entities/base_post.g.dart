// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePost _$BasePostFromJson(Map<String, dynamic> json) => BasePost(
      title: json['title'] as String,
      creator: json['creator'] == null
          ? null
          : UserOverview.fromJson(json['creator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BasePostToJson(BasePost instance) => <String, dynamic>{
      'title': instance.title,
      'creator': instance.creator,
    };
