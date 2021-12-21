// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_overview.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension UserOverviewCopyWith on UserOverview {
  UserOverview copyWith({
    Uri? avatarUri,
    String? id,
    dynamic? name,
  }) {
    return UserOverview(
      avatarUri: avatarUri ?? this.avatarUri,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOverview _$UserOverviewFromJson(Map<String, dynamic> json) => UserOverview(
      name: json['name'],
      avatarUri: json['avatarUri'] == null
          ? null
          : Uri.parse(json['avatarUri'] as String),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$UserOverviewToJson(UserOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUri': instance.avatarUri?.toString(),
    };
