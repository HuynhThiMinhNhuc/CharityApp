// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension BaseUserCopyWith on BaseUser {
  BaseUser copyWith({
    String? id,
    String? name,
  }) {
    return BaseUser(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseUser _$BaseUserFromJson(Map<String, dynamic> json) => BaseUser(
      name: json['name'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$BaseUserToJson(BaseUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
