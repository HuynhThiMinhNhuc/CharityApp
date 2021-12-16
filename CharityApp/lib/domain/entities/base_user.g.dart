// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseUser _$BaseUserFromJson(Map<String, dynamic> json) => BaseUser(
      name: json['name'] as String,
    )..id = json['id'] as String;

Map<String, dynamic> _$BaseUserToJson(BaseUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
