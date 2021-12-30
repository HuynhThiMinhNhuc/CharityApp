// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_overview.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension UserOverviewCopyWith on UserOverview {
  UserOverview copyWith({
    String? address,
    String? avatarUri,
    String? id,
    dynamic? name,
  }) {
    return UserOverview(
      address: address ?? this.address,
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
      avatarUri: json['avatarUri'] as String?,
      id: json['id'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$UserOverviewToJson(UserOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUri': instance.avatarUri,
      'address': instance.address,
    };
