import 'dart:typed_data';
import 'package:charityapp/core/helper/uint8list_converter.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_overview.g.dart';

@JsonSerializable()
class UserOverview extends BaseUser{
  Uri? avatarUri;

  UserOverview({required name, required this.avatarUri}) : super(name: name);

  factory UserOverview.fromJson(Map<String, dynamic> json) => _$UserOverviewFromJson(json);
  Map<String, dynamic> toJson() => _$UserOverviewToJson(this);
}