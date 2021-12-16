// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOverview _$UserOverviewFromJson(Map<String, dynamic> json) => UserOverview(
      name: json['name'],
      avatar: const Uint8ListConverter().fromJson(json['avatar'] as List<int>?),
    )..id = json['id'] as String;

Map<String, dynamic> _$UserOverviewToJson(UserOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': const Uint8ListConverter().toJson(instance.avatar),
    };
