import 'package:charityapp/domain/entities/base_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_user.g.dart';

@JsonSerializable()
class BaseUser extends BaseObject {
  String name;

  BaseUser({required this.name});

  factory BaseUser.fromJson(Map<String, dynamic> json) => _$BaseUserFromJson(json);
  Map<String, dynamic> toJson() => _$BaseUserToJson(this);
}