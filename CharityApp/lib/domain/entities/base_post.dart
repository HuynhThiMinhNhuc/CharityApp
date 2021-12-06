import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/base_object.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_post.g.dart';

@JsonSerializable()
class BasePost extends BaseObject {
  String title;
  UserOverview creator;

  BasePost({required this.title, required this.creator});

  factory BasePost.fromJson(Map<String, dynamic> json) => _$BasePostFromJson(json);
  Map<String, dynamic> toJson() => _$BasePostToJson(this);
}